Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCEBCCF9E0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 08:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zvRkgebeO4b3tYvqwVURdYgZyqJfNUe5u6OpKoDvATM=; b=iB1DW29Zj9Mp4UxZCH+GxX7vKK
	8wLUIXMyroskPrduj0WMFkF/lRfBYAxURvz8Rs1tBNyoGjPWPnoRyVYDBMmiQcqtbZj8pjiLJPy2c
	3S7TNjbr+4Yqw/U34L09MN8wdSo9dMM42JGEHoSmES9lkdnxtSH4XJoUAuuGEVUsrc04drIHJsPaS
	Ywgul48PDXy5oPg1R3UpP5VzUTjgEWxJc+Afxr7E9KR/5cOwVJYgm31kO1dV7NNzeMy4zmYQie93f
	5djg3X60PbeNgv5zfHONKgUKafXzqeE1YqjGpSPEnJqVj6iigsZxSdMUvfJNW1pglfUD0+EDJHgw8
	6tdtoyBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIKS-0000000DKQS-2v7D;
	Mon, 27 Oct 2025 08:11:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIKR-0000000DKQE-3byn
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 08:11:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 05CE0605CB;
	Mon, 27 Oct 2025 08:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A18C113D0;
	Mon, 27 Oct 2025 08:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761552706;
	bh=LsO/MJw/AJqdqKC7ddkKYCrAbIsh8PHQaAB1Eh6VHBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LV8C839OFzewvtfZUREE/0JxblWlKuETClB1qIvkcOjxUpclNy5TgYKvngOGzMPL2
	 2NRBWiquLHyN1Eov0werOznTjkJoyaeLUw2pJlPPUkBu2WlNcqkpo3UwAFsmNHxp7x
	 9kaiak4v4c6wdPJ+kTzGCAqieit/+cJg2LPfuWaUtvvv1jqHIV3gZQ1oqh4PKhjSSu
	 j/PN4RDWrY8Qr9GA93MnU29MxSQUD/461kWd6OvTOCz5GHlHPetOQbgwR6WnUy72m3
	 8MZbN5KHzPKTGnIm+aq+WT6bcbtEVMq9J4PblkB10lZW8qe9sw4tofl9pD+f0uIRGM
	 DNwJEdnqFrCHw==
Date: Mon, 27 Oct 2025 10:11:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251027081142.GG12554@unreal>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
 <20251027074922.GA14543@lst.de>
 <20251027075738.GF12554@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027075738.GF12554@unreal>
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

On Mon, Oct 27, 2025 at 09:57:38AM +0200, Leon Romanovsky wrote:
> On Mon, Oct 27, 2025 at 08:49:22AM +0100, Christoph Hellwig wrote:
> > > +	switch (iter.p2pdma.map) {
> > > +	case PCI_P2PDMA_MAP_BUS_ADDR:
> > > +		iod->flags |= IOD_DATA_P2P;
> > > +		break;
> > > +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> > > +		iod->flags |= IOD_DATA_MMIO;
> > > +		break;
> > > +	default:
> > > +		return BLK_STS_RESOURCE;
> > 
> > I almost wonder if we should just the pci_p2pdma_map_type values into
> > place.  But that's a future cleanup, I'd rather get this going now.
> 
> I thought about it, but decided to use flags as more space efficient.
> PCI_P2PDMA_MAP_BUS_ADDR == 3 and PCI_P2PDMA_MAP_THRU_HOST_BRIDGE == 4.
> It means that will need to occupy 6 bits (extra u8 IOD field), while
> this flags encoding takes only 4 bits (without extra IOD field).

BTW, one can reorganize pci_p2pdma_map_type to make sure that
PCI_P2PDMA_MAP_BUS_ADDR will be 2 and PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
will be 3, so it will be possible to take 2 bits per-type instead of 3.

diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 951f81a38f3a..2280e5a55b1f 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -112,14 +112,6 @@ enum pci_p2pdma_map_type {
         */
        PCI_P2PDMA_MAP_NONE,

-       /*
-        * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
-        * traverse the host bridge and the host bridge is not in the
-        * allowlist. DMA Mapping routines should return an error when
-        * this is returned.
-        */
-       PCI_P2PDMA_MAP_NOT_SUPPORTED,
-
        /*
         * PCI_P2PDMA_MAP_BUS_ADDR: Indicates that two devices can talk to
         * each other directly through a PCI switch and the transaction will
@@ -136,6 +128,14 @@ enum pci_p2pdma_map_type {
         * case of IOMMUs) should be used to program the DMA engine.
         */
        PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
+
+       /*
+        * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
+        * traverse the host bridge and the host bridge is not in the
+        * allowlist. DMA Mapping routines should return an error when
+        * this is returned.
+        */
+       PCI_P2PDMA_MAP_NOT_SUPPORTED,
 };

 struct pci_p2pdma_map_state {

Thanks

