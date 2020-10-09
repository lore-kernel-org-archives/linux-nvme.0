Return-Path: <SRS0=D38N=DQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FACC433E7
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 04:40:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4BF22251
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 04:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0G93jNYe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFhqg8+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4BF22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i0wSHkXYSbBm92OFHTFypX0zIx5iOlJrnG+9u3XksU0=; b=0G93jNYe9wHPpmKOCYO9PrVgO
	QWHs7xudHaO6LqBHbw7ifuULBQjlqe8MkIWuZ39YVSsDrxqz6m44nyWm2wxfb5k/kJY3y5aTlIHUW
	CbV48O6LK9fgSAyG8PHaX13Jr1L1ZuPMftqOTt/3dSehLx5RTxhl6tDJ9PfHzW8hANNsSpQxd1JA+
	mkPKwbonWmd6mhnlCuTq5FPIhUVa3NSBzaPff46O4Q1HO5q3ScwaW1rag9nhzSh+W3JrTMnTTC+Fp
	9Gof3xrPNnPLwInkv8t8IFVaTkBv6tsZ7FcvOld6JUrOvrRfH6AH3VaWZDMEHp28PawfZO4dYjXYI
	L2FH7PLCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQkCN-00083B-7T; Fri, 09 Oct 2020 04:40:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQkCJ-00082X-3M
 for linux-nvme@lists.infradead.org; Fri, 09 Oct 2020 04:40:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602218400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8+77F26oYvz8nPwKMAd6b8LQAp37lnqoNWWetDlbXc=;
 b=XFhqg8+xau9WR1n+dMkekHP/gY0CJEMuMqOLlrmMXO2hMbHAuaV3IOfLvoZpr3C9f09RRr
 V410yJoP2c1cvLOSb7IzTFjy8rcKgVVm8pSJ5nq7Hbw78lH7nYX+YFMfgklvXM1Jn/FRPo
 t5HTIl6MH/zz5NZVTeoqvyU3stlk2Ok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-_gQInPF1PlqvFNvrvkoqFw-1; Fri, 09 Oct 2020 00:39:53 -0400
X-MC-Unique: _gQInPF1PlqvFNvrvkoqFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DE2E87505F;
 Fri,  9 Oct 2020 04:39:52 +0000 (UTC)
Received: from T590 (ovpn-13-88.pek2.redhat.com [10.72.13.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F36F7664E;
 Fri,  9 Oct 2020 04:39:42 +0000 (UTC)
Date: Fri, 9 Oct 2020 12:39:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
Message-ID: <20201009043938.GC27356@T590>
References: <20201008213750.899462-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201008213750.899462-1-sagi@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201009_004003_199279_669A8102 
X-CRM114-Status: GOOD (  24.90  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 08, 2020 at 02:37:50PM -0700, Sagi Grimberg wrote:
> In nvme-tcp and nvme-rdma, the timeout handler in certain conditions
> needs to complete an aborted request. The timeout handler serializes
> against an error recovery sequence that iterates over the inflight
> requests and cancels them.
> 
> However, the fact that blk_mq_complete_request may defer to a different
> core that serialization breaks.
> 
> Hence re-introduce blk_mq_complete_request_sync and use that in the
> timeout handler to make sure that we don't get a use-after-free
> condition.
> 
> This was uncovered by the blktests:
> --
> $ nvme_trtype=tcp ./check nvme/012
> 
> [ 2152.546343] run blktests nvme/012 at 2020-10-08 05:59:03
> [ 2152.799640] loop: module loaded
> [ 2152.835222] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 2152.860697] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [ 2152.937889] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
> [ 2152.952085] nvme nvme0: creating 12 I/O queues.
> [ 2152.958042] nvme nvme0: mapped 12/0/0 default/read/poll queues.
> [ 2152.969948] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
> [ 2154.927953] XFS (nvme0n1): Mounting V5 Filesystem
> [ 2154.942432] XFS (nvme0n1): Ending clean mount
> [ 2154.948183] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
> [ 2215.193645] nvme nvme0: queue 7: timeout request 0x11 type 4
> [ 2215.199331] nvme nvme0: starting error recovery
> [ 2215.203890] nvme nvme0: queue 7: timeout request 0x12 type 4
> [ 2215.204483] block nvme0n1: no usable path - requeuing I/O
> [ 2215.214976] block nvme0n1: no usable path - requeuing I/O
> [ 2215.215495] nvme nvme0: Reconnecting in 10 seconds...
> [ 2215.215502] ------------[ cut here ]------------
> [ 2215.215505] refcount_t: underflow; use-after-free.
> [ 2215.215617] WARNING: CPU: 6 PID: 45 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
> [ 2215.215745] RSP: 0018:ffffb71b80837dc8 EFLAGS: 00010292
> [ 2215.215750] RAX: 0000000000000026 RBX: 0000000000000000 RCX: ffff93f37dcd8d08
> [ 2215.215753] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff93f37dcd8d00
> [ 2215.215755] RBP: ffff93f37a812400 R08: 00000203c5221fce R09: ffffffffa7fffbc4
> [ 2215.215758] R10: 0000000000000477 R11: 000000000002835c R12: ffff93f37a8124e8
> [ 2215.215761] R13: ffff93f37a2b0000 R14: ffffb71b80837e70 R15: ffff93f37a2b0000
> [ 2215.215765] FS:  0000000000000000(0000) GS:ffff93f37dcc0000(0000) knlGS:0000000000000000
> [ 2215.215768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2215.215771] CR2: 00005637b4137028 CR3: 000000007c1be000 CR4: 00000000000006e0
> [ 2215.215773] Call Trace:
> [ 2215.215784]  blk_mq_check_expired+0x109/0x1b0
> [ 2215.215797]  blk_mq_queue_tag_busy_iter+0x1b8/0x330
> [ 2215.215801]  ? blk_poll+0x300/0x300
> [ 2215.215806]  blk_mq_timeout_work+0x44/0xe0
> [ 2215.215814]  process_one_work+0x1b4/0x370
> [ 2215.215820]  worker_thread+0x53/0x3e0
> [ 2215.215825]  ? process_one_work+0x370/0x370
> [ 2215.215829]  kthread+0x11b/0x140
> [ 2215.215834]  ? __kthread_bind_mask+0x60/0x60
> [ 2215.215841]  ret_from_fork+0x22/0x30
> [ 2215.215847] ---[ end trace 7d137e36e23c0d19 ]---
> --
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Fixes: 236187c4ed19 ("nvme-tcp: fix timeout handler")
> Fixes: 0475a8dcbcee ("nvme-rdma: fix timeout handler")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Yi, would appreciate your Tested-by tag
> 
>  block/blk-mq.c           | 7 +++++++
>  drivers/nvme/host/rdma.c | 2 +-
>  drivers/nvme/host/tcp.c  | 2 +-
>  include/linux/blk-mq.h   | 1 +
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f8e1e759c905..2d154722ef39 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -729,6 +729,13 @@ bool blk_mq_complete_request_remote(struct request *rq)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_complete_request_remote);
>  
> +void blk_mq_complete_request_sync(struct request *rq)
> +{
> +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> +	rq->q->mq_ops->complete(rq);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
> +
>  /**
>   * blk_mq_complete_request - end I/O on a request
>   * @rq:		the request being processed
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 9e378d0a0c01..45fc605349da 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1975,7 +1975,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
>  	nvme_rdma_stop_queue(queue);
>  	if (!blk_mq_request_completed(rq)) {
>  		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
> -		blk_mq_complete_request(rq);
> +		blk_mq_complete_request_sync(rq);
>  	}
>  	mutex_unlock(&ctrl->teardown_lock);
>  }
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8f4f29f18b8c..629b025685d1 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2177,7 +2177,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>  	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>  	if (!blk_mq_request_completed(rq)) {
>  		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
> -		blk_mq_complete_request(rq);
> +		blk_mq_complete_request_sync(rq);

Or complete the request in the following way? Then one block layer API
can be saved:

	blk_mq_complete_request_remote(rq);
	nvme_complete_rq(rq);


thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
