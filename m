Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132AFC79FAD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 06:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=DrC+7Y0NJBkWPiUOZb9XNcsmEjWyF+yA7+WdSLGh5K0=; b=zunYwmda9tbb0ahnWCY9xqSwLa
	SUoYTVRHS7zBCfIMNqv4HQXunnVr1xz4dV/Eu95R09HR3xX6VmkF6O+UhOU56knbwXpxfKAT1htwH
	fzpqTfY5genbyMzIf/WYBX8yf5U4xkQnkHvcxqDtnt8XEw/K6iDSxvAlPsGcEaZnQbHIY/Jw3fANP
	8wbPzoAraAi+L+p4bP8w8DiCaBSE5lHo5bcmHMljBZHKlaf6Ss9MllmTwiFdLcmTd5V4vQyQWTmei
	kSRgf9zTcfGS8IB6LpWLGHp2nPeFCxX1T2BqLRHJcgG7v4vIt6lGBwWPLcIste5daLABcoBu6NjUn
	n6T7UR3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Bjz-0000000AryG-4062;
	Wed, 09 Sep 2026 06:25:03 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Bjx-0000000Arxw-45XA;
	Wed, 09 Sep 2026 06:25:01 +0000
Date: Tue, 8 Sep 2026 23:25:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Fengnan Chang <changfengnan@bytedance.com>,
	Luigi Rizzo <lrizzo@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	Guzebing <guzebing@bytedance.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
Message-ID: <aqD7FDvDhiEF_u0N@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878q5f5tlt.ffs@fw13>
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

On Sat, Sep 05, 2026 at 10:30:22PM +0200, Thomas Gleixner wrote:
> > it appears that GSIM is only effective in scenarios where multi disks at very high
> > IOPS; in some cases, there was a noticeable performance regression. 
> > If there’s something wrong with my configuration, please correct me.
> 
> So we have a NVME specific mechanism to tackle the same problem and a
> more generic version which is subsystem "independent".

I'm not sure they tackle the entirely same problem, although they are
very related.

> Can you folks please coordinate and get your act together so that we
> don't end up with two competing mechanisms which make things worse than
> they are now.

This is what I'm trying to get done here.  This is the first time I've
seen GSIM as I still try to read lkml, although I usuall fail.
Unfortunately neither the nvme nor block lists were Cced on it,
despite most of the numbers involving NVMe.

> TBH. I despise the NVME is special approach because it's fricking
> obvious that this is _NOT_ a NVME specific issue. But sure NVME is
> special as all other subsystems are special.

Note that we tried to look into generic helpers, Keith tried various
versions using DIMLIB, and we've also considered doing more work in the
block core similar what networking does with NAPI.  But we're always
interested common code if it works, glad someone is looking.  Although
somewhat more productive suggestions would be helpful.


