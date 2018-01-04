From: alex.nlnnfn@gmail.com (Alex Nln)
Date: Thu, 4 Jan 2018 09:13:50 -0800
Subject: nvme performance using old blk vs blk-mq, single thread
Message-ID: <20180104091350.2e6128477f81499a4c233a68@gmail.com>

Hello,

I am testing nvme devices and I found that there is about 15% degradation 
in performance of a single threaded application when using blk-mq,
comparing to same application running on kernel with old blk layer.

I use fio-2.2.10, 4k block size, libaio, sequential reads, single thread.

Results for Intel DC P3600 400GB NVMe SSD, drive was natively formatted 
to 512B and brought to the steady state before test.

# kernel version  kIOPS
4.14.11-vanilla     163
3.19.0-vanilla      167
3.18.1-vanilla      196
3.16.0-34-generic   193

196K IOPS in 3.18.1 drops to 167K IOPS in 3.19.0

It looks like between 3.8.1 and 3.19.0 the major change related to nvme 
was conversion of nvme to use blk-mq
Commit a4aea5623d4a54682b6ff5c18196d7802f3e478f  
NVMe: Convert to blk-mq


Just to verify my results I did more tests on different server with different 
NVMe disk HGST SN200 800GB

# kernel version     kIOPS 
4.10.0-42-generic    330
3.16.0-34-generic    375


I would like to ask if this is a known issue or there is something 
wrong in my setup? There was a similar thread about the same issue while ago 
in this list but there was no conclusion.


My fio file:

[global]
iodepth=128
direct=1
ioengine=libaio
group_reporting
time_based
runtime=60
filesize=32G

[job1]
rw=read
filename=/dev/nvme0n1p1
name=raw=sequential-read
numjobs=1


Thanks,
Alex
