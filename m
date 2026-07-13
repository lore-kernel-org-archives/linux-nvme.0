Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FA5C44501
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 06:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OuAac/3yh8px3DY44oNnfFpqHAPorx2HrXuUm+AeWjI=; b=lohmawA7BjcUYg08KJgN9CNEpC
	g5HhaqR4p50IpOrZ+gOCf5HdBa7QCE2b5Uu8LWL/B1Q0XEAgmAyKdvBr2Ykt095xoiLpxKDi57wxz
	j9FEvthJgZCwXMb1B15pAcbPpAYqYtdWlqUQvZdL+DfW3Qp7w62PvjMtbYBF3xH4sZ4CuDvViu1+T
	4dvh+yF/3/KVbozpHdWVE6tVyIqZ+LYMVvOJMSGF6JubbH6Qmjx9HjO8TgTwyOBuEUbBoxK8VXhR3
	3jzliF2AUuN2ah+wMgL6FlB+Kvdk2behtnIQmid58NLCFurECyZ24/NAOdE/JPQ5nQxn+hztWsC7e
	DNHSm+4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAPa-00000008IdG-43vy;
	Mon, 13 Jul 2026 06:45:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAPY-00000008IcK-2DZB
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 06:45:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F65068BEB; Mon, 13 Jul 2026 08:45:01 +0200 (CEST)
Date: Mon, 13 Jul 2026 08:45:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: guzebing <guzebing1612@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Guzebing <guzebing@bytedance.com>
Subject: Re: [PATCH] nvme: make firmware activation poll interval
 configurable
Message-ID: <20260713064501.GF29416@lst.de>
References: <20260627010610.47768-1-guzebing1612@gmail.com> <20260709064233.GA18381@lst.de> <7ae65361-f601-4fd9-8eac-5dfb9f6bb7ea@gmail.com> <ak-5QnI_lc-EwcNU@kbusch-mbp> <12726bc4-33ce-4602-b2a9-46885f2af1fe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12726bc4-33ce-4602-b2a9-46885f2af1fe@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_234504_722645_63DF5A93 
X-CRM114-Status: GOOD (  12.16  )
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

On Fri, Jul 10, 2026 at 05:20:56PM +0800, guzebing wrote:
> > nvme_wait_ready() has a similar polling loop on the csts register, but
> > it does a udelay_range for 1-2 msecs no matter what the ready timeout
> > is. Maybe just do the same for consistency?
> 
> Keith, using the same 1-2 ms sleep range as nvme_wait_ready() looks
> simpler to me as well.

Let's go for that then.


