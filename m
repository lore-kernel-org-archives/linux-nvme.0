From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 14 Apr 2014 02:22:04 -0400
Subject: [PATCH] NVMe: Change how aborts are handled
In-Reply-To: <1397409133-18140-1-git-send-email-matthew.r.wilcox@intel.com>
References: <1397409133-18140-1-git-send-email-matthew.r.wilcox@intel.com>
Message-ID: <20140414062204.GB21460@linux.intel.com>

On Sun, Apr 13, 2014@01:12:13PM -0400, Matthew Wilcox wrote:
> Instead of keeping a bit per command in the nvme_cmd_info (which
> grows the nvme_queue by 4k), encode the fact that the command has been
> aborted using special CMD_CTX_ values.  Give the abort command its own
> handler instead of using special_completion for it.  Factor out
> set_cmdid_special() from free_cmdid() and cancel_cmdid, then use it
> to transition from ABORTED to ABORT_COMPLETED.

Found a bug; lock_nvmeq() can return NULL.  If it does, there's really
nothing for us to do ... the queue has gone, we can't do anything to
note that the abort succeeded or failed.  Just exit:

+++ b/drivers/block/nvme-core.c
@@ -1084,11 +1084,14 @@ static bool abort_completion(struct nvme_queue *adminq, 
        int cmdid = (unsigned long)ctx & 0xffff;
 
        struct nvme_queue *ioq = lock_nvmeq(dev, qid);
+       if (!ioq)
+               goto out;
        if ((cqe->result & 1) || is_aborted_and_completed(ioq, cmdid)) {
                free_cmdid(ioq, cmdid, NULL);
        } else {
                cancel_cmdid(ioq, cmdid, NULL);
        }
+ out:
        unlock_nvmeq(ioq);
        ++dev->abort_limit;
        return true;

Should I also be checking q_suspended?  I don't think so ... q_suspended
seems to be about not submitting more I/O.
