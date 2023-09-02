import os, sys

BUILD_DIR = "dist"
OS_NAME = "AlveniaOS"

sys.path.append(os.path.join(os.path.dirname(__file__), ".."))

def _clean():
    try: 
        for f in os.listdir(BUILD_DIR):
            os.remove(os.path.join(BUILD_DIR, f))
        
        os.remove(f"{OS_NAME}.iso")
    except:
        pass

if __name__ == "__main__":
    _clean()