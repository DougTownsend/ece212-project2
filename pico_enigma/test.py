"""Runs every testbench in the test directory and compares the results to the
solution outputs, the same way the autograder does.

Run this from the pico_enigma or fpga_enigma directory:
    python3 test.py            (Mac and Linux)
    python test.py             (Windows)

To run only the tests for one module, give its name:
    python3 test.py negate
"""
import os
import subprocess
import sys

# Test name and points, in the same order as the autograder.
TESTS = [
    ("test_1_0_negate", 2), ("test_1_1_negate", 2), ("test_1_2_negate", 2),
    ("test_2_0_sbox", 2), ("test_2_1_sbox", 2), ("test_2_2_sbox", 2),
    ("test_3_0_xorshift798", 3), ("test_3_1_xorshift798", 3),
    ("test_3_2_xorshift798", 3), ("test_3_3_xorshift798", 3),
    ("test_4_0_ones_comp_add", 2), ("test_4_1_ones_comp_add", 2),
    ("test_4_2_ones_comp_add", 2),
    ("test_5_0_enigma", 3), ("test_5_1_enigma", 3), ("test_5_2_enigma", 3),
    ("test_5_3_enigma", 3), ("test_5_4_enigma", 3),
    ("test_6_0_sevseg_disp", 2), ("test_6_1_sevseg_disp", 2), ("test_6_2_sevseg_disp", 2),
    ("test_7_0_swap", 2), ("test_7_1_swap", 2), ("test_7_2_swap", 2),
    ("test_8_0_main", 3), ("test_8_1_main", 3), ("test_8_2_main", 2),
    ("test_8_3_main", 2), ("test_8_4_main", 3),
]


def describe(header, line):
    if line is None:
        return "(no more lines)"
    return ", ".join("{}={}".format(h, v) for h, v in zip(header.split(","), line.split(",")))


def run_test(name):
    """Returns (passed, message)."""
    result_file = os.path.join("test", "results", name + ".txt")
    if os.path.exists(result_file):
        os.remove(result_file)

    try:
        res = subprocess.run(["apio", "sim", "-n", "test/" + name + "_tb.v"],
                             capture_output=True, text=True, timeout=60)
    except subprocess.TimeoutExpired:
        return False, ("The simulation did not finish within 60 seconds. This usually\n"
                       "means your design has a combinational loop.")

    if not os.path.exists(result_file):
        return False, ("The simulation did not run. Check your code for errors.\n"
                       "Apio output:\n" + res.stdout + res.stderr)

    with open(result_file) as f:
        yours = f.read().splitlines()
    with open(os.path.join("test", "results", name + "_soln.txt")) as f:
        correct = f.read().splitlines()

    if yours == correct:
        return True, ""

    header = correct[0]
    for k in range(1, max(len(yours), len(correct))):
        y = yours[k] if k < len(yours) else None
        c = correct[k] if k < len(correct) else None
        if y != c:
            return False, ("First difference is on line {} of {}:\n"
                           "  Expected:    {}\n"
                           "  Your design: {}".format(k + 1, result_file,
                                                      describe(header, c), describe(header, y)))
    return False, "The header line of {} does not match.".format(result_file)


def main():
    if not os.path.isdir("test"):
        print("Run this script from the pico_enigma or fpga_enigma directory.")
        return

    tests = TESTS
    if len(sys.argv) > 1:
        tests = [(n, p) for n, p in TESTS if n.split("_", 3)[3] == sys.argv[1]]
        if not tests:
            print("No tests for a module named '{}'.".format(sys.argv[1]))
            return

    # apio skips simulations it thinks are up to date, which would leave
    # no result file to compare. Cleaning first makes every test run.
    subprocess.run(["apio", "clean"], capture_output=True)

    score = 0
    total = 0
    for name, points in tests:
        passed, msg = run_test(name)
        total += points
        if passed:
            score += points
            print("PASS  {:<24} {}/{}".format(name, points, points))
        else:
            print("FAIL  {:<24} 0/{}".format(name, points))
            print("      " + msg.replace("\n", "\n      "))
    print()
    print("Score: {}/{}".format(score, total))


if __name__ == "__main__":
    main()
