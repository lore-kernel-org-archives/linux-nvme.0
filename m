Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13129C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 01:41:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC19F20838
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 01:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vm7h9XDn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rixl7aSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC19F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ch4BTV4hpsCjInAM5dKt7mITDNU9YNE+jHVmzl3GjEk=; b=Vm7h9XDnbz1P9/AIBzPjq3IGK
	6Qc68CWYuVpm6aONaKSO7x8POwzSqECr3uPYb6/5mLNryWoI2kpGpuVGD1mKj1aQv52LR5tQ+WMle
	hQBDvNPIhzsTbi5+ny3n2MNnIckueuJD14IZNmBh8RkHpFLsCLckcboQjJHwMbM2ADyW87DeBfXe3
	4R6003mdbEOBK9qrZMXlorJnXR+r0rTQdmmR6yaWlAnM0sqb1QjNkX9ZkvRR78EBGKDgklV8Y7r1M
	8W1PqGAYIDlNhl7koGl07+pgTlod9kC385F2rhvM1MA1c3DY+CENBWrJOpaN5+Vb0IjNPMfKJGxJH
	60dkwjccA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Eby-0004sX-Oo; Tue, 28 Jul 2020 01:40:58 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Ebw-0004rs-MH
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 01:40:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595900455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RCjKpXJyN62/c5yVHzk8RTcp4fhzn/0rYLcwRzNEGIA=;
 b=Rixl7aSauHw6H2NJ5BqHOUkhtFHsFYlKf6EL4NM2rzc7hR/g4RPzHB3j66snRILppCmQBD
 LGwb6d07tkNYOpe+eyT6iFOXH1lxKZ0Y0mU5tINSvvvJ3JSIGGNAfF7swwpz71a21EhPQu
 09GvOoLvFnIx0ej4sJ+RzOTsI3Nlgmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-IQ4Zp378Nv6c-sGQCI9_0w-1; Mon, 27 Jul 2020 21:40:51 -0400
X-MC-Unique: IQ4Zp378Nv6c-sGQCI9_0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 311DC80183C;
 Tue, 28 Jul 2020 01:40:50 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D1CF69323;
 Tue, 28 Jul 2020 01:40:42 +0000 (UTC)
Date: Tue, 28 Jul 2020 09:40:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728014038.GA1305646@T590>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200727231022.307602-2-sagi@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_214056_830214_EC25913A 
X-CRM114-Status: GOOD (  24.64  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 27, 2020 at 04:10:21PM -0700, Sagi Grimberg wrote:
> drivers that have shared tagsets may need to quiesce potentially a lot
> of request queues that all share a single tagset (e.g. nvme). Add an interface
> to quiesce all the queues on a given tagset. This interface is useful because
> it can speedup the quiesce by doing it in parallel.
> 
> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
> in parallel such that all of them wait for the same rcu elapsed period with
> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
> sufficient.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  block/blk-mq.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  4 +++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index abcf590f6238..c37e37354330 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -209,6 +209,42 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>  
> +static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned int i;
> +
> +	blk_mq_quiesce_queue_nowait(q);
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
> +		if (!hctx->rcu_sync)
> +			continue;

This approach of quiesce/unquiesce tagset is good abstraction.

Just one more thing, please allocate a rcu_sync array because hctx is supposed
to not store scratch stuff.


thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
