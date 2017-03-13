From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Mar 2017 13:08:07 +0200
Subject: [PATCH] nvmet-rdma: Fix a possible uninitialized variable
 dereference
In-Reply-To: <1489403135-12774-1-git-send-email-sagi@grimberg.me>
References: <1489403135-12774-1-git-send-email-sagi@grimberg.me>
Message-ID: <30a38752-73f3-bcb2-9c8e-684ddd2b2178@grimberg.me>



On 13/03/17 13:05, Sagi Grimberg wrote:
> When handling a new recv command, we grab a new rsp resource and
> check for the queue state being live. In case the queue is not in
> live state, we simply restore the rsp back to the free list. However
> in this flow we didn't set rsp->queue yet, so we cannot dereference it.
>
> Instead, get rid of rsp->queue, because we already have rsp->cmd
> reference which has a queue reference already, so use that instead.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

This is missing of course:

Reported-by: Yi Zhang <yizhan at redhat.com>
Reported-by: Raju Rangoju <rajur at chelsio.com>

Thanks Yi and Raju for reporting.

Please let us know if we can add your "Tested-by" tag.
