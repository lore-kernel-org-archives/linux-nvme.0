From: patrick.sheridan@seagate.com (Patrick Sheridan)
Date: Fri, 7 Oct 2016 15:15:26 -0600
Subject: nvme_admin_passthru DMA failure
Message-ID: <CAEhN9jtotCMNBt9Oy7M_HDe_oqDHoMegf+trki+2255gyfoO0g@mail.gmail.com>

There is a problem when using an NVME_IOCTL_ADMIN_CMD to submit an
nvme_admin_passthru struct such that user data
(nvme_passthru_cmd.addr) does not get DMA'd to the drive correctly.

The problem first appeared in kernel tags/v4.5.1 and was absent in
tags/v4.5.  The only relevant difference between those was in
block/blk-core.c, so this is likely a block layer problem:

diff --git a/block/blk-core.c b/block/blk-core.c
index b83d297..45f4d7e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2198,7 +2198,7 @@ int blk_insert_cloned_request(struct
request_queue *q, struct request *rq)
        if (q->mq_ops) {
                if (blk_queue_io_stat(q))
                        blk_account_io_start(rq, true);
-               blk_mq_insert_request(rq, false, true, true);
+               blk_mq_insert_request(rq, false, true, false);
                return 0;
        }

Reverting the blk_mq_insert_request to use async = true resolves the
issue in 4.5.1, but the latest (sha:  c8d2bc9) no longer uses this
pathway.

There's been a lot of changes since 4.5.1, so I haven't been able to
pin down where the problem is, and would appreciate any help.

Regards,
Patrick

---
Patrick Sheridan, PhD
Senior Engineer
Seagate Technology
389 Disc Dr. Longmont, CO 80503
