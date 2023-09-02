import subprocess

def _command_exists(command):
    return subprocess.call(f"which {command}", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE) == 0