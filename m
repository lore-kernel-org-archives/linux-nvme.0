Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7498C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 20:48:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9835460233
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 20:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9835460233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0KcrmxM1L0svLeKKQCpHGRYYM0+rM3OuERFjdyoxJI8=; b=CeHWj5EEu2XfBROv6iLxjy9dT
	/D63l5VuMu5DZLU+JU4fUd5dwyxHvV+gPfutZsLI0h4DNKvNlVRbeBG9NOWwujF/+zIRH9QC5Uk2n
	+F/6l/b4WFo1c8YrWEhQAwgwWq/4o9bCrU8hQSVwYk0fgZa+kt1F6rSU+N+hgFySxRpXThDyv0ICR
	Pp19dZVWySEwyADCcBmlqJnjcRJXtboVB//PwLHLTjqX06zvnj6vzHjerWfKCLgCtnVZyTD8vqpgm
	DkwniIT4MWqZ6frgVWdp0hsHu7oE//WoN+I8lDlP5Pw/c90JVa55y+I1qKbPmdVei53T/TYTCL3Wy
	5kRFK5czw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEebD-0004aN-54; Tue, 23 Feb 2021 20:48:03 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEeb9-0004ZW-NE
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 20:48:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614113279; x=1645649279;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9K8DJCNlRBTolKRgYGHcmON4UElyeC0YrhmuzziJNKE=;
 b=XJCvVYMFsITOb/KjJolYisxmg8jNsxgmMXuTsKLYfpdGDmA3ptfp3CNS
 KcSiyYRWEXFPMKGqopeiZlp3SYPEuvtPawhU4OaH23nhoNTA1ZZQSEZHj
 udhvSwQnii8KIXeHpHta9acqHs3gMaer/MUf/lmDM4NviQXC/lWL3+BQR
 2acrkXTElp4RGEy/yI1UtRy2ZlD24LyEVtgnbOCC7x1tpJ7pTZTOEDVGX
 URgoO9slbNG1nIdtxFPISEBdojWBXWxqZtokBC84wbpPmHaMhcZpGpJuk
 rmemiTCWd6fkWUCuIKaeCrToQiWniA8wQ9Ivl131/c7gaX1TWdLwg/PxW w==;
IronPort-SDR: ivXW0fbFhPQwEtfNA2TAPKT5BueGfI8lzsAYvJ3R8I2GKw0u4w0ZE3Lyyn/w9AfytqkEDA/vSB
 fl8YrtnG9KAr/ZqG4yqDtYzbbwJMIq9h8NSEDyf06H9TiODsYp/ur9LxqH+7Wwel4egg44wQUb
 DgoK+GiNKAP8dE97HQwXoiEouaK0XSXxXcamofY+Z/Sw+g6fWZLz/d0YEm+AoC8BolGKMf/d8B
 4IILM7DdG+mrPsWHwEHdiNTRblWpnyGwcdqEVXzoIHrZoWpvFOF+WXoPMyVx+qF+wlM5ev8iBV
 ioc=
X-IronPort-AV: E=Sophos;i="5.81,200,1610380800"; d="scan'208";a="160643057"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2021 04:47:58 +0800
IronPort-SDR: 9wGG8Q4rsc3LdMBYKrRvW38m3Ar8pPyUCVgbDgTf53gGXzixuVEXzMm1/iJSdj8Zv7rOBftQB5
 yVQcu4NPwRcQOSfaIdOUb+iyBHhIpRGjR6BwS0inkAMT06qspoCjCiraIUBdpsmRmuSX3fGSOj
 /6Jc/0okqo1ZPqgdaZFFlZ5QgEFNrn+Fe1hxdLyroSQRHH5dEHZ2sfeLgyNUSbXb8hkUX9qhuM
 uu613J6Ofmh7z59aIKBaDFi8ggpRSWO67c45teJfPpIg+LmbGnOCaS1Rf/+Rz3vnN29hipV+vc
 RxuAF5/VD3HzHbjao5opQb/I
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2021 12:31:15 -0800
IronPort-SDR: 7xgZRsk2oGUelqGPG72MffLQ+ol16DqeJUzNYZWhpxv9bNZSMy6JkNAhiyUzhaJbc4yoUlz3yH
 VtlAgfQq8eQiT7/V3kypfS8RefiWIyXA6fMV+9MW7BxDqo2oMxa8tfwgvCpLajy3sywJmj8hDt
 GF/HaFzxpyEwgI72FTI2FLs63ifArQfz/AU2fqwWVRII6TuqFP3PUC/5yRcNsY4dyCeTHsF/26
 1BUtGL8jhhNF9n8d9Oko6CBsVU1niK+GUxFq5H3Lf4qIgRXyuHQglaq2te59mplTFFe5fglzrt
 x60=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Feb 2021 12:47:59 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/2] nvme-pci: cleanup nvme_irq()
Date: Tue, 23 Feb 2021 12:47:41 -0800
Message-Id: <20210223204741.38301-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210223204741.38301-1-chaitanya.kulkarni@wdc.com>
References: <20210223204741.38301-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_154759_894561_E61C57EE 
X-CRM114-Status: GOOD (  11.33  )
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
Cc: axboe@fb.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Get rid of the local variable that is not needed & just return.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3729775f6a8a..2d07bdc76d0b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1060,12 +1060,10 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
-	irqreturn_t ret = IRQ_NONE;
 
 	if (nvme_process_cq(nvmeq))
-		ret = IRQ_HANDLED;
-
-	return ret;
+		return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static irqreturn_t nvme_irq_check(int irq, void *data)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
