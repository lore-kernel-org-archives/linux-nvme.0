Return-Path: <SRS0=QPGu=A4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EFEC433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 00:52:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07EB520787
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 00:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HdKX4c9T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eetPTBOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EB520787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Nzm7FXmyaJ0JoEJnEOc+ITaW0xqvuwfWmiH/CyHmdDA=; b=HdKX4c9TDvSmhI/+96ufqTu2m
	ptOvy+0OOASIIfqd6bDy3PygHJtevI68IvNf1iKD5AD/FwV4klJ/uK4po1KrKBZiz97sewCToMYAb
	fGl3ME6lHQpdooxIriJLGprtg9g9SlaB4bl6Aoe9axddKwzvLlNcE1FRXo4Wru+GDEpSHbT0ucDxD
	Fc5HSjUc2Ah4/Ip9I4RTL2iG7HJIN8cUO6q1s02q2fAmrwnKkR6PxvhP3T1cqj5Dmoxzubl2X4cX/
	hqAwm6ZJAzcbrCNrPiDi8QODauZSu8f8WMD+xmH8baZbHOB6BMLgAlsvFGw1Mh8EoYT3/kswvpqgF
	ub5nzyEEw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwEbW-0008ED-Cm; Fri, 17 Jul 2020 00:51:58 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwEbU-0008Df-CO
 for linux-nvme@lists.infradead.org; Fri, 17 Jul 2020 00:51:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594947117; x=1626483117;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/muXjlAIh3FJOFAr+Kbz2SlY/qu2SNuybOFf1CJNI1s=;
 b=eetPTBOft817bz6HKcXjcawqGD3FaYGbz9i/gerRHLHx5Fsq0FaAvzCh
 WAfUHeBcOv5XF7yHEVejVJxpWVYDf5x8yTyQyJGOJsDRN4wvEFDR4569w
 b8zux+buYJCSDCTKL+vfGNl288kmCziFMnmEhiVqMkFer1g73TVwSQ+9/
 vz1+5h7nUFIDLnlgyDl2CArdsIh/db4UyET2IVmYviBkMJ6cz0lvR7vkg
 Xlmp2kY65diEicgzdNry64m6X8HIdErxWaVyiNTt5s713ADVNWY0XeXj3
 yEkOH5oBNrwfoTZr4a4LuRy9vJKc6Djq4RHvHDPSEEarHm3r7i1tZfwJG Q==;
IronPort-SDR: /iTz9wxzh44NZEga7PCugDHmGqugaTwBO2Woc4ZrzDSHzSiN+uKaU59Gi+BAz6jNu/DomDLxDG
 492sZlpKarrIdqhNZq/dUfo5C7e+7FBFmUwo9dYV+Hh+fBbzXTzhivC1H7bLsFM98RrOOaWfqT
 atiDDzmrk8C16Ofw6MIxJ1/q2ZwRTWGKL2X1Yb5t6KuTX/dGcCbknJwYNcSHacypKxtN55S6dv
 MV7PGUZtv74izW7iLJw1GT/Xm3qRmQNk838G0sR1zZJZHjcvFRE/LaZxeAva2PagatWhTil4Om
 OSY=
X-IronPort-AV: E=Sophos;i="5.75,361,1589212800"; 
 d="scan'208,223";a="143955748"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 08:51:56 +0800
IronPort-SDR: k+qQgQ9Ak8K6yWMKRQU4RxtWa250qxiIc4+GeidaznPM3e5gVBG+1RK3CmfO3DDdYOa2mPVrxH
 87kiCpwA2lCOusznt/uc/kEOGIr6Ul1Cw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2020 17:39:45 -0700
IronPort-SDR: NIZsWh677clN7suNKiQqEj5b8+yMU17ZMHkxLE6IKYPeMRnajCZi/II/WmOkdyAPQL+wFexnfK
 +3flDk9Hu2Zg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 17:51:55 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V4 2/3] nvme-pci: use max of PRP or SGL for iod size
Date: Thu, 16 Jul 2020 17:51:38 -0700
Message-Id: <20200717005139.18923-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200717005139.18923-1-chaitanya.kulkarni@wdc.com>
References: <20200717005139.18923-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_205156_919899_20FE6339 
X-CRM114-Status: GOOD (  12.12  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From the initial implementation of NVMe SGL kernel support
commit a7a7cbe353a5 ("nvme-pci: add SGL support") with addition of the
commit 943e942e6266 ("nvme-pci: limit max IO size and segments to avoid
high order allocations") now there is only caller left for
nvme_pci_iod_alloc_size() which statically passes true for last
parameter that calculates allocation size based on SGL since we need
size of biggest command supported for mempool allocation.

This patch modifies the helper functions nvme_pci_iod_alloc_size() such
that it is now uses maximum of PRP and SGL size for iod allocation size
calculation.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b092df266501..3c852a8f18ed 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -362,17 +362,15 @@ static int nvme_pci_npages_sgl(unsigned int num_seg)
 	return DIV_ROUND_UP(num_seg * sizeof(struct nvme_sgl_desc), PAGE_SIZE);
 }
 
-static size_t nvme_pci_iod_alloc_size(struct nvme_dev *dev,
-		unsigned int size, unsigned int nseg, bool use_sgl)
+static size_t nvme_pci_iod_alloc_size(struct nvme_dev *dev)
 {
-	size_t alloc_size;
+	size_t npages_sgl = nvme_pci_npages_sgl(NVME_MAX_SEGS);
+	size_t npages = nvme_npages(NVME_MAX_KB_SZ, dev);
+	size_t alloc_size = sizeof(__le64 *);
 
-	if (use_sgl)
-		alloc_size = sizeof(__le64 *) * nvme_pci_npages_sgl(nseg);
-	else
-		alloc_size = sizeof(__le64 *) * nvme_npages(size, dev);
+	alloc_size *= max_t(size_t, npages_sgl, npages);
 
-	return alloc_size + sizeof(struct scatterlist) * nseg;
+	return alloc_size + sizeof(struct scatterlist) * NVME_MAX_SEGS;
 }
 
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
@@ -2811,8 +2809,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * Double check that our mempool alloc size will cover the biggest
 	 * command we support.
 	 */
-	alloc_size = nvme_pci_iod_alloc_size(dev, NVME_MAX_KB_SZ,
-						NVME_MAX_SEGS, true);
+	alloc_size = nvme_pci_iod_alloc_size(dev);
 	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
 
 	dev->iod_mempool = mempool_create_node(1, mempool_kmalloc,
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
