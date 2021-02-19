Return-Path: <SRS0=4MGw=HV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7069C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 06:39:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543FB64E5F
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 06:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543FB64E5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KyA6fyeD4d8b+5a+s5jHpMdRd5acoP/X5pXIMBJEIa4=; b=p79zkN8rZiGdNE/MGOJkBeplIX
	dqd6zzLIowK5/7MDT4rYqIYY9FZ4R9riMBnJKIvA+XUKruPIMOOiN+8ciKe5LuJTiouRBI41kWUyw
	dq4b79R+acVaO+VWuBCo6puI5H7MpGfE+VWqD6KztmjO8GWT0lYJqWkf9LcxUII07KD86Ixl0JsQY
	vX2iznbsSIm6Q19QoujY156HGrMk0ZtvfuvE7+xthAOgvB15Wtdz41d8M06UEdv1H0K3So18L4Boy
	XzcE0vTAuo9aDQE+u/fSB0cbvLk2i3IPbocYrXTPeedDcLf2MOau4zhGwbx3cmGKN7X9TPD5IUrPm
	soX2tRIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCzQ5-0000zq-Lr; Fri, 19 Feb 2021 06:37:41 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCzQ2-0000zQ-VE
 for linux-nvme@lists.infradead.org; Fri, 19 Feb 2021 06:37:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613716792; x=1645252792;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wyiD39TeD5te1kFtncuH4MQwqrXYcNwqRueBG5aZ1DQ=;
 b=H9/VOyLHtcZEpvQi/x9+l3kEmfKvLGM4uc44hGLkZ4V4ny74RTKEwo4P
 86B0DMUvKUbMypc58zwKGdWaPHbb7lkQ/fefIOvZDaBVsbcroeBp5239G
 fCB/42eOy+L20NBqsYtTteo+ORYByqtGLJCA6fpSPZ8TL83tywv7O+Fw0
 5oDnD6a+qW8bIxHUZ6IHfuivihsAYkn0xsEFOLvN1ZIlPysXdTBuLv/vV
 pJi9R22hGOAiRFh7tTWjx2RSU5PcvGcXo/TU/p6/niyoA0vVHxsLKk43n
 TJVgaYgsxOiqozdWk9XsPVGPV6ojY3i6tRn13nxCiw6hYq43j4JxmI1Sd g==;
IronPort-SDR: gEB9YPlUq2NQYttbFxa9fFAGZ23rvT8yoigG0ByT6opk74IS+Z+u+iGY5U3c8XOGvntbKwHpLM
 YzYd2mxPSGs/ZH3NL6wz3m/d9CMF7C5KkPB2KfF8182/uhMMjIJbVbah91ySMOKCMGKArAzFr9
 gSWrJ1AJ4+jiT1/fxCyVfwAuaaz/FUafw4q8ZSD4eVVEbYFQl1r/Kvs9+GQ9gsbliq4vzmjkrx
 GY+dKqMOk5MCZUBAmNKsPxNVqpAhZYPK+FSVjZOOJhbKSrRI1rIpgZW+z4bizPEKR41LAgvrst
 4T0=
X-IronPort-AV: E=Sophos;i="5.81,189,1610380800"; d="scan'208";a="264514772"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2021 14:39:51 +0800
IronPort-SDR: cQI2JFX91lQmSceZBU4/jjo1fqClks9YiL33Ghe2+2gIb3OCgI3L/b095/3Nor2g3EId2ZbFMJ
 65FwDGvgEc177sfXS5K/a46fYhlSQUAlBL44zwJkbrYBlg+/hagII5cBPIrLlTmUTI4UD2gwul
 s0CXgpad4NIRfLtclxvzlZBlttqhb9mbGfxgCgYwv3G+Pi+wLwYym+7l644uBV7ecQyYU+Z+Tx
 QQMW8nCMmUZGcUAQkVIW15dgV349uI5DmQoReP6IRyR7I4E7//wKOc0O70Lcnut4j7Ikgwj68a
 ToBlAkvaIdjaHwiVjPYwk37l
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 22:21:03 -0800
IronPort-SDR: KUYyZuJa4lTfyICLl8ydU76aZV7ce6+vhL7w6ueZON/iKfgeMcnDnZ0Gzp77Tn6Xv3AVHBeTKw
 rUXBDi0EB7Y2unh+2hSLESOAAjsoGQ5FaqNCI5Y/NYplvl6JIx4aofVrQJWQv8BU9v3d/TCPeu
 QyNj4HX+6LupRQPhqquPIdk8khYRl8przJGy75ZiWhapi2CWaDwn5FJ9shO6+wzK2GzkdFimOA
 qIHYinRlaerfDGi+GjiRel4jfzUh1abL/6/96jPn4ek3ZKubg/rcWyXEpJCDQuWT3I3wUgC3JQ
 NuA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Feb 2021 22:37:38 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-pci: cleanup nvme_irq()
Date: Thu, 18 Feb 2021 22:37:37 -0800
Message-Id: <20210219063737.63800-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210219_013739_151218_69C3664D 
X-CRM114-Status: GOOD (  11.28  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Get rid of the local variables which are not needed. Instead rename
the function parameter from data -> nvmeq and return from the if
check than having a variable.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3729775f6a8a..922cbaa7e4ee 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1057,15 +1057,12 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 	return found;
 }
 
-static irqreturn_t nvme_irq(int irq, void *data)
+static irqreturn_t nvme_irq(int irq, void *nvmeq)
 {
-	struct nvme_queue *nvmeq = data;
-	irqreturn_t ret = IRQ_NONE;
-
 	if (nvme_process_cq(nvmeq))
-		ret = IRQ_HANDLED;
+		return IRQ_HANDLED;
 
-	return ret;
+	return IRQ_NONE;
 }
 
 static irqreturn_t nvme_irq_check(int irq, void *data)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
