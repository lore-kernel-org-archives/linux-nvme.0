Return-Path: <SRS0=QPGu=A4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5B3C433E4
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 00:52:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A63B20787
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 00:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FhwoixVN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WJ+SdAJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A63B20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uYFxxjHYTBlp+jO3dBxrHY+C0NQK1diwjaw7EdjNYTY=; b=FhwoixVNf5kO4FeQXKRB7Rlxp
	6uEYw530OO8n2mZc4kG0McNnEvBNOSnscuilvBqin77QON3wXunA3y1Sewkgc9Ij3fP4AJpD5wdp1
	zSjo2tpdl6i0BTYCFxv/x+5oFKOac+/R+t1n8gcVR6AkGtS4hWi11RQ5ifP5OCRtigrIIzjNARR+u
	JS9ILDAIbTUFln4tqUuyFJDcKe5W6uLn8dNrRrZKr3hrTG4RwyMdJgYiDlNXwId+CwwGn1BxINi1m
	ukCnR24QEX5FW1RuF2BMqRErKI4R524A4KA48RWfhhUBXqx8sD+VvmkHLA1H7WjVaw0zfJnkt6qRC
	Ps41oU5ZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwEbd-0008FR-AH; Fri, 17 Jul 2020 00:52:05 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwEba-0008Eu-FU
 for linux-nvme@lists.infradead.org; Fri, 17 Jul 2020 00:52:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594947122; x=1626483122;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hDvE6+vA9e8xwTD4FwbaifdoHyeeAK2Plnx8AcXYKQA=;
 b=WJ+SdAJwYgrjEzWHcDSRzQT19OuEMjOLZmydLxh9AT9TJhpyT9/WMAGM
 eHqJZXZMvOTGVQbKHtEZqphTZceJQQCtw3wKKEaX/D8YwLT8LBlSABtFZ
 I4faM2iScoDBSoR0g/q4UMLAYAvUoOw4j4nRrMgfk6XLF/51imbnlcUXo
 EGIa56vaaaLzlmrhcHA1BPg9tn5Ia5oE34VRuyOV3Xgodn7meicEkq8QE
 YfGp5iuDaG+dZZVxC8tGeXrwHxT4cw7Z+1H8j/eHANEbOUaX7Dxmaw3X7
 gcB+SXqx8Y+XNPx1wPCp4Tb0j9pT6zM7SFNF1Xt1WM19ah9Nm8tWthK1u w==;
IronPort-SDR: 6S3YexrOW2nLLg0lf4HWD9w+jwODd3w9CuHT8sNZ2l7qnsVS9O9PS+lEF+fc22679fVI7T7lUV
 MHi1bpPa0LN6bGetVHJbjJsjdGw7ly7IwdOZa5sqXsPnhzycb4KBcmJnmnKFyYfUeZXyS2uW56
 Q+IXhwvv6CtYKQ7jd8ECocMpoNpO0gDTjuatfGVRNXaVQototayqY1j9xFz+Ngu4/Egw5TiRwW
 koQ4rAQThypZqCCcileV+ylHWeFnbZzzmlA+bqKLfo2sdzzbqhqoa4Q6hyoAdkuc8QesyEuNEm
 tHA=
X-IronPort-AV: E=Sophos;i="5.75,361,1589212800"; d="scan'208";a="142786781"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 08:52:01 +0800
IronPort-SDR: x4+ygdNfuT3WQzj7V3D1Lrj5Er5z0PaL6ub4xd3sryvaeUOZ85QW5ctUSF5XbICD25qlM6M+7D
 qEoccKDBKQprC3OBDuHSdU6ifSS5wyoc4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2020 17:40:24 -0700
IronPort-SDR: 7Dnr3hGgyLo9PXmk38VQCVEwyUlKP0gxmJGI2mr1dQgBqJ5AaMwcBFIwrl+vv+VhdBqHYllMKf
 yX9oNAKEhvxQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 17:52:02 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V4 3/3] nvme-pci: get rid of the division in the fast path
Date: Thu, 16 Jul 2020 17:51:39 -0700
Message-Id: <20200717005139.18923-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200717005139.18923-1-chaitanya.kulkarni@wdc.com>
References: <20200717005139.18923-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_205202_679288_D790BF68 
X-CRM114-Status: GOOD (  10.08  )
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

Since we have a macro for calculating the size of the ctrl page we can
remove the division in the fast path for nvme-pci in nvme_unmap_data().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3c852a8f18ed..616db1ae137c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -513,7 +513,8 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
+	const int last_prp = (NVME_CTRL_PAGE_SIZE >> ilog2(sizeof(__le64))) - 1;
+
 	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
 	int i;
 
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
