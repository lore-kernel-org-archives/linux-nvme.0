From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 25 Jun 2018 01:39:31 -0400
Subject: [PATCH V2 0/2] nvmet: implement flush all support
Message-ID: <20180625053933.14967-1-chaitanya.kulkarni@wdc.com>

Hi,

This implements the flush command behavior described in
"NVMe 1.3a  TP 4035" for NSID value of FFFFFFFFh. Now flush command
applies to all the namespaces attached to the controller processing the
Flush command when the value 0xFFFFFFFF is set in the NSID field. 

Regards,
Chaitanya

Changes Since V1 :-
1. Use system workqueues and parallelize the flush command submission.
2. Incorporate the coding style changes suggested by Sagi.
3. Add a new struct nvmet_subsys member to keep track of the active
   namespace belongs to a subsystem.

Chaitanya Kulkarni (2):
  nvmet: move struct work_struct out of union
  nvmet: implement flush all support

 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/core.c        | 70 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c | 29 ++++++++++++-
 drivers/nvme/target/io-cmd-file.c | 38 +++++++++++------
 drivers/nvme/target/nvmet.h       | 24 +++++++++--
 5 files changed, 145 insertions(+), 18 deletions(-)

-- 
2.17.0
