Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241FFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xnWEXOZkKkaJSMhIpKZJuUl3Fw7AOQgr8GUGiornnME=; b=kLSv8kxM4C1wPl45gR9aChvEo7
	tqRjszpUGNQeD6b9IqmLrXrb3vT0Z3D7VWhE+RvLz3pOjcgvIoGaavtelvo01cF/OHTwAEOuvEu65
	5hv/FHVc35AAtz84AHaYOMznra1rZXY2DS5Luy9gd0J6oWxva+fksjPQJK/phLSo0LXqeSc47ehdN
	anwdt4IOg7SJUr6L+/qvHv7pJSztdAGvv39etm+6vEL/A+O4hgOWhClzpUNSBwM//4TlBF+XL8sb8
	j195dTJbklUhR5cVFz1l1tjRbY3hLADbP+NgXo3+/Sn4S8q8h+AQGaOty474Y6JxD894ZNgJYTuWb
	tNB7KHpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtqH-006hpa-BV; Thu, 16 Dec 2021 16:42:53 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mxtei-006d71-GL; Thu, 16 Dec 2021 16:30:56 +0000
Date: Thu, 16 Dec 2021 08:30:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Message-ID: <YbtpwAP5HJSKAjh8@infradead.org>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk>
 <YbsB/W/1Uwok4i0u@infradead.org>
 <83aa4715-7bf8-4ed1-6945-3910cb13f233@kernel.dk>
 <YbtmPjisO5RIAnby@infradead.org>
 <db771bc2-4d7a-ee1c-aff7-f8e37dc964d5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db771bc2-4d7a-ee1c-aff7-f8e37dc964d5@kernel.dk>
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

On Thu, Dec 16, 2021 at 09:27:18AM -0700, Jens Axboe wrote:
> OK, I misunderstood which one you referred to then. So this incremental,

Yes, that's the preferred version.

