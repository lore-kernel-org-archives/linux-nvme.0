Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C84DC3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 04:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SxBmTpsiWaKkD8CnyzMjPOuxA6REiSDeiBaWg4LE6rA=; b=HEB32N1uT26s7btq6wN/D+6Ks5
	nv/XZ5xuolgcevaBCAXsmZvtEeXpzLhuyBEoglzRh5DOm76EPIG4w6DDWinGN4HeExRK39oWC5Jjd
	AulUJvb+nKOUFIIYAwD6MDye/Zwm5ISiMCg66cgFjVU6HEVzOHGEkcIMINOAlfenhJ1ncGeJwx7R8
	tCIt47dp1FOR54suaOrIpwQmFncB4c4ZRBUy3WkgUBGkYRpj0xVx4y4KLgXb47dsn71OhN3Ums6WX
	b4RufffuvhXES0Rllr+dRuhCJ02qlpLPq5XeB1s5jHG9PIFuD12/EPZ8en9qTUmwmji4NSMYz9xZe
	qUiT9RlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLbuJ-00Fv5M-2O;
	Fri, 05 Jan 2024 04:34:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLbuH-00Fv4l-19
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 04:34:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9FDCC68B05; Fri,  5 Jan 2024 05:34:01 +0100 (CET)
Date: Fri, 5 Jan 2024 05:34:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: respect user max_discard_sectors setting
Message-ID: <20240105043401.GA23760@lst.de>
References: <20240104191244.737208-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104191244.737208-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_203405_537393_5133CF75 
X-CRM114-Status: GOOD (  15.24  )
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

On Thu, Jan 04, 2024 at 11:12:44AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A user can change that attribute to 0 through sysfs, but they can't
> change the hw limit. Check the hw limit instead to know if the driver
> previously set up discard capabilities.

blk_queue_max_discard_sectors updates the hardware and user limit.
It's a bit of a mess, but Jens didn't quite like my half-hearted fix
last time.  If we want to do this properly we probably need a separate
user limit and recalculate the effective limit when either the hw or
user limit changes.  For early in the 6.9 merge window I plan to redo
how all the limits are set, and that should give us a better opportunity
for these kinds of things


