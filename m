From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Mon, 26 Sep 2016 11:25:54 -0700
Subject: [PATCH 0/9] Introduce blk_quiesce_queue() and blk_resume_queue()
Message-ID: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>

Hello Jens,

Multiple block drivers need the functionality to stop a request queue 
and to wait until all ongoing request_fn() / queue_rq() calls have 
finished without waiting until all outstanding requests have finished. 
Hence this patch series that introduces the blk_quiesce_queue() and 
blk_resume_queue() functions. The dm-mq, SRP and nvme patches in this 
patch series are three examples of where these functions are useful. 
These patches apply on top of the September 21 version of your 
for-4.9/block branch. The individual patches in this series are:

0001-blk-mq-Introduce-blk_mq_queue_stopped.patch
0002-dm-Fix-a-race-condition-related-to-stopping-and-star.patch
0003-RFC-nvme-Use-BLK_MQ_S_STOPPED-instead-of-QUEUE_FLAG_.patch
0004-block-Move-blk_freeze_queue-and-blk_unfreeze_queue-c.patch
0005-block-Extend-blk_freeze_queue_start-to-the-non-blk-m.patch
0006-block-Rename-mq_freeze_wq-and-mq_freeze_depth.patch
0007-blk-mq-Introduce-blk_quiesce_queue-and-blk_resume_qu.patch
0008-SRP-transport-Port-srp_wait_for_queuecommand-to-scsi.patch
0009-RFC-nvme-Fix-a-race-condition.patch

Thanks,

Bart.
