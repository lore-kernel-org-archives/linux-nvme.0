Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415E3C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jul 2024 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TkWw+ULWXK1ui5ofsraDPWVJbuctB5A5sYmjJpCGVXo=; b=BSxxflNG4Y03qD3PeB46pDZ/WZ
	zjv8DlCR5bj6zZNPZ9b/Yoj4ITa0bF6PmMAvrbYakKsxN7lPyIyOvft2nAlfxEYmcGh5x9TY9UFl6
	RDGJuutMCQCcmPyyEBf0nm8+D8HIrTa+h6Arhasnboq8IjRZmfF9BAzVhkV6sAY0SnzpQEztUSuJl
	sXlFk11AV8m4XLtmgAT+IMXica8ZxJLGzjiO03B046sgEUX5TZ+WU1avmNeb1DwkeA4Z7T7dvjO5K
	WLfiBYQbc6zhShjaqNE18IsZId+YPiPgXjiezzW+SRvsWojTD074NBM1Bn9SoZNGV9Y66eq8+IcC5
	CkKn8pCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYqXL-0000000G0SS-0FKJ;
	Tue, 30 Jul 2024 17:21:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYqXH-0000000G0Pb-1cPx
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jul 2024 17:21:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DBB2268AA6; Tue, 30 Jul 2024 19:21:11 +0200 (CEST)
Date: Tue, 30 Jul 2024 19:21:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add missing condition check for existence of
 mapped data
Message-ID: <20240730172111.GA32320@lst.de>
References: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org> <ZqkeMJ5PPETMb5d3@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqkeMJ5PPETMb5d3@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_102119_614888_83C5FB8B 
X-CRM114-Status: GOOD (  16.19  )
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

On Tue, Jul 30, 2024 at 11:09:04AM -0600, Keith Busch wrote:
> > +	if (blk_rq_nr_phys_segments(req))
> > +		nvme_unmap_data(dev, req);
> 
> This is already applied, but it is kind of strange. We get here only if
> metadata mapping fails. Is there actually a command that has metadata
> without data?

Well, passthrough can always set metadata to map without data even
if there is no NVMe defined command that works that way, so we should
handle the error.

But I suspect this is due to Leon's dma-mapping work, and it probably
points to a bug in that :)

