From: olivier.mallinger@ip-maker.com (Olivier Mallinger - IP Maker)
Date: Thu, 23 May 2013 16:29:15 +0200
Subject: Using FIO tool for performance measure
Message-ID: <519E27BB.20009@ip-maker.com>

Hello.

I have a NVMe controller running on FPGA.
I use Linux Fedora 17 as OS with a core 3.8.4.
The driver is loaded at startup and the NVMe device is recognize without 
any problem (/dev/nvme0n1).
I am able to perform read and write I/O commands.

The problem occurs when i tried to use FIO to measure performance 
(Bandwith, latency and IOPS).
I attached my FIO script.
The performance are poor using a PCIeGen2x4 interface. I monitored 
what's happening inside the controller's hardware and everything works 
fine as it spends time waiting for submission tail update...
FIO seems not using well the queue depth and instead of pushing commands 
into the queue, it waits for command's end before sending a new one.
I try different version of FIO without success (2.0.9, 2.0.13 and 2.0.15).

Did someone already experiment such problem using FIO ? Is there any 
missing option inside my script ?

Thanks for your help.
Regards,
Olivier.
-------------- next part --------------
[global]
ioengine=libaio
iodepth=32
direct=1
size=32m
filename=/dev/nvme0n1

[seq_rd]
name=seq_rd
rw=read
bs=4k
stonewall

[seq_wr]
name=seq_wr
rw=write
bs=4k
stonewall

[rand_rd]
name=rand_rd
rw=randread
bs=4k
stonewall

[rand_wr]
name=rand_wr
rw=randwrite
bs=4k
stonewall

-------------- next part --------------
A non-text attachment was scrubbed...
Name: olivier_mallinger.vcf
Type: text/x-vcard
Size: 316 bytes
Desc: not available
URL: <http://merlin.infradead.org/pipermail/linux-nvme/attachments/20130523/9829a671/attachment.vcf>
