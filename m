Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04312C19F2D
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 06:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLzLXaOQ83Ul9q4Zu/Qeb1XP2jqxvCqUQ9cAGwCGKxg=; b=rKFfQcCXswRjhF7NT1t5+231KT
	kL3rx22d1rTEV/Lgs8Rnvz0GXJ1jDgfqT3pcBr9WErtmS+5/kCJKFqlqgC+PH6QSL9T3Gc7TPMZMS
	5JUxVjXYqTEZZQHtcWgxdWBJUnRhEH+t4Tb1VeuaS4sUaWDTZm9DUqV7VF9JFCgkmB9SnxMyEE71y
	kFIH68Aiztdv1HaERbvyxbE71aD/ohiPFPSxInsA26EZbIx55mAkI5H3AoKlmLFY+2dh2ROX8UbCa
	g9isboZQSPqogUVCqGsk1/iRwYYzYYCbOmhN9zzlIppoJZgXB/Je0MqdE1o4L5lIAJsKfXHMz8Sg6
	og/BFVxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM1Ec-0067OD-QB; Thu, 11 Aug 2022 05:59:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM1EZ-0067Jt-Nb
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 05:59:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65AE968AA6; Thu, 11 Aug 2022 07:59:51 +0200 (CEST)
Date: Thu, 11 Aug 2022 07:59:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: cgel.zte@gmail.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] nvme:Use the function kobj_to_dev()
Message-ID: <20220811055951.GA12417@lst.de>
References: <20220811012910.15820-1-ye.xingchen@zte.com.cn> <fd6af173-4530-5bb3-db61-6612e5d574bb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd6af173-4530-5bb3-db61-6612e5d574bb@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_225955_938653_13F49564 
X-CRM114-Status: GOOD (  15.62  )
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

On Wed, Aug 10, 2022 at 07:32:40PM -0600, Jens Axboe wrote:
> > Use kobj_to_dev() instead of open-coding it.
> 
> This:
> 
> > -	struct device *dev = container_of(kobj, struct device, kobj);
> > +	struct device *dev = kobj_to_dev(kobj);
> 
> just makes the code harder to read, imho. The original line, I can tell
> what it does. The new line, I have to go look it up.

Exactly.

> Is some tool suggesting these transformations? Because they look like a
> bad idea to me, and we should fix that rather than make the code worse.

I keeps coming up again and again and one of the maintainers always
answers something like you just did.  Which suggests like someone or
something is unfortunately suggesting it.

