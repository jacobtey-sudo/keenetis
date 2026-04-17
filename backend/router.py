import subprocess
from config import *

def ssh(cmd: str):
    full = f'ssh -p {ROUTER_SSH_PORT} {ROUTER_USER}@{ROUTER_HOST} "{cmd}"'
    return subprocess.check_output(full, shell=True).decode()
