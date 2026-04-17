from fastapi import FastAPI
from router import ssh

app = FastAPI()

# 🌐 ISP
@app.post("/isp")
def isp():
    return {"result": ssh("ip route replace default dev GigabitEthernet0/Vlan4")}

# 🔐 VPN1
@app.post("/vpn1")
def vpn1():
    return {"result": ssh("ip route replace default dev Wireguard1")}

# 🔐 VPN2
@app.post("/vpn2")
def vpn2():
    return {"result": ssh("ip route replace default dev Wireguard2")}

# 📊 status
@app.get("/status")
def status():
    return {"result": ssh("ip route")}
