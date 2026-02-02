Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E966FE7DEEE
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 14:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=Ngtb6pX+4QwGV11qxDiPUfTqyUjfJMYNVzKc+uUzBds=; b=cWRhfQPEtxWnvs
	mlLcPxBt/m+GsrdqYHhiFi7vmAl38+KbqahdPNrhX8D7Vh1FITNb3pFqzjywptbQOmoRm4jTK42Gl
	n6vZRwJ2ymTTcfxQMigHaGeonUBST+lrVbKfGEtDJVN3jQdJS6xSPX7wDrWI3BRqR9D7LCWDWmcwQ
	9yQWfrOxLlQU+Fddc4F1Wi0GvSgHl4u8sQgzcHUa5WkSGdd7QPQsJsy6uHevVNrfbEPj/QgE/afS3
	yFQlOqpzAowPAeerbtWpHU8UTy2kxMNal/c1rh9Q7Idc8bnw9dq/FaWOzrggEyI76JwYX8UKjqgcm
	zOY9SutxcjBwJQx6UM+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmv1x-000000056i8-1urv;
	Mon, 02 Feb 2026 14:35:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmv1u-000000056hF-2xeT
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 14:35:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4DAE68B05; Mon,  2 Feb 2026 15:35:48 +0100 (CET)
Date: Mon, 2 Feb 2026 15:35:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nitin.rawat@oss.qualcomm.com, Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260202143548.GA19313@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202125738.1194899-1-pradeep.pragallapati@oss.qualcomm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_063554_906306_0E2A7AD0 
X-CRM114-Status: GOOD (  15.52  )
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

On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
> Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
> when SWIOTLB bounce buffering becomes active during runtime.
> 
> The issue occurs when SWIOTLB activation changes the device's DMA
> mapping requirements at runtime,
>
> creating a mismatch between
> iod->dma_vecs allocation and access logic.
> 
> The problem manifests when:
> 1. Device initially operates with dma_skip_sync=true
>    (coherent DMA assumed)
> 2. First SWIOTLB mapping occurs due to DMA address limitations,
>    memory encryption, or IOMMU bounce buffering requirements
> 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
>    dma_skip_sync=false
> 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
>    iod->dma_vecs

I think this patch just papers over the bug.  If dma_need_unmap
can't be trusted before the dma_map_* call, we've not saved
the unmap information and the unmap won't work properly.

So we'll need to extend the core code to tell if a mapping
will set dma_skip_sync=false before doing the mapping.


