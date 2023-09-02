import sys, build, clean

args = sys.argv[1:]

if len(args) == 1:
    if args[0] == "build":
        build._build()
    elif args[0] == "clean":
        clean._clean()
    else:
        print("Invalid argument.")
else:
    print("Invalid argument count. Expected 1. (build, clean)")