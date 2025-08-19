Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C76CA0EEB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3SfEMxVljxIHvUZ34DtV8U/cPDN9Ca11v4XadfLcJLg=; b=RRJiRx9FfbGfosaShZu9VMhWrn
	hb4AA+prdZRLlXN2XUvVCsq43KCGsWePEkCcPlWlRuJhflIVPN9iNQv4wfY3dAuNHJIqc5V5K9dIW
	ffeMy45y82XpfozpUy0IVCmkurCOtR0kr+dFfPTtBLHx29utO+wix5HaJrxBtPrVNWV8v/DVo5wcU
	kWeb7enO88WHdNrpoVc8cy00Lmyu6AbtAnUFeVWEyq91YH+135Vp+6vfq68cUITeqWEOKKxF/d85g
	OMdHHfg7/KIFNGNHL91nWgdIFzhAombC43URA9iENWe6G6lq3jlnsYlO4ycA+Sg3Av0sVG4obqCjO
	4fGrDfqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoQqS-0000000BDR0-1wTn;
	Tue, 19 Aug 2025 18:14:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoMYx-0000000AcWg-0LcD
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 13:39:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6963E227A88; Tue, 19 Aug 2025 15:39:32 +0200 (CEST)
Date: Tue, 19 Aug 2025 15:39:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250819133932.GA16857@lst.de>
References: <20250714131713.GA8742@lst.de> <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com> <aHULEGt3d0niAz2e@infradead.org> <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com> <20250715060247.GC18349@lst.de> <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com> <20250715090357.GA21818@lst.de> <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_063943_309404_C2560C37 
X-CRM114-Status: GOOD (  19.70  )
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

On Tue, Aug 19, 2025 at 12:42:01PM +0100, John Garry wrote:
> nothing has been happening on this thread for a while. I figure that it is 
> because we have no good or obvious options.
>
> I think that it's better deal with the NVMe driver handling of AWUPF first, 
> as this applies to block fops as well.
>
> As for the suggestion to have an opt-in to use AWUPF, you wrote above that 
> users may not know when to enable this opt-in or not.
>
> It seems to me that we can give the option, but clearly label that it is 
> potentially dangerous. Hopefully the $RANDOMUSER with the $CHEAPO SSD will 
> be wise and steer clear.
>
> If we always ignore AWUPF, I fear that lots of sound NVMe implementations 
> will be excluded from HW atomics.

I think ignoring AWUPF is a good idea, but I've also hard some folks
not liking that.

The reason why I prefer a mount option is because we add that to fstab
and the kernel command line easily.  For block layer or driver options
we'd either need a sysfs file which is always annoying to apply at boot
time, or a module option which has the downside of applying to all
devices.

