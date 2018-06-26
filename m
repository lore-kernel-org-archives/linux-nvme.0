From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 26 Jun 2018 18:17:15 -0400
Subject: [PATCH V4 0/2] nvmet: implement flush all support 
Message-ID: <20180626221717.19992-1-chaitanya.kulkarni@wdc.com>

Hi,

This implements the flush command behavior described in
"NVMe 1.3a  TP 4035" for NSID value of FFFFFFFFh. Now flush command
applies to all the namespaces attached to the controller processing the
Flush command when the value 0xFFFFFFFF is set in the NSID field. 

Regards,
Chaitanya

Changes since V3 :-
1. Restructure the nvmet_flush_all_work() and incorporate changes
   suggested by Sagi.
2. Execute the flush command for bdev in worker thread context.
3. Remove the nvmet_bdev_init_flush_bio() introduced in earlier
   patch and call nvmet_bdev_execute_flush() directly from
   nvmet_bdev_flush_work().

Changes since V2 :-
1. Remove the nvmet_flush_work struct and use the nvmet_req directly.
2. Small cleanups.
3. Use system workqueue instead of high priority system workqueue.
4. Flush each work as iterate.
5. Don't use worker thred context for block device flush (submit_bio()).
6. Add error message if flush fails.
7. Remove the space/tab formatting in the preparation patch.

Changes since V1 :-
1. Use system workqueues and parallelize the flush command submission.
2. Incorporate the coding style changes suggested by Sagi.
3. Add a new struct nvmet_subsys member to keep track of the active
   namespace belongs to a subsystem.

Chaitanya Kulkarni (2):
  nvmet: move struct work_struct out of union
  nvmet: add support for flush all

 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/core.c        | 89 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c | 17 +++++-
 drivers/nvme/target/io-cmd-file.c | 33 +++++++-----
 drivers/nvme/target/nvmet.h       | 12 ++++-
 5 files changed, 135 insertions(+), 18 deletions(-)

-- 
2.17.0
