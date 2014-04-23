From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 23 Apr 2014 15:55:37 -0400
Subject: [PATCH] NVMe: Change how aborts are handled
In-Reply-To: <alpine.LRH.2.03.1404170919020.7391@AMR>
References: <1397409133-18140-1-git-send-email-matthew.r.wilcox@intel.com>
 <alpine.LRH.2.03.1404170919020.7391@AMR>
Message-ID: <20140423195537.GH13050@linux.intel.com>

On Thu, Apr 17, 2014@09:29:54AM -0600, Keith Busch wrote:
> On Sun, 13 Apr 2014, Matthew Wilcox wrote:
> >+static void abort_cmdid(struct nvme_queue *nvmeq, u16 cmdid)
> >+{
> >+	void *ctx;
> >+	nvme_completion_fn fn;
> >+	static struct nvme_completion cqe = {
> >+		.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
> >+	};
> >+
> >+	ctx = cancel_cmdid(nvmeq, cmdid, &fn);
> >+	if (fn(nvmeq, ctx, &cqe))
> >+		clear_bit(cmdid, nvmeq->cmdid_data);
> >+}
> 
> I don't think you want to clear the cmdid bit here. The above internally
> completes the command as failed, but the controller still technically
> owns the cmdid and may still return completion status for it, so we
> don't want to make this cmdid available for reuse just yet.

Ah, right, good point.

> We also don't want to leak the cmdid forever either. The existing method
> will consider the controller being failed and reset it so we can reclaim
> missing cmdids. This new way doesn't appear to reset the controller
> if a command is never returned. At the very least, we probably need to
> delete and recreate the IO queue it's associated with if not go straight
> to the full controller reset.

Yes, resetting the queue will eventually be necessary, and if that
fails we'll need to reset the entire controller.  As I understood the
way things worked before, you gave the controller an extra 60 seconds,
and if it didn't respond in that time, you reset the controller.  We can
use a more explicit timer, perhaps.

> Since the "aborted" flag in nvme_cmd_info adds 4k per queue, maybe we
> can use the lower bits of the "ctx" for this flag instead, and have the
> callbacks mask it off to retrieve the true context? The lower two bits
> should never be in use if I'm not mistaken.

Could do ... I used to do that earlier for indexing into the completion
functions.  Then we needed more than 4, so I gave up on that.  We could
go that path for aborting commands, though I think we'll need to use
two bits to indicate "normal", "abort sent", and "completion received
after abort sent, but abort command not completed yet".
