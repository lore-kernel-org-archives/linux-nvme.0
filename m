Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A27C5DF70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 08:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KfyNWi8GvGQdAxlxz5rE47OgKqaKDj8PuLL4B8yh2E0=; b=Lf3UOkKabtjl8vvq46dAl1Qkj+
	OGggSx4c9vAYVN/zWKc93kWA5+L/dGHAlPk7wOPYTyfOYYbYlpgYqHBuzNDlPYv/LICfdaslGugd/
	04Sq5X21XmpGokxiXhJLAKSqwOomvHeHJy2OHNotjCxMbmW9KGpIelAlXhHP8r6KDavnVZzK/Y4Qr
	cTNIM+2LSaLW1lOyQXi81w7OBU0uEBF8Kzc3NeP4yCwbet+OQ6/GukHK1ZTscMFhSPMlWhYneBYrF
	edFqyDophKc7ZiGYKLfi1aLf3oVlvabUAvb4LwL54jjrnC/9FYXtp6qxkKruTbyIz//QjuLWYMerU
	Vs1CqHWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsq4-00000005iCO-0XNs;
	Mon, 17 Aug 2026 08:37:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsq2-00000005iBm-1J3i
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 08:36:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F27868CFE; Mon, 17 Aug 2026 10:36:54 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:36:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, John Garry <john.g.garry@oracle.com>,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: dma_opt_mapping_size returns way too low sizes when using IOMMU
Message-ID: <20260817083654.GA23414@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_013658_508840_81202820 
X-CRM114-Status: UNSURE (   8.12  )
X-CRM114-Notice: Please train this message.
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

Hi all,

I got reports that NVMe devices were arbitrarily limited to 128kiB
transfers in recent kernel.  It turns out that this only happens when
using an IOMMU and is caused by iommu_dma_opt_mapping_size returning
iova_rcache_range(), which is defined as follows:

unsigned long iova_rcache_range(void)
{
	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
}

and thus indeed hardcodes a 128kiB return on 4k page size architectures.

Both the NVMe performance numbers and common sense suggest that this
is NOT the optimal DMA mapping granularity.  Can we pick a saner value
for iommu_dma_opt_mapping_size that does not restrict common I/O sizes?

