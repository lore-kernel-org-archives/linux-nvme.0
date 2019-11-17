Return-Path: <SRS0=LUlw=ZJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532A0C432C0
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Nov 2019 04:13:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4B3206DB
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Nov 2019 04:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GnXN0oY/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqpbNoJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4B3206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GTfBPZTw0oNgTfGtp55td5QN3Mc6CZtvOOvPV9mp3E4=; b=GnXN0oY/xb4Jxn
	o75vxRQLovy7P02+WV9kSfhk0MLfZ3JDpDHUTj6kwnk3ggGoiQtvVJzM4nMgqapQMnfr4L7gSg3ZY
	UJFlICfY8RBfN9kIH1TZZlbdQOsavqM9MnOD6Fvqmi/zhAvI/pZmLwQ7VlGIbFSwS+/kbHX+dbykd
	SBxqTfGhdKeVoe1g9NUG8nznLt7oQ6o1ZnZYVQNq9JynBES0CJ5kLCtnEzdUBoJ0ABkKVK+ODuNNK
	RWO5mTkvGwjvQVt4xTeZmv740nN/ovvZosCJzGSXEr0FcXN7QcuoBLKVPWwjiFFOP5kGg9NMMbFu6
	RfAHl+0FnEXIg8EsfL3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iWBvq-0003Bu-C9; Sun, 17 Nov 2019 04:13:02 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iWBvm-0003AL-KO
 for linux-nvme@lists.infradead.org; Sun, 17 Nov 2019 04:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573963973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5x1Akht5a1uogovRlgVYj+rZ+sQ5riNnKd295qdi94=;
 b=eqpbNoJAm0N+iRkeU8bZEsjMMRjdBdmOerbwTl+Yd/QFSwAMDeeLRL20dFo8cKzitI7oL6
 a+jg5uueF3keNSjkJvu37/q4JVpQclC50gA/JVthE6RDpnVccuVVHujCVDZXZYRlOjAqqW
 LPLDLJQOaNRX3YL9e/hWUeA70PA4KNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-doqWw9rSM3yhDWgT29wYjg-1; Sat, 16 Nov 2019 23:12:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7C921005500;
 Sun, 17 Nov 2019 04:12:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48A7A60900;
 Sun, 17 Nov 2019 04:12:37 +0000 (UTC)
Date: Sun, 17 Nov 2019 12:12:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
Message-ID: <20191117041233.GA30615@ming.t460p>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <4a39a98e-19bc-0a9a-3d92-ceab2c656037@acm.org>
MIME-Version: 1.0
In-Reply-To: <4a39a98e-19bc-0a9a-3d92-ceab2c656037@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: doqWw9rSM3yhDWgT29wYjg-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191116_201258_744949_2054AE84 
X-CRM114-Status: GOOD (  20.39  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Nov 16, 2019 at 05:24:05PM -0800, Bart Van Assche wrote:
> On 2019-11-15 23:17, Ming Lei wrote:
> > Now blk-mq takes a static queue mapping between CPU and hw queues, given
> > CPU hotplug may happen any time, so the specified hw queue may become
> > inactive any time.
> 
> Hi Ming,
> 
> I can trigger a race between blk_mq_alloc_request_hctx() and
> CPU-hotplugging by running blktests. The patch below fixes that race
> on my setup. Does this patch also fix the race(s) that you ran into?

The following problem has been triggered in my regular test for years,
is it same with yours?

[ 2248.751675] nvme nvme1: creating 2 I/O queues.
[ 2248.752351] BUG: unable to handle page fault for address: 0000607d064434a8
[ 2248.753348] #PF: supervisor write access in kernel mode
[ 2248.754106] #PF: error_code(0x0002) - not-present page
[ 2248.754846] PGD 0 P4D 0
[ 2248.755230] Oops: 0002 [#1] PREEMPT SMP PTI
[ 2248.755838] CPU: 7 PID: 16293 Comm: kworker/u18:3 Not tainted 5.4.0-rc7_96b95eff4a59_master+ #1
[ 2248.757089] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
[ 2248.758863] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work [nvme_loop]
[ 2248.759857] RIP: 0010:blk_mq_get_request+0x2a8/0x31c
[ 2248.760654] Code: c7 83 08 01 00 00 00 00 00 00 48 c7 83 10 01 00 00 00 00 00 00 48 8b 55 18 45 84 ed 74 0c 31 c0 41 81 e5 00 08 06 00 0f 95 c0 <48> ff 44 c2 68 c7 83 d4 00 00 00 01 00 00 00 f7 45 10 00 00 06 00
[ 2248.763375] RSP: 0018:ffffc900012dbc80 EFLAGS: 00010246
[ 2248.764130] RAX: 0000000000000000 RBX: ffff888170d70000 RCX: 0000000000000017
[ 2248.765156] RDX: 0000607d06443440 RSI: 0000020bb36c554e RDI: 0000020bb3837c3f
[ 2248.766034] RBP: ffffc900012dbcc0 R08: 00000000f461df07 R09: 00000000000000a8
[ 2248.767084] R10: ffffc900012dbe50 R11: 0000000000000002 R12: 0000000000000000
[ 2248.768109] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 2248.769134] FS:  0000000000000000(0000) GS:ffff88827bd80000(0000) knlGS:0000000000000000
[ 2248.770294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2248.771125] CR2: 0000607d064434a8 CR3: 0000000272866001 CR4: 0000000000760ee0
[ 2248.772152] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2248.773179] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2248.774204] PKRU: 55555554
[ 2248.774603] Call Trace:
[ 2248.774983]  blk_mq_alloc_request_hctx+0xc5/0x10e
[ 2248.775674]  nvme_alloc_request+0x42/0x71
[ 2248.776263]  __nvme_submit_sync_cmd+0x49/0x1b2
[ 2248.776910]  nvmf_connect_io_queue+0x12c/0x195 [nvme_fabrics]
[ 2248.777663]  ? nvme_loop_connect_io_queues+0x2f/0x54 [nvme_loop]
[ 2248.778481]  nvme_loop_connect_io_queues+0x2f/0x54 [nvme_loop]
[ 2248.779325]  nvme_loop_reset_ctrl_work+0x62/0xd4 [nvme_loop]
[ 2248.780144]  process_one_work+0x1a8/0x2a1
[ 2248.780727]  ? process_scheduled_works+0x2c/0x2c
[ 2248.781398]  process_scheduled_works+0x27/0x2c
[ 2248.782046]  worker_thread+0x1b1/0x23f
[ 2248.782594]  kthread+0xf5/0xfa
[ 2248.783048]  ? kthread_unpark+0x62/0x62
[ 2248.783608]  ret_from_fork+0x35/0x40

> 
> Thanks,
> 
> Bart.
> 
> 
> Subject: [PATCH] blk-mq: Fix a race between blk_mq_alloc_request_hctx() and
>  CPU hot-plugging
> 
> ---
>  block/blk-mq.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 20a71dcdc339..16057aa2307f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -442,13 +442,15 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT)))
>  		return ERR_PTR(-EINVAL);
> 
> -	if (hctx_idx >= q->nr_hw_queues)
> -		return ERR_PTR(-EIO);
> -
>  	ret = blk_queue_enter(q, flags);
>  	if (ret)
>  		return ERR_PTR(ret);
> 
> +	if (hctx_idx >= q->nr_hw_queues) {
> +		blk_queue_exit(q);
> +		return ERR_PTR(-EIO);
> +	}
> +

Not sure how this patch can make a difference since blk_queue_enter()
never checks if hctx is active, the problem is that the hctx represented
by 'hctx_idx' becomes inactive when calling blk_mq_alloc_request_hctx()(
all CPUs of this hctx becomes offline).

The problem simply is in the following code:

        cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
        alloc_data.ctx = __blk_mq_get_ctx(q, cpu);

        rq = blk_mq_get_request(q, NULL, &alloc_data);
        blk_queue_exit(q);

'cpu' becomes 'nr_cpu_ids', then kernel oops will be triggered in
blk_mq_get_request().


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
