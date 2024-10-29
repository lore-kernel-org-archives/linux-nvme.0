Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37507D3A66C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8NZg6OdIOucs6TDjRK1ex4c7fxD55pOs+f0J7LYplRA=; b=BuAZBLVy0O/QwS18wMorMMAr7Z
	cs/MCJc78uKK+koyEHdwednzY92ljp1nJ0mxI4dw/oj/kGxIvejabZqJbPoILuLYh5PYS4c5jWvZC
	4GQhSXOJJIqLZs1djo2GWmQqcYNLNyUaNoOhyU9AEerrK33R3d4/wIAbKuQQE7RyKPBVXvpQYQ/4N
	HvWl7ae6Saxy6F0bVBj3r/vxy3vPsEQysgWYG28Pa3+D3X8MYAa7WbCWtv7OMmb+emuDH0Z9CDs/x
	OA1Y6KAKMu7qN7M+PcbaBP9K1egYJ332htYpSYtjcQz8tKvf5RNkwnwtZYF/jEg5IxQYc0NuA+hjU
	7cjU3U1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5oPn-0000000EyZq-0ryg;
	Tue, 29 Oct 2024 15:45:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o4a-0000000Eu8u-1teb
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:24:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5E913227A88; Tue, 29 Oct 2024 16:23:45 +0100 (CET)
Date: Tue, 29 Oct 2024 16:23:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv10 4/9] block: allow ability to limit partition write
 hints
Message-ID: <20241029152345.GA26431@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241029151922.459139-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029151922.459139-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_082356_779876_4C9F0BC4 
X-CRM114-Status: GOOD (  13.75  )
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

On Tue, Oct 29, 2024 at 08:19:17AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> When multiple partitions are used, you may want to enforce different
> subsets of the available write hints for each partition. Provide a
> bitmap attribute of the available write hints, and allow an admin to
> write a different mask to set the partition's allowed write hints.

This still offers all hints to all partitions by default, which still
breaks all use cases where you have actual users of the stream separation
on multiple paritions.

Please assign either all resources to the first partition and none to
the others (probably the easiest and useful for the most common use
case) or split it evenly.

Note that the bdev_max_streams value also needs to be adjusted to only
return the number of streams actually available to a partition.


