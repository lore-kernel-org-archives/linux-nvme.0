From: bdeyal@gmail.com (Eyal BenDavid)
Date: Thu, 31 Jan 2019 16:09:18 +0200
Subject: Question about ioctl interface - IO passthru
Message-ID: <CAPrnrPBpcuh2r40Bxzrq=PmDAaemnOvd4Or2nKFCannQ6oGkGg@mail.gmail.com>

Hi,

I wrote a small program to perform IOs based on the ioctl interface
from linux_ioctl.h and code from nvme-cli.

Specifically I wrote this function for write zero (code is used in
stress and verification testing).
Note that this is C++ (only difference is the default values for
function arguments)

====
int nvme_io_passthru(int      fd,
                     uint32_t nsid,
                     uint8_t  opcode,
                     uint64_t slba,
                     uint16_t nblocks,
                     void*    data = NULL,
                     uint32_t dlen = 0,
                     uint8_t  flags = 0,
                     uint32_t timeout = 30000,
                     uint16_t control = 0,
                     uint32_t reftag = 0,
                     uint16_t apptag = 0,
                     uint16_t appmask = 0)
{
    struct nvme_passthru_cmd cmd;
    memset(&cmd, 0, sizeof(cmd));

    cmd.opcode     = opcode;
    cmd.flags      = flags;
    cmd.nsid       = nsid;
    cmd.addr       = (uint64_t)(uintptr_t) data;
    cmd.data_len   = dlen;
    cmd.cdw10      = (slba & 0xffffffff);
    cmd.cdw11      = (slba >> 32);
    cmd.cdw12      = (nblocks | (control << 16));
    cmd.cdw14      = reftag;
    cmd.cdw15      = (apptag | (appmask << 16));
    cmd.timeout_ms = timeout;

    return ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
}
====

To my surprise the function worked fine not only with write zero but
with other IO opcodes (read, write, compare)
The advantage is now I control the timeout value in IO commands!

What is the difference from using "nvme_user_io" structure?
Is it safe to use this version of IO commands?

Thanks!
Eyal BD.
