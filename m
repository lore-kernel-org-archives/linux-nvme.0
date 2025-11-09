Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF624CCFA13
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Nov 2025 07:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QbSU8WwH8o/pvFyEY7X56WQnMaIFYuNg/VBUSYIIe2o=; b=Z7ZIzjrFfKN4tFUKFJxg9qQj9o
	t6aVdA5g+blV2FaZT3/rIpb1nULuiIEBjz3QW81HFRkmMvSn8u2OdSr59aUlyNMYgyRwDIl2V8IGR
	JZ/t8OmwIoPfxVAEzcCSULqd2ZryMMXzV6+K0Cu8ijjeyQIsH1NYk6tmVpIKSvxqvMexhQY2/5zx1
	D4VJkYU7wpdLdmiGB/dOrrkmm7Xg8GR1OT0uI3niNH+9XGHIqIu6Rqw2KfzsPIB6ch9b/HrEaSRga
	F37XfXIjpkAJbZbwc3pIR4Zl1CTkwXu+e1i1Gb0kcqz1xRAo3/sdhHrUSwTlguyo+IFl8Zt8bqytg
	KI0umAkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vI0F3-00000003rD6-2iO4;
	Sun, 09 Nov 2025 07:53:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vI0Ey-00000003rD0-2ad3
	for linux-nvme@lists.infradead.org;
	Sun, 09 Nov 2025 07:53:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7F411601B2;
	Sun,  9 Nov 2025 07:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6352C116B1;
	Sun,  9 Nov 2025 07:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762674815;
	bh=8/s0g3/HR6w0jvIa3DYIzWrYnWPBXTPU6zLnENISR1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amHhB4CueYIvHhewZqF9CMedmqR3/FLxgK0n679eJcYLyjy2og1DU2Fa9if1ZPpuX
	 m1aaw+NDQ42PBEWcq63tL2dnznVOe6eTA9cIiHo1llS83SFZFj1RV0QTKfZHCT+2a6
	 s1K7AJ4reeDOe1pGDDA03wZgJIzX89AlNpMIcFUeuOTZpcC0DerXKkNLudGZq9FRSn
	 XwMTHB/msWU8j31CpqLF6Yl2NwXmbBub3f0vZlyTFwBfgp53P7sMI6y+TFHHnCDFFL
	 BnubK15RAgs99bag6IIDB928jxCOx4KEyymw/iH4Gil7wSZlV/T6HUARYBEjvQXbny
	 txVbjFFjQX8Tw==
Date: Sun, 9 Nov 2025 09:53:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
Message-ID: <20251109075331.GA376289@unreal>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
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

On Mon, Oct 27, 2025 at 09:30:19AM +0200, Leon Romanovsky wrote:

<...>

> ----------------------------------------------------------------------
> 
> This patch series improves block layer and NVMe driver support for MMIO
> memory regions, particularly for peer-to-peer (P2P) DMA transfers that
> go through the host bridge.
> 
> The series addresses a critical gap where P2P transfers through the host
> bridge (PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) were not properly marked as
> MMIO memory, leading to potential issues with:
> 
> - Inappropriate CPU cache synchronization operations on MMIO regions
> - Incorrect DMA mapping/unmapping that doesn't respect MMIO semantics  
> - Missing IOMMU configuration for MMIO memory handling
> 
> This work is extracted from the larger DMA physical API improvement
> series [1] and focuses specifically on block layer and NVMe requirements
> for MMIO memory support.
> 
> Thanks
> 
> [1] https://lore.kernel.org/all/cover.1757423202.git.leonro@nvidia.com/
> 
> Leon Romanovsky (2):
>       nvme-pci: migrate to dma_map_phys instead of map_page
>       block-dma: properly take MMIO path

Hi,

Kind reminder.

Thanks

