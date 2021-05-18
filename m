Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE1DC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 05:06:56 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36036008E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 05:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36036008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UVaDcHJqOWTI8HCqoC5Nf6/mYLvSb0UaxITX00LDPC8=; b=BvuHqnpA89GNqiPLTcMgTugAd
	l82j6aM+pV2rX619DwTSaQVsCJWvByNzZtU7+7pJPG7g1+OsaqaXjBqgBAvkmljt6B92eoLxg8sRz
	aJsALhucq59tQ57JmxuDkjS2WvBSA0eyy1KTuvSFwuQdcj7TEO8XiLYd8A6gEvFmgWk/Cv0pnvki5
	6Pn14R++gGU44LV+FIJ/R/pkuWphI3y+OhMEyF07iynjFQp6WtSHPyUcKX04QFYJrFw64dtbl7aEL
	a9nLcAsWGpjRJcQF+Gq9CuUKI2IHfKMmgaNS18NCYAbyC7WBObYJklP6TztUuDcRp61xkJ6TtnXDn
	aTDExI9QA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lirw8-00GyJh-3b; Tue, 18 May 2021 05:06:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lirvt-00GyIC-RT
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 05:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=y+pjo1285xBm+7JpULQ7sVdC8yju9V845huUsZyscW4=; b=yXTp06RrhL2jL8LEJl2BE+F0Xl
 JL5BS8lxHQ7peXxB4ev+0xqpIgj+Yg9UsnYCvk2dkyy51RbuPFoW8bQpNDhe/zMTbZrzFrFHtsUl2
 Zz11/7rd6/IIAgHukPgzxxcg1ztgWBCVOE4oRKH4Z47Ch3qM3p7IihB5M0cRM5uT5AOX86xqCa8iU
 T6AoNKvpOxFT8MclUARLBpq4xxb43TprZVcilD4hueqkriohWzVqk7Nm2Ea6z5110WDoLWvEZwM7r
 mAipYXnhesE3bZK5LRF0n19gM0TTIO+5PX1/Gj7H848+0uajpr/hpdfuaeHdc5tAJrt4gpfCwLPPk
 CcTsG4ZQ==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lirvr-00EJbG-AR
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 05:06:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621314373; x=1652850373;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jzmw12ZEK8TyH4CJR+sKW23qVwTNc1mR/GAPKIQvh5s=;
 b=bB6LMYgq799QfQm7SfeypOVNwkCEdvWNy8a9cDxEgZ07RGex3/4YTWYz
 Z+mrGN59wA4/ZLlQjgoVnrnndD/InbdvuDp6LsRQfDtfBMdwPTUJav9tA
 ArCTjXisx64a9fTZywRdy2eLL3yiztqwjEGhlCRzmMSo3pcsY/tn6t4m5
 yqMREjhgQljaLjITsb7U1FieEsDiXgi7YAkAFC7DeqZt6ijZJkio2QtoB
 E7QWwhDlBjqIN48fwKKaFJCHlsvCPbYIfICEslpPfLFkqQNDyH175U1s7
 zcxJweHUrJr0DHE//AD3SO5UXB4m48QCSXkKcGtgxQYT/L7epklYf+Qwi A==;
IronPort-SDR: Xw/mjmdIjPaiYTJOzAkaMCU/xVTA9WlSqCeUxlKn3mpqMViUuJ+Xa/VvlIyzTeGCqQH7QnA1Rq
 iYVIBd+LORf/ngb1dDIPRDRYnrsBkqQ3pBXIvU/r8RKihN8J4J9hhNLdzAfMGI5xEcnMnku8Ie
 +CQ0oZkkSuZqVI34hb2W2p+3R4LcfTTrh5cfzBmZ5f43SE28Y3BgrIZiIE3auEUUXmL3J8LQbI
 cJS/IxWAgIRtIwan8vEppVeFCymKE/1Uy02SMcnCZdcYDCw+gFjnAQOCU5lVzyQQOJFfrXIKeD
 07A=
X-IronPort-AV: E=Sophos;i="5.82,309,1613404800"; d="scan'208";a="168525975"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 May 2021 13:06:13 +0800
IronPort-SDR: /zR+JEWxnZLNX3GTWNogh4C9NmWfJbC9tUfXO7O3QaGfpWgvdg+dY8+1VnYCKiX4m+Ocz/mi3J
 sAUrtCwnhAyFhiWZNl3IJwUhfDj21ceS8AJX4A0RpGf0PuRdXauM7MMdz9Dl0JEAPVZF3kfrtK
 1XoN8c/8mJqXHau77rQpzZ7t5GGtXClqLdqyVyt6aAk4FGTBzdcpx6bV5z7d+O0nYmSSvHVEeE
 Z+bo8Tm/no9IFmYYroI86+Q33P9QOcVPx3wHVK8hD3ArVjkuL02izfWSmzuyF/E300bYuYlpGS
 SGa5FJQOK/ZyabPOfym4fERn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2021 21:44:40 -0700
IronPort-SDR: QPdLOCvgjBDqWr9oRuepG7qg0XNog6kPnOYlTcppZCGSpWhCvPO59/oAAMLDVpSDLQGlh+RiN8
 xpbo/31g1/HW8kmWLj5+opsTM3BLD9/NNDbr/PBsz4vTLKZh1WVKA58KYI+dq8XSs45zGJ10U0
 p6pI6tPb7CVVkGcir7mSLkfZDfOI6DOOSYv9uLRH12phOU/RNDihhK+nZJBE39NZFAPpc67Jgj
 XtSOXRgGLZCJTXZNERbN7DqRm7e8n1cnpaMyOcLJG7C/ugSJCb6gEi5uY1589RR83zNJpIfuUD
 uKY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 May 2021 22:06:15 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/4] nvme-core: add a helper to get the len from nid
Date: Mon, 17 May 2021 22:05:55 -0700
Message-Id: <20210518050557.14961-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210518050557.14961-1-chaitanya.kulkarni@wdc.com>
References: <20210518050557.14961-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_220615_394829_B216AB2B 
X-CRM114-Status: GOOD (  16.81  )
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
Content-Type: multipart/mixed; boundary="===============7609980237072136704=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============7609980237072136704==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

In the current code we maintain NVME_NIDT_XXX identifier values and the 
their length NVME_NIDT_XXX_LEN separately which has 1:1 mapping. This
adds four extra macros and open coding of such macros in the host and 
the target.                                                                                            

With this open coding in future we will have to maintain one extra macro
representing length when we add a new NIDT identifier(s).

In this preparation patch add a helper function and use it so that it
can now remove the open coding of the NVME_NIDT_XXX_LEN for host.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 22 +++++++++++-----------
 include/linux/nvme.h     | 16 ++++++++++++++++
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f8a3a36eba86..aac33f575f19 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1306,38 +1306,38 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 
 	switch (cur->nidt) {
 	case NVME_NIDT_EUI64:
-		if (cur->nidl != NVME_NIDT_EUI64_LEN) {
+		if (cur->nidl != nvme_nidt_len(NVME_NIDT_EUI64)) {
 			dev_warn(ctrl->device, "%s %d for NVME_NIDT_EUI64\n",
 				 warn_str, cur->nidl);
 			return -1;
 		}
-		memcpy(ids->eui64, buf, NVME_NIDT_EUI64_LEN);
-		return NVME_NIDT_EUI64_LEN;
+		memcpy(ids->eui64, buf, nvme_nidt_len(NVME_NIDT_EUI64));
+		return nvme_nidt_len(NVME_NIDT_EUI64);
 	case NVME_NIDT_NGUID:
-		if (cur->nidl != NVME_NIDT_NGUID_LEN) {
+		if (cur->nidl != nvme_nidt_len(NVME_NIDT_NGUID)) {
 			dev_warn(ctrl->device, "%s %d for NVME_NIDT_NGUID\n",
 				 warn_str, cur->nidl);
 			return -1;
 		}
-		memcpy(ids->nguid, buf, NVME_NIDT_NGUID_LEN);
-		return NVME_NIDT_NGUID_LEN;
+		memcpy(ids->nguid, buf, nvme_nidt_len(NVME_NIDT_NGUID));
+		return nvme_nidt_len(NVME_NIDT_NGUID);
 	case NVME_NIDT_UUID:
-		if (cur->nidl != NVME_NIDT_UUID_LEN) {
+		if (cur->nidl != nvme_nidt_len(NVME_NIDT_UUID)) {
 			dev_warn(ctrl->device, "%s %d for NVME_NIDT_UUID\n",
 				 warn_str, cur->nidl);
 			return -1;
 		}
 		uuid_copy(&ids->uuid, buf);
-		return NVME_NIDT_UUID_LEN;
+		return nvme_nidt_len(NVME_NIDT_UUID);
 	case NVME_NIDT_CSI:
-		if (cur->nidl != NVME_NIDT_CSI_LEN) {
+		if (cur->nidl != nvme_nidt_len(NVME_NIDT_CSI)) {
 			dev_warn(ctrl->device, "%s %d for NVME_NIDT_CSI\n",
 				 warn_str, cur->nidl);
 			return -1;
 		}
-		memcpy(&ids->csi, buf, NVME_NIDT_CSI_LEN);
+		memcpy(&ids->csi, buf, nvme_nidt_len(NVME_NIDT_CSI));
 		*csi_seen = true;
-		return NVME_NIDT_CSI_LEN;
+		return nvme_nidt_len(NVME_NIDT_CSI);
 	default:
 		/* Skip unknown types */
 		return cur->nidl;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index edcbd60b88b9..5d6b0fe64db1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -9,6 +9,7 @@
 
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <linux/kernel.h>
 
 /* NQN names in commands fields specified one size */
 #define NVMF_NQN_FIELD_LEN	256
@@ -497,6 +498,21 @@ enum {
 	NVME_NIDT_CSI		= 0x04,
 };
 
+static inline unsigned int nvme_nidt_len(unsigned int id)
+{
+	static int nvme_nidt_len_map[] = {
+		[NVME_NIDT_EUI64]	= 8,
+		[NVME_NIDT_NGUID]	= 16,
+		[NVME_NIDT_UUID]	= 16,
+		[NVME_NIDT_CSI]		= 1,
+	};
+
+	if (id > ARRAY_SIZE(nvme_nidt_len_map) || !nvme_nidt_len_map[id])
+		return 0;
+
+	return nvme_nidt_len_map[id];
+}
+
 struct nvme_smart_log {
 	__u8			critical_warning;
 	__u8			temperature[2];
-- 
2.22.1



--===============7609980237072136704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============7609980237072136704==--
