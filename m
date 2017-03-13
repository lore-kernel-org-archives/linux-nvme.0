From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Mar 2017 15:38:20 +0200
Subject: [PATCH] nvmet-rdma: Fix a possible uninitialized variable
 dereference
In-Reply-To: <1489403135-12774-1-git-send-email-sagi@grimberg.me>
References: <1489403135-12774-1-git-send-email-sagi@grimberg.me>
Message-ID: <2074844b-1801-937a-cc8a-466abea6423a@grimberg.me>

> When handling a new recv command, we grab a new rsp resource and
> check for the queue state being live. In case the queue is not in
> live state, we simply restore the rsp back to the free list. However
> in this flow we didn't set rsp->queue yet, so we cannot dereference it.
>
> Instead, get rid of rsp->queue, because we already have rsp->cmd
> reference which has a queue reference already, so use that instead.

OK this breaks the srq case. for SRQ we repost the cmd before we release
the response (which on the send completion), the cmd can later serve
a different queue so we can end up mess up if we reference
rsp->cmd->queue...

Sending a v2 to fix.
