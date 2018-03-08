From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 8 Mar 2018 21:11:51 +0800
Subject: [PATCH V4 2/5] nvme: add helper interface to flush in-flight
 requests
In-Reply-To: <1520489971-31174-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <1520489971-31174-3-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <CACVXFVPWLu8son4UgnXCH4XGFmLt9x6BYbQqYVG4wSk_Or+WmQ@mail.gmail.com>

On Thu, Mar 8, 2018 at 2:19 PM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> Currently, we use nvme_cancel_request to complete the request
> forcedly. This has following defects:
>  - It is not safe to race with the normal completion path.
>    blk_mq_complete_request is ok to race with timeout path,
>    but not with itself.

The irq path shouldn't be raced with nvme_cancel_request()
because io queues are suspended before calling nvme_cancel_request().

Could you please explain a bit why one same request can be
completed at the same time via blk_mq_complete_request()?

>  - Cannot ensure all the requests have been handled. The timeout
>    path may grab some expired requests, blk_mq_complete_request
>    cannot touch them.
>
> add two helper interface to flush in-flight requests more safely.
> - nvme_abort_requests_sync
> use nvme_abort_req to timeout all the in-flight requests and wait
> until timeout work and irq completion path completes. More details
> please refer to the comment of this interface.
> - nvme_flush_aborted_requests
> complete the requests 'aborted' by nvme_abort_requests_sync. It will
> be invoked after the controller is disabled/shutdown.

IMO, the helper's name of 'abort' is very misleading since the request
isn't aborted actually, it is just cancelled from dispatched state, once
it is cancelled, most of times the request is just re-inserted to sw
queue or scheduler queue. After NVMe controller is resetted successfully,
these request will be dispatched again.

So please keep the name of 'cancel' or use sort of name.

Thanks,
Ming Lei
