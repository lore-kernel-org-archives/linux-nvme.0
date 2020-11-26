Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA6CC56201
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46132206C0
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JWCV8ceq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mQtyOE9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46132206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/1WytQkJcQbwSHBb+bj43DakB+PRBzfpTQYqhiOjXpY=; b=JWCV8ceqRWJpMwmUMROUBAnhH
	XoZIDrKdPeiGyIOcgkROXzFocBR1E6HzQ/9GradBt/Yw7y9IGkmPvcOQuxdiE9bHGU63ajAIdWI6Q
	qV26w2h6iWuhMAmoswXqiF1ZqIBrTg5vNdamp+CyrHDDUOcJh0G3QG2gCkhkW/2WNJ7qyymMDJ5ZN
	TcZXBs5sQCAc7QGIc+UFaiqKwKpyzAfdZRN8elv5zcV+LrqdND11rgijscwLyD9pXWFdH6yMY0YRq
	VqFzq9X236z9AG2fqfRcdz71SlqTf9ZJPFOtDA8Zb3Tox8zGpgHd7dMToS3Hau9Rm9LxBRqIaJFtH
	9zbpfYQ7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki7ER-0005Lb-Gb; Thu, 26 Nov 2020 02:42:03 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki7EC-0005GN-6U
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 02:41:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606358508; x=1637894508;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m/bvl+lK7ll6HRYiQ0kG1ndR5SFePuzrxfzuz5g9atQ=;
 b=mQtyOE9BHAJNbC0hotVi/SOMxqGK2gEW3eZymTpJDC/8FZv8eew1nrZa
 cV3HXB8xbTVEeczAP4Ce4e5WpJuWWJHh+fX2Vnn+Vf/b1OfUB7MjxJG6+
 jL1yY+ZkLOOc5cfePE+RuHRFmmN9v0ZsCM0ePMHzlMLpiHQCNy3NJ0XR2
 +qtStrCejt1V4BnSe11XcI8fUfnOS85KyOWJac486qiM5di3SODxrXjzt
 is231S2GUWVCIK6mYuBog/s998OwEw5EELOTH1+w6/FxlXTu56uMZs7vj
 tNalYxIkwExGlX9da4mxJpM45eO3X2KXZ4J8FdNE5JkPdfLxHwUbq5A7i g==;
IronPort-SDR: iXoVa27Pbr5IZjlzW//ejVsU8PP2IBrJLdlhuuFjY+b61xtcSWmiVRet2s4HDTVd25BpEzewWf
 T/9umM9Om/mb2epxYr+Q9vk+1trv4RhaiHIBXDaqhQdw8nwyVK30hV9DsaqDsHqLcL2ce8l8iG
 wn0qfD/oLZ8ABbSVw0qhI8dcisD7vCf0jLQ0Wh/O2Bbv5KIQJjr9z+J4Cyd9OZ6vOTedoQ2lnp
 UcjlSPttON9tJkVJpnJHlvtcVwgguXsQXIcaNzb2UpRXUOoog8DZmCp0ozkMkEgxLyTtNBEzD+
 mVA=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; d="scan'208";a="154714086"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:41:48 +0800
IronPort-SDR: mV2tPR/XN7MKofgNNtQyac6c1CHD8crVUWcY5MLa23c8V+Pixp+yfU7XHL+viN6nfOgMShOlqv
 S1ZyWXVdJXu5lU4JLjjb+NZMHXa7QLzS0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2020 18:27:29 -0800
IronPort-SDR: +iWkemWLEus9/qEDz+arSjP994rS0injMOm4Whacc+3WhZcSMUYFyUUIhPFKqwO10GgcjboJCV
 6FfkLyZHkgLQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:41:47 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 6/9] nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
Date: Wed, 25 Nov 2020 18:40:40 -0800
Message-Id: <20201126024043.3392-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_214149_184364_E8136EDF 
X-CRM114-Status: GOOD (  14.12  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Update the nvmet_execute_identify() such that it can now handle
NVME_ID_CNS_CS_NS when identify.cis is set to ZNS. This allows
host to identify the ns with ZNS capabilities.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e7d2b96cda6b..cd368cbe3855 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -648,6 +648,10 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 	switch (req->cmd->identify.cns) {
 	case NVME_ID_CNS_NS:
 		return nvmet_execute_identify_ns(req);
+	case NVME_ID_CNS_CS_NS:
+		if (req->cmd->identify.csi == NVME_CSI_ZNS)
+			return nvmet_execute_identify_cns_cs_ns(req);
+		break;
 	case NVME_ID_CNS_CTRL:
 		return nvmet_execute_identify_ctrl(req);
 	case NVME_ID_CNS_CS_CTRL:
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
