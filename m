Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75DAEEB591
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 11:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lnv22ho9UPmeIkvMTWgYqimBSgTdZG5s6KWeUG6lN8E=; b=FJUZN28zOrREePTZxBSY9LYsS7
	rLGC3/WoZb16EsrjfsLeLA4WoE73wUgn/7NmIVd2qIDzRjrnlytl7x1zEaexFLgCkVnDVyWxgSGx7
	lm+guafG3SUea5hl2YQLq58KQoLFk91SVeCKhzbsjOE0dTep/3j9MTS3cTlGfm36fZjEKLM2oav82
	MRxULOpdS4R7iiln7NwgBrktSGit9lGfopgyXMcVup6SZfhvzfjb/cmEbJXWWhvweewlyBmG0WjeC
	Fh5PwYztaZxBcJw5wXGZ0cgEp9zjpoVQgON24DNZxCs212V8MEHPm7+PMV53jcIsTOMB9JhTVU8kP
	+xzZwv8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohpV-0000000CoTJ-0IZw;
	Thu, 12 Sep 2024 11:17:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohpO-0000000CoO9-2eiL
	for linux-nvme@bombadil.infradead.org;
	Thu, 12 Sep 2024 11:17:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Lnv22ho9UPmeIkvMTWgYqimBSgTdZG5s6KWeUG6lN8E=; b=WmDiC9FUNrtRQUF5SJL8Rfgxzo
	RABW6ZozQeLLrFK0iIx2DwFck1B5tAmia1TPjTuqaOqmlqeQZ7fpDJnKmrYLMIEGYtM33kUcBMp12
	sxOo7Zq+Mb0cPuamzu16hi+NOUQ5u1kY/6lg5GoXUKExAvyF3ddeE0EAoFusMxVqFbrlmcmrTE4yb
	flTkbvTwqbNJRC0B2e3uguHs71aUZrIrrtgqdZ0JlzqTpP0LTuOjRXbkQErPRIdPOdg02hucc1Wpt
	w9B2S7SE2tYZgHLywAr9ws6iKejoTrer+rjqyRFO/+OPAfuOxANFj0zPCfT3DhiK3cOeWS5gXmPUM
	+EpAEtnw==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sohpH-00000000RcY-2xrv
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 11:17:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 767CF5C0650;
	Thu, 12 Sep 2024 11:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE14C4CEC5;
	Thu, 12 Sep 2024 11:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139845;
	bh=HzFyylaMePR5bS7VyKQApbkFy4MWvNmh8/Ifgo8KsU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMt/9VHSYIlDpVGdX26n1N0CdVrTRm10It8Sa8NMHcf+17B/DEKPd5jcRIQstDF5l
	 y/zknkTz0QWWnnaDNoU/w5MrYILx1JHP+V4tz9u84Cewb0+/xN0X7Xobu9RYdt4sE3
	 8QSp8DqCuKUgnnC5JLgioLFGolGO2jWjErhnFWAI64U90eRPEY/a80PM1URWvna2tv
	 EjnP1bBa2i6W+ZV7YFLYJDEIpcKOoFD0i83H5rqEd6sFjATC3qHX2bD88Wi/OivMQx
	 jvCqxXIec8J/zMqtF5Uhjik7uSRXJU4fi3neuttBSeo6DVEN/1c89HG77KYw9oQArh
	 FWiOq1isCI2iQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 21/21] nvme-pci: don't allow mapping of bvecs with offset
Date: Thu, 12 Sep 2024 14:15:56 +0300
Message-ID: <63cdbb87e1b08464705fa343b65e561eb3abd5f9.1726138681.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726138681.git.leon@kernel.org>
References: <cover.1726138681.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_121727_952601_38A5B2C8 
X-CRM114-Status: GOOD (  10.25  )
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

From: Leon Romanovsky <leonro@nvidia.com>

It is a hack, but direct DMA works now.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 881cbf2c0cac..1872fa91ac76 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -791,6 +791,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 			return BLK_STS_RESOURCE;
 
 		rq_for_each_bvec(bv, req, iter) {
+			if (bv.bv_offset != 0)
+				goto out_free;
+
 			dma_addr = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
 			if (dma_mapping_error(dev->dev, dma_addr))
 				goto out_free;
-- 
2.46.0


