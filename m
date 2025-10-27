Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFAECCF9EB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 07:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G0s9MwwxLq3gV7C6+9tWhyToaMARnCwXTEYBx/0Ceag=; b=16chEiqS1FxVZTHhIYPAWXTU+W
	D1UXlGbX1wHTvhEp9M1gmQ3DMPAs2SAkRGqIuRXAN1I1rGx4RdJK7kAmP04Xg9iJAd7IXaIHfK+oM
	YRvsWe/k01cpxm2ELpj6pbZQ+Db0RUNET5nAi4tEpgYFoE2yuFyv/0J4XIs0mQ5sVi51J6CmUUXYm
	0+gI1yT3zmLUUgDGWETDJpNsEYh4t2cPAl7puImAgEGmL5WFZKIqhsrZFnZIjVtpX3a2JkUpTp9nr
	xugp0+GY4b4pmqI5/Y4h5BSmfyTwWIrVGkOTjhj7RoVoHCHdszRVbIoooR8NSg3HINijVZMDJEsqo
	nzYILKYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDHQW-0000000DGEH-2WSC;
	Mon, 27 Oct 2025 07:14:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDHQU-0000000DGDR-1EG3
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 07:13:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CCA3F227A87; Mon, 27 Oct 2025 08:13:53 +0100 (CET)
Date: Mon, 27 Oct 2025 08:13:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: always use blk_map_iter for metadata
Message-ID: <20251027071353.GA13854@lst.de>
References: <20251020182444.2587155-1-kbusch@meta.com> <20251021071935.GA31479@lst.de> <aPebvnv3u6HWcqdX@kbusch-mbp> <20251026072551.GB12554@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026072551.GB12554@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_001358_479283_275FB074 
X-CRM114-Status: GOOD (  17.12  )
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

On Sun, Oct 26, 2025 at 09:25:51AM +0200, Leon Romanovsky wrote:
> > Maybe the data path should only use blk_dma_iter too. Is dma_map_bvec
> > that much faster for the single vector case? I'm going to test both on
> > real hardware and see if there's a difference in CPU utilization or
> > latency.
> 
> We tried that path (remove special case for single segment), but for
> very performance oriented case: direct mode without IOMMU, no p2p and
> extremely powerful RAID (~94M IOPS), Jens and Kanchan saw performance
> drop. On consumer grade HW (~2M IOPS), the performance change was not
> noticed.

Yes.  Sorry, I wanted to reply something like this to Keith earlier but
managed to drop the ball.


