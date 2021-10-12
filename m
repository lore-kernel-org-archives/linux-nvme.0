Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E311C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 10:30:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DBA6044F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 10:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86DBA6044F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KveJzVTmdNvKPYmZW7c60Z96nCHbqQ6MRJAEhywtfTk=; b=TyXmm4ct/xj110
	bPCwLR7pPihqLLZltmvTp1/Wa1EWINvlHSa23MF+k+w5ME/T/YdGvK0C7Yc/Gi+iNbiEkYRNPPhYK
	f2j0kTHkpxfpkxUFMtI5gEfYeOhFaKPu8BszV8w//OwJo7nTTvlfmhy4/0+TfxEL/dj8B3ISxyBFQ
	wcTfQW2vwunXVCceKtiQRT0V2soZamAOKGN05v104/Rd/hWw5qQ5HsLOYkPrCGh7u2Wj05/GHBniE
	ENs5fr7hOpLOaSq37BhHZOvxeFiPTfVGHWVe9cOVL6hsjxziDTPwdNyqvWEGZE64UZEX1q46NKgBy
	k8uu/nz365wZj/4p2edg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maF35-00CR8s-Do; Tue, 12 Oct 2021 10:30:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maF32-00CR89-BD
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 10:30:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7315267373; Tue, 12 Oct 2021 12:30:11 +0200 (CEST)
Date: Tue, 12 Oct 2021 12:30:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 6/6] blk-mq: support concurrent queue quiesce/unquiesce
Message-ID: <20211012103010.GA29640@lst.de>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211009034713.1489183-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_033016_558595_E9CE5754 
X-CRM114-Status: GOOD (  14.35  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Oct 09, 2021 at 11:47:13AM +0800, Ming Lei wrote:
> +	spin_lock_irqsave(&q->queue_lock, flags);
> +	if (!q->quiesce_depth++)
> +		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);

We can get rid of the QUEUE_FLAG_QUIESCED flag now and just look
at ->quiesce_depth directly.

> +	spin_lock_irqsave(&q->queue_lock, flags);
> +	WARN_ON_ONCE(q->quiesce_depth <= 0);
> +	if (q->quiesce_depth > 0 && !--q->quiesce_depth) {

	if (WARN_ON_ONCE(q->quiesce_depth <= 0))
		; /* oops */
	else if (!--q->quiesce_depth)
		run_queue = true;

Otherwise this looks sensible.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
