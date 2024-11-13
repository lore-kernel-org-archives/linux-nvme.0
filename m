Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25234D637A6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 18:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Md60i28ukD0lfEvSKguY2NCj5Myaq2rhrhoA+wvIl/A=; b=iWyQ5PiE/achuoDfMa5cp3NT+B
	E/vGEcP8MoHkDuzFLMzg4Jzx5k0RqUXqL24M86n45yM1PLoDs4xe8nauIjEWdAOuNH8uNImqMjGZN
	/nNMmz3JxK5NLd1zeJK2zVghRzR89RSAuoIgkLwlnZo1Yv+28oGEZU2J+no4kmtYm3ySLhHtcIuov
	+FzyUwpBgpXdSd10Ua8aKPgHTomchbTB4Geps8ifLOefwl/gvrSamdY/mYjx7LM2Hr86axMO0F1iH
	N9jsryLDurYfrSpL1kGVI9MAyE0q6hbXdL/SDgIir1bFe+9fXn0MQ+YqcpktYTxqEIIsgSmCDX3v1
	aeO76hdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIC0-00000007j5F-3bGN;
	Wed, 13 Nov 2024 18:34:16 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIBx-00000007j1t-2ZXL
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 18:34:15 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XpX482BvSzlgMW8;
	Wed, 13 Nov 2024 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1731522834; x=1734114835; bh=Md60i28ukD0lfEvSKguY2NCj
	5Myaq2rhrhoA+wvIl/A=; b=t5TC81VQjnB8GAslWw8CoD8HnR0PTQEdw4KyrAnr
	3ZdxAALr5CfnWY5q6VhnCYEBxskYnaBBIL2qVomJgbI0w0FMMkqIQCiYsTfcXJCx
	VseAWXjH84iobkJdq6qNiYZ/N08t5YongPQ8AdGsVTtIT6geT50CXotFvPLXFsx2
	Jt+u5g3VtQh8tFhOALgCKfD3W6yLNYYZ3SXfYliuBUpFGiZ7O2fVvyulBP+OvYWm
	AUw1fylbCy+O/ERktudWo5rdWtTL236zEiPYeD2iPatUudiuinhsKtw9iB8Uz4b1
	LEpcXOr0PcwiFAzyXBn/7QwG3sB7kER5L+scK6y2ZEDlAw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id i5ZJ0PUIqGhn; Wed, 13 Nov 2024 18:33:54 +0000 (UTC)
Received: from [172.19.178.167] (217.sub-174-194-198.myvzw.com [174.194.198.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XpX3x1MtPzlgMVx;
	Wed, 13 Nov 2024 18:33:48 +0000 (UTC)
Message-ID: <92954431-349d-4b75-b63f-948b1df9a3fc@acm.org>
Date: Wed, 13 Nov 2024 10:33:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: don't reorder requests passed to ->queue_rqs
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241113152050.157179-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_103413_719739_698B38C2 
X-CRM114-Status: GOOD (  21.46  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 11/13/24 7:20 AM, Christoph Hellwig wrote:
> currently blk-mq reorders requests when adding them to the plug because
> the request list can't do efficient tail appends.  When the plug is
> directly issued using ->queue_rqs that means reordered requests are
> passed to the driver, which can lead to very bad I/O patterns when
> not corrected, especially on rotational devices (e.g. NVMe HDD) or
> when using zone append.
> 
> This series first adds two easily backportable workarounds to reverse
> the reording in the virtio_blk and nvme-pci ->queue_rq implementations
> similar to what the non-queue_rqs path does, and then adds a rq_list
> type that allows for efficient tail insertions and uses that to fix
> the reordering for real and then does the same for I/O completions as
> well.

Hi Christoph,

Could something like the patch below replace this patch series? I don't 
have a strong opinion about which approach to select.
I'm sharing this patch because this is what I came up while looking into
how to support QD>1 for zoned devices with a storage controller that
preserves the request order (UFS).

Thanks,

Bart.


block: Make the plugging mechanism preserve the request order

Requests are added to the front of the plug list and dispatching happens
in list order. Hence, dispatching happens in reverse order. Dispatch in
order by reversing the plug list before dispatching. This patch is a
modified version of a patch from Jens
(https://lore.kernel.org/linux-block/1872ae0a-6ba6-45f5-9f3d-8451ce06eb14@kernel.dk/).

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3533bd808072..bf2ea421b2e8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2868,6 +2868,22 @@ static void blk_mq_dispatch_plug_list(struct 
blk_plug *plug, bool from_sched)
  	percpu_ref_put(&this_hctx->queue->q_usage_counter);
  }

+/* See also llist_reverse_order(). */
+static void blk_plug_reverse_order(struct blk_plug *plug)
+{
+	struct request *rq = plug->mq_list, *new_head = NULL;
+
+	while (rq) {
+		struct request *tmp = rq;
+
+		rq = rq->rq_next;
+		tmp->rq_next = new_head;
+		new_head = tmp;
+	}
+
+	plug->mq_list = new_head;
+}
+
  void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
  {
  	struct request *rq;
@@ -2885,6 +2901,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, 
bool from_schedule)
  	depth = plug->rq_count;
  	plug->rq_count = 0;

+	blk_plug_reverse_order(plug);
+
  	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
  		struct request_queue *q;



