Return-Path: <SRS0=WNe8=AW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1517CC433E4
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jul 2020 20:35:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E4220720
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jul 2020 20:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TzQBxCz9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CxlleSzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E4220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VuSMMb1Ibl3v0RwppNzLHZPAkr/dzPU65Nl35tzDxDE=; b=TzQBxCz9R9V9KdipZ/+gf7RCE
	rFW/uQmyaJCc9nSiq+fAAf5AHXExp0/V+L3OQrbq7SS4iYbaR8DU3IauOkSi1XQoy3VmCWMJrn9eI
	2PNeWRKbYS6Q4KGvIGGklr9EBe2u04ttZz/+YhWj0q7nV6FEtKRDqihk5Sd2vaP00sayDpoUWSugr
	wHI2YtnMFNrqzNSl4hiO4v2QDthToBARw1zYBg3mLSvCbc17Ow4gaI6F4WpSrXeMbnvPPn6A7eQT8
	hE7rPOBVL730ZUEK+l7KKk2IdGFeulqepdkSx56I3LixuZUNg1OqQvBvKHTGVFfhMAo1nfIFp0/rC
	jWeRGYhsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1juMDQ-00080a-1L; Sat, 11 Jul 2020 20:35:20 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1juMDL-0007yq-Ag
 for linux-nvme@lists.infradead.org; Sat, 11 Jul 2020 20:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594499715; x=1626035715;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vugoLfM44c3n1nMUFImmIAherFC2ReUuXXO9jJjlt/M=;
 b=CxlleSzjCIoVJU2wvA1yKM6H1w8O0PtpUFZB1118R/kTB49+MreP1EaG
 loWR4AU3FEEAVF8ktpeZoyghPVn/v37XMUy5E2rT6CrzDI4gu093I42aQ
 msNLTYfvW5hcGLWtsU341YEF8Uh1UZPKUUIINv09179w8pHYtR1aXLBM1
 KrwsI2Q0Qnrnq9/H40nJWxf5XDQ6M2eD/z1MAWFdIgEQCoEVy38ydpEt6
 gWQyTNBx3od7LP5VtMbJ4asFXm0qZCpEk7e7lZyMdeiOyqKzKYFXUrMBL
 eGvMWguskeDsuNfjR1+IAE/R5QVu1lQjzOUzo0TQ2+lfEVI8VZOoRX9Cv Q==;
IronPort-SDR: VMtYPh1jKFDWNIQXbTVe+7SsE5wT/0+a6AfIz//dGjO8p9O+o8bZemxeK3ngSdV51zWGcfXKvm
 gFb/+I+J2oGRl5DXPfF22q/fQc1bCCMVHjVaJsl0AnG8F55ndyKOlvhy930g25fP1EOv/7LAZC
 cj/1RxEs/ItPx60f2KVLCqVWbUFyLy3DepMJtEyr6zbQf++Co3q5VsipduNNCc/cso2WjoIu10
 Tk3aZ7OuywK4hP6BIqPgrw/qfsrrsZE6RKROdCYiYk2CG9E7ljwinS0cj24ZyIozJuzPeI3mDd
 l1w=
X-IronPort-AV: E=Sophos;i="5.75,340,1589212800"; 
 d="scan'208,223";a="143528829"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2020 04:35:15 +0800
IronPort-SDR: b4Kj3BSYeWT28B1wHV7nordSZSKCcTHeQLQkho8EpbcBNyqu1ZmjFNZAQwJ+pmSgZCLFjzl7lm
 fYijzVdkas3aAidT4d4+kq8lhQK1luccU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2020 13:23:14 -0700
IronPort-SDR: 4fsk8lUAHG7eLD9X4YGkLHBVuCF+YB1XfbcuRmzGiE7DLtr8IUcjx5Tk6VaPKvAGCrGcP2knnW
 WdrJTlmecrpg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2020 13:35:15 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@ls.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH V3 2/2] nvme-pci: use max of PRP or SGL for iod size
Date: Sat, 11 Jul 2020 13:34:54 -0700
Message-Id: <20200711203454.9091-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200711203454.9091-1-chaitanya.kulkarni@wdc.com>
References: <20200711203454.9091-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200711_163515_550430_F9135E11 
X-CRM114-Status: GOOD (  13.52  )
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
 drivers/nvme/host/pci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b092df266501..19e27dd17108 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -363,14 +363,13 @@ static int nvme_pci_npages_sgl(unsigned int num_seg)
 }
 
 static size_t nvme_pci_iod_alloc_size(struct nvme_dev *dev,
-		unsigned int size, unsigned int nseg, bool use_sgl)
+		unsigned int size, unsigned int nseg)
 {
-	size_t alloc_size;
+	size_t npages_sgl = nvme_pci_npages_sgl(nseg);
+	size_t npages = nvme_npages(size, dev);
+	size_t alloc_size = sizeof(__le64 *);
 
-	if (use_sgl)
-		alloc_size = sizeof(__le64 *) * nvme_pci_npages_sgl(nseg);
-	else
-		alloc_size = sizeof(__le64 *) * nvme_npages(size, dev);
+	alloc_size *= max_t(size_t, npages_sgl, npages);
 
 	return alloc_size + sizeof(struct scatterlist) * nseg;
 }
@@ -2812,7 +2811,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * command we support.
 	 */
 	alloc_size = nvme_pci_iod_alloc_size(dev, NVME_MAX_KB_SZ,
-						NVME_MAX_SEGS, true);
+						NVME_MAX_SEGS);
 	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
 
 	dev->iod_mempool = mempool_create_node(1, mempool_kmalloc,
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
