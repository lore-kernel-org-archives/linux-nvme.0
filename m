Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABCFC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 00:59:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB28206DF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 00:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BG/GoGVd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B6haV5Uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB28206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gq++i47BVIvMQKLMuXdWBZp+vjqtS9AbUtYsZrH6ut8=; b=BG/GoGVd5wg3ZKFf2cfpClb9P
	Vz+DwQ5As/MqfBkd3riMQfeft6lDMUqnLpPk72eGQoWtconTNgmBAS/osoJqNIYDwlnephWJEJ3qi
	uuX5lB4euDV6BKc30+jYI29KU8xlbw2t/WNz8JIvUEaILPc1fP/u8UX1oEMz/KC1dI98sfvJUuqgW
	oSwxd0WVtf8zgT8APqekuARMMKRSLLXng9eGJrCzbj0zgGL6MyGXASSIAzMVIXh7l+Y3+bVyE7+aE
	LyH9DSSpFzLSIvfDa/oh562M/D3eJ13vfStinWYLM50nPSJaQ2dhHHzFDt+LbQ5PUDTtaKdT6fmRY
	qWY7Nwhjg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsyQI-0007Pf-2b; Wed, 08 Jul 2020 00:58:54 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsyQD-0007Ne-C9
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 00:58:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594169929; x=1625705929;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5nh9xHm3vtTgkAV4CTG1HbuHNEBgV2rQpEJNqHo4m4Q=;
 b=B6haV5UcrmZqgvxv6a9KKDpOZrPwE3YogRbx2R9IppVDLXwuh67CWkr2
 35K3Hp6wzraG2XnI2crO3Xw6zehfM3xVMHn+U1nN1u61bOzSBopNM7G+C
 wb4XKyLJtgAWIxneROsQyQrHgle6HyvhHK/JPTH5fgl+dIQ4aR4YHOOkF
 LeN+Gsipp1uxYuDZlKC/DEkfAf7y8M7XD5EiCRDjxoMOTz2KgANv4XpON
 cE40Ui/uaa5Ac5LDQmOWUW0Of+x6/IYrDLWTgym3eQuWzlUTRq9saSbHq
 xsk2+JpepzFfQtpoybsixEaP7O2z/bOnO/8tsnLwalhYKWL3/aJuaZQ/z g==;
IronPort-SDR: EHoTBMIRmeDav3lbIy/p+IOSooAzup/L87nf8hT/biR9NzWvv1deA8vOo08adTXnytI5gq2RUM
 xwpTdcgv/xDO8dZalizmdgt9PYHsm/zmWLvUdeSO1vWQn2g6agmxnTKLgHHrUopyHtes+nDeuB
 saMM+aAhLCN4LKkpVlCfPHjeohTTmeYlmE/M7YX4nIzSfqO2zhRxz5bBaQR3fyba2/oQcIOp2A
 6KOw2ug6EdnmotxJiWuWKSAC3eWnMaQYUqdcuL/kdRIny+cf4Xzf2flW/S9F5ftuLQHjU4PDin
 Hnk=
X-IronPort-AV: E=Sophos;i="5.75,325,1589212800"; 
 d="scan'208,223";a="143204241"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2020 08:58:49 +0800
IronPort-SDR: eJ2ldhXIyJgx0Ego/IAcL1vsj4ey0hnD6lW63wQ9R3B4FxfTvKwWzHOXj1UAPvjAW4qtkm4gcc
 O8/gpRenl6pGuQiAYmDmCOfzOXIXFALY8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 17:47:28 -0700
IronPort-SDR: EZkeZGRZLGAAU8QLo5gtWxzsjkCUSLIp21YjWyLFcyHUd3NqNoCLKxTHx8lUOWp2BGFc/+MNnW
 kp8hU7+DtG5g==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jul 2020 17:58:49 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH 3/4] nvme-pci: use max of PRP or SGL for iod size
Date: Tue,  7 Jul 2020 17:58:30 -0700
Message-Id: <20200708005831.10013-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
References: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_205849_558903_628ECA2F 
X-CRM114-Status: GOOD (  13.72  )
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
index cef87ad2323f..0588bd053a2a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -370,14 +370,13 @@ static int nvme_pci_npages_sgl(unsigned int num_seg)
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
+	alloc_size *= (npages_sgl > npages ? npages_sgl : npages);
 
 	return alloc_size + sizeof(struct scatterlist) * nseg;
 }
@@ -2819,7 +2818,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
