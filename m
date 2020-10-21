Return-Path: <SRS0=B+Fz=D4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13FEC561F8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 08:53:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E364421D6C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 08:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TmWGHP9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E364421D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CYI9OqgxRzY9AX+/++VsQzyx2+b7pxL0+B8cSDPnkQE=; b=TmWGHP9XAezd6dxlzzAUld3aO
	31UmazuIShv/AflwphPn5cN9nhqgN2oIa7rLjbLgFsDhbZdBQeahhwLYeLJ2XKLjEu84rCg10b9i4
	Zotk2fVWqbHQWFsYWjVqEaN0oAYgGxWRuiSdGO2+h7VjLRRgH/Yk1svuF08O3xPzYxknO3PzAnOCm
	JsoTE/zBezijKiA7NC/hoeLsYkcfoQy4r98EX311hnweuifGzOPMTcg/lzhSRMkWq6kP0ls2BfaCM
	HXH7ENeNxwmouEbzjZYiMjkgkrREGhkOC25IMgrOiqR7HElCnVFJjPew1FifveumKIjnMjbxDYz44
	1xOXDtO9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kV9ry-0008En-B7; Wed, 21 Oct 2020 08:53:18 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kV9rv-0008Dg-Ey
 for linux-nvme@lists.infradead.org; Wed, 21 Oct 2020 08:53:16 +0000
Received: by mail-wr1-f65.google.com with SMTP id s9so2059859wro.8
 for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2020 01:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=3+xG9e1zaehA8fJfBfNW/G5SEbAljV56owwoJnpHk/o=;
 b=KEcH7Ef+pDzPGM066mwst82sWYEO8J+fdMfaRScV5oiNCy3GaE0x/3eJBvtLSVV4oF
 4Gyqi31+O4AvvO6YUfrqwkO3790qtZt/gD50VstysStIViGA4okV+l7lvVd7N/Uw+fKL
 p0nf4+qchKgu6QcYjQpZiZl9vJ3dhktWARfBsHsbYIU2zfQrtmwFCOUSOHhoibDhNmO2
 9R5GLncmWSzJnRRE7BKYqftoQauSVahfo7kFYVVrpOiRwqqJszdy0WBGVaXoZ4K0bwdX
 EXGjyFb8HmSXMTZ5Q61p3xbPsMz0twuDVccU4RhFPB9RBxyHo54IonAK/I3ZBrzkt6M1
 6hpA==
X-Gm-Message-State: AOAM532/M3nC04/SW1iRsQNYBcpT4DvU1ZH4EF8vj2SNbmzvY35wh1M8
 tV+NpwCg/FyBJm32Sav0hRw=
X-Google-Smtp-Source: ABdhPJwZAff2tlqtYR0/XbSL53GfS2s1PnYI/hu/kt5UziGG4p1xP2ZYLg7BVqulR/54l9n1Ury16w==
X-Received: by 2002:adf:8bdd:: with SMTP id w29mr3630393wra.276.1603270391763; 
 Wed, 21 Oct 2020 01:53:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:16e2:6f16:c01c:df28?
 ([2601:647:4802:9070:16e2:6f16:c01c:df28])
 by smtp.gmail.com with ESMTPSA id a17sm2760449wra.29.2020.10.21.01.53.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 01:53:10 -0700 (PDT)
Subject: Re: [PATCH 0/3] avoid race between time out and tear down
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20201020090808.27702-1-lengchao@huawei.com>
 <9e1966b0-d471-0043-7fdb-e0f535571feb@grimberg.me>
 <3d5b96dd-4e0f-758a-4175-e69fef0b8c34@huawei.com>
 <b60f34ea-86f1-ef86-8e1f-b156b7681699@grimberg.me>
 <5a48d20f-e9c9-5d37-776a-1fe3b1eb79a8@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <db872ac4-662c-1e47-291a-7c64ae0cfa57@grimberg.me>
Date: Wed, 21 Oct 2020 01:53:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5a48d20f-e9c9-5d37-776a-1fe3b1eb79a8@huawei.com>
Content-Type: multipart/mixed; boundary="------------40464988562CB36317D6CA32"
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_045315_557460_E713F7CD 
X-CRM114-Status: GOOD (  20.77  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a multi-part message in MIME format.
--------------40464988562CB36317D6CA32
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


>>>>> Avoid race between time out and tear down for rdma and tcp.
>>>>
>>>> This patchset overall looks good, but we still need the patch that
>>>> avoids double completion:
>>>>
>>>> -- 
>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>> index 629b025685d1..46428ff0b0fc 100644
>>>> --- a/drivers/nvme/host/tcp.c
>>>> +++ b/drivers/nvme/host/tcp.c
>>>> @@ -2175,7 +2175,7 @@ static void nvme_tcp_complete_timed_out(struct 
>>>> request *rq)
>>>>          /* fence other contexts that may complete the command */
>>>>          mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
>>>>          nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>>>> -       if (!blk_mq_request_completed(rq)) {
>>>> +       if (blk_mq_request_started(rq) && 
>>>> !blk_mq_request_completed(rq)) {
>>> Yes, this patch is need. and samely for nvme_cancel_request.
>>> This will fix the race with asynchronous completion.
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index e85f6304efd7..1e838d952096 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -338,7 +338,7 @@ bool nvme_cancel_request(struct request *req, 
>>> void *data, bool reserved)
>>>                                  "Cancelling I/O %d", req->tag);
>>>
>>>          /* don't abort one completed request */
>>> -       if (blk_mq_request_completed(req))
>>> +       if (blk_mq_request_completed(req) || 
>>> !blk_mq_request_started(rq))
>>>                  return true;
>>>
>>>          nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
>>
>> This one is unneeded because blk_mq_tagset_busy_iter checks that the
>> request has started...
> Yes, it is already checked.

Can you add the attached patches and resend?

You can also add my:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

--------------40464988562CB36317D6CA32
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-nvme-rdma-fix-possible-double-completion-for-timed-o.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-nvme-rdma-fix-possible-double-completion-for-timed-o.pa";
 filename*1="tch"

From 53c3b144d71f7ab96619f917571fe63dbd3a023c Mon Sep 17 00:00:00 2001
From: Sagi Grimberg <sagi@grimberg.me>
Date: Wed, 21 Oct 2020 01:51:29 -0700
Subject: [PATCH 2/2] nvme-rdma: fix possible double completion for timed out
 requests

If error recovery ran before the timeout handler did and fully completed
the timed out request, it will appear as not started (rq state is
MQ_RQ_IDLE), however the timeout handler only verifies that the request
was not completed (rq state is MQ_RQ_COMPLETE).

Check and make sure that the request is both started and did not yet
complete.

Example trace:
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 6 PID: 45 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
Workqueue: kblockd blk_mq_timeout_work
RIP: 0010:refcount_warn_saturate+0xa6/0xf0
RSP: 0018:ffffb71b80837dc8 EFLAGS: 00010292
RAX: 0000000000000026 RBX: 0000000000000000 RCX: ffff93f37dcd8d08
RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff93f37dcd8d00
RBP: ffff93f37a812400 R08: 00000203c5221fce R09: ffffffffa7fffbc4
R10: 0000000000000477 R11: 000000000002835c R12: ffff93f37a8124e8
R13: ffff93f37a2b0000 R14: ffffb71b80837e70 R15: ffff93f37a2b0000
FS:  0000000000000000(0000) GS:ffff93f37dcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005637b4137028 CR3: 000000007c1be000 CR4: 00000000000006e0
Call Trace:
 blk_mq_check_expired+0x109/0x1b0
 blk_mq_queue_tag_busy_iter+0x1b8/0x330
 ? blk_poll+0x300/0x300
 blk_mq_timeout_work+0x44/0xe0
 process_one_work+0x1b4/0x370
 worker_thread+0x53/0x3e0
 ? process_one_work+0x370/0x370
 kthread+0x11b/0x140
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x22/0x30
---[ end trace 7d137e36e23c0d19 ]---

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 45fc605349da..ebd6b1080c9d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1973,7 +1973,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
 	/* fence other contexts that may complete the command */
 	mutex_lock(&ctrl->teardown_lock);
 	nvme_rdma_stop_queue(queue);
-	if (!blk_mq_request_completed(rq)) {
+	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
 		blk_mq_complete_request_sync(rq);
 	}
-- 
2.25.1


--------------40464988562CB36317D6CA32
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-nvme-tcp-fix-possible-double-completion-for-timed-ou.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-nvme-tcp-fix-possible-double-completion-for-timed-ou.pa";
 filename*1="tch"

From d9ccd0baf15779d3dcdd488577eda8077bb7cc21 Mon Sep 17 00:00:00 2001
From: Sagi Grimberg <sagi@grimberg.me>
Date: Wed, 21 Oct 2020 01:45:34 -0700
Subject: [PATCH 1/2] nvme-tcp: fix possible double completion for timed out
 requests

If error recovery ran before the timeout handler did and fully completed
the timed out request, it will appear as not started (rq state is
MQ_RQ_IDLE), however the timeout handler only verifies that the request
was not completed (rq state is MQ_RQ_COMPLETE).

Check and make sure that the request is both started and did not yet
complete.

Example trace:
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 6 PID: 45 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
Workqueue: kblockd blk_mq_timeout_work
RIP: 0010:refcount_warn_saturate+0xa6/0xf0
RSP: 0018:ffffb71b80837dc8 EFLAGS: 00010292
RAX: 0000000000000026 RBX: 0000000000000000 RCX: ffff93f37dcd8d08
RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff93f37dcd8d00
RBP: ffff93f37a812400 R08: 00000203c5221fce R09: ffffffffa7fffbc4
R10: 0000000000000477 R11: 000000000002835c R12: ffff93f37a8124e8
R13: ffff93f37a2b0000 R14: ffffb71b80837e70 R15: ffff93f37a2b0000
FS:  0000000000000000(0000) GS:ffff93f37dcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005637b4137028 CR3: 000000007c1be000 CR4: 00000000000006e0
Call Trace:
 blk_mq_check_expired+0x109/0x1b0
 blk_mq_queue_tag_busy_iter+0x1b8/0x330
 ? blk_poll+0x300/0x300
 blk_mq_timeout_work+0x44/0xe0
 process_one_work+0x1b4/0x370
 worker_thread+0x53/0x3e0
 ? process_one_work+0x370/0x370
 kthread+0x11b/0x140
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x22/0x30
---[ end trace 7d137e36e23c0d19 ]---

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 629b025685d1..46428ff0b0fc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2175,7 +2175,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	/* fence other contexts that may complete the command */
 	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
-	if (!blk_mq_request_completed(rq)) {
+	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
 		blk_mq_complete_request_sync(rq);
 	}
-- 
2.25.1


--------------40464988562CB36317D6CA32
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--------------40464988562CB36317D6CA32--

