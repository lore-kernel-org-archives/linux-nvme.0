From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 May 2019 20:21:04 -0700
Subject: [PATCH RFC 0/4] nvmet: add support for port based io priority
Message-ID: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>

Hi all,

This is a small patch series which adds the support for port-based
ioprio field so that user on the NVMeOF target side can set the desired
io priority from the configfs.

For each request, we derived the io priority value from port associated
with the request for bio (bdev) and kiocb (file).

In this way, the target side can prioritize the port and eventually the
io request if the scheduler (BFQ) is in the picture. 

This is useful in the following scenarion where:-

Port 1-------> NVMeOF Ctrl1 ------>  NSID1______
                                                |------> ----------------------
                                                         | Actual Namesapce A |
                                          ______|------> ----------------------
Port 2-------> NVMeOF Ctrl2 ------>  NSID2

Any feedback is welcome, I'd like to understand if this approach is desirable,
if not then what is the right way to use the io priorities on that target side
so that NVMeOF target can take advantage of the scheduler infrastructure ?

Regards,
Chaitanya

Chaitanya Kulkarni (4):
  nvmet: add iopriority definitions for port
  nvmet: allow user to specify ioprioty from cfgfs
  nvmet: set iopriority for each bio
  nvmet: set iopriority for each kiocb for file

 drivers/nvme/target/configfs.c    | 76 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c |  1 +
 drivers/nvme/target/io-cmd-file.c |  1 +
 drivers/nvme/target/nvmet.h       |  3 ++
 4 files changed, 81 insertions(+)

-- 
2.17.0
