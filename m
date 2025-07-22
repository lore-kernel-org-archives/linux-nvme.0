Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DAAC83F34
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 05:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RvUE8Ko3tN82VLX6x7WZCQSBikLigJk02T8BzcMljwQ=; b=2E4feazsAh+ukmigZTCHVEh2Mt
	BNBca6X1Q9Vr221y0K5wZUsC5bnYodCS0OICVdm3teywZRdebxTsiWMbqAKwtEntHWXTW23Tbxtkw
	XgSUU4/kz96I+Eni76ZQ7hI5b3eDWlTttIOmEdA1UfiWtnKtatND6oxWpT0g0370devhwGJAY6AoL
	pzoBcP6AFVbxNwEXIEY65ZzibB/aXULLJJ/c15psanpobpZd5WdFggleC56LXhXeY+ODbSkvCbqoA
	VF6nEtj7A2gzI3tkuvhVs7ehh8jH9RA/KDN0hkg/MdiM+bAvURe7H17loxBjTCLZltxOP3Dii9XbW
	h7FEDO9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue5xh-00000001N8H-1b0J;
	Tue, 22 Jul 2025 05:54:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue5sp-00000001MJX-0nzV
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 05:49:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6EDDA68AA6; Tue, 22 Jul 2025 07:49:41 +0200 (CEST)
Date: Tue, 22 Jul 2025 07:49:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, leonro@nvidia.com
Subject: Re: [PATCHv2 7/7] nvme: convert metadata mapping to dma iter
Message-ID: <20250722054940.GA13634@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-8-kbusch@meta.com> <20250721075053.GH32034@lst.de> <aH49fa1qH4HN5P7w@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH49fa1qH4HN5P7w@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_224947_445962_833C714A 
X-CRM114-Status: GOOD (  16.85  )
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

On Mon, Jul 21, 2025 at 07:15:41AM -0600, Keith Busch wrote:
> > This should probably just set up the linear metadata pointer instead
> > of a single-segment SGL.
> 
> Okay, but we should still use SGL with user passthrough commands for
> memory safety. Even if we have an iommu protecting access, there's still
> a possibility of corrupting adjacent iova's if using MPTR.

True.

> In this patch, the nr_meta_descriptors value matches the sg_list length.
> The only real reason I need this 'nr_' value is to distinguish the
> single data descriptor condition from the segment descriptor use, but I
> can just add an iod flag for that too and save some space.

Yes, that would be great.

