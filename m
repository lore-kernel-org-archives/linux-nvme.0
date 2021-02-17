Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6373AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2FC64DFF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2FC64DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sRUAKA/C1la6akA2Py5BVdCFOo64o6oSmScrZANk/Bc=; b=Eyu0aPniUxo4FHl5dMkPt8g7E
	icCKFEzpTtrDhc6k/d7uU7JL/8Xel8UBsJ24pRSGYRUH1xp9auNi17d/Ujx1jRf2TwDpqy/xcSGGX
	61oOq7WW6ydKpQWIVJcXtkqZ+n+r+Fqg8oskSKlRTtuNr+EAMZyLOKlfxocEJWbGJA2mO2bni+9qG
	bi4J5vl/LkuxoQGzAIbk9BdQ8+j4jRi/fBoon7wWf2rwyl6FPGfCcUIF6vIC8csVoH/bB9xt07JBZ
	uWUEIKlPgWsqFS74HJraZrOlC7irqNF3Tad65aAquBmf1yDSH8oVdqS+Ii3kMgInYdvEP3gZ2KV0/
	O/Sd1s/kA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCARQ-0007n2-5k; Wed, 17 Feb 2021 00:11:40 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCARL-0007k2-Fs
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:11:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613521727; x=1645057727;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jlJowUYd/3ARTwMFSRb5GNyCGORs3s7xQji0M+e2Dm8=;
 b=TKF9a8cx8ibaZXE5aG0Kzynb3FS1Z4JTQdOV6oXgyhpTPT3QeTPkCC7L
 ELndylbOyPeHhB/9dlNSYjvAiK6UM/DKYytffGWhV7uS+Dru+/XujEzdE
 vpxAFyt7q/t1wRhNOmszioxRhF8lQd9f9aPrV5uQhIxFc/N+kkitUITd1
 oMG9qzotKEgXt1hd6cM8CNXwvmc09/nK7BEBdOoOlNoMQCMBBPSk/GwVI
 SMMNXrWPfqC2EjS47GYpEJByG8umZuZ7jtHbBPdDvSQuVHujKgYFEEDoc
 JdP+sJVGzcH64nyCQecVVX4w69+voVg4ITU6zMrAZpy7olmGUrzUpY5Eu w==;
IronPort-SDR: q4VHxwXsu69I+/sOVRr0PIRD0xDcwEz6zYjDRQuxRE7t/fieL2Ja5fl/3tyTZa84d0K2cnKUiI
 m8WisoOeK8rgFd933ALLpT6dRppklRrn7RuSKuBK83LHO4FMJkdkV2kAJq9qKIbtynh70jJvr8
 ikFihfY6NUc8ZKERjEASYqsP9nTo5tIU+X15wkVy50XIe5rNIxQEq8L0zqvxUne1FY3SuRSXnU
 llYhtFhfUKrmoZ0lm633ZxsMXAr1JPJkfMNjP+0+X2NhmURgd4pw9LgRe9+ZxYGIdMXiVJ2Ip5
 +cQ=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="264274421"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:28:44 +0800
IronPort-SDR: 4VEN2FSCl28/k4jbRDl1it43sk7qmClrZD8s44ug4IISar5x0+pazJZ2yioULZx7BwduUbDHGu
 MM3vv/xm6OCzNuZw03axUGTEpDHC7t/VnivNVRp8XxHCRfpXAANl6QVj0969IY0967Mc7XNFLK
 LtBPLK1n08Mn39DdGOpT9LYLJ13cFBsyUnxyM2FwMrD4ptU6EWYiBBT/xrfV3irKZF/lpE4t8Z
 HHW36Lr9PHNqN0IKuJIDGh2R0O+gDbp8O7f00LcxHY8H6GoDWkTpTPFLMJcVlJmATxbFF8ztCp
 nSyJL9+ZUC/IgKV4JELfn/qg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:53:18 -0800
IronPort-SDR: iYd9oWNB6G4W0iIXD5pUc+7T7CJaUqw20mienVksSZmK78u9WPPDM1XjrKFjEjG0/SXABnWuKp
 3SBgSSkSDpmJBkeIJN4wJqZJbWWhW92BJgYZW0r+r7ysKYBbR9pyOchAJ+X9HFHKrvrQgwE7gT
 DjHzNCnBmILOsedahjFUMGN3ehWSBDezEdfQ7tzhFs+jg6PMjmwLH1YCLOWNhI7OkqW1jiVxSn
 s3GM44/udcCUpPhmTsTzfff5zzzUEoVMnqzwJ9nC2cB7HBQgWVpZBDvUMvw6IPe7yJL2CjnryW
 QrY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:11:34 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 08/14] nvme-core: move util quirk at the top of the file
Date: Tue, 16 Feb 2021 16:10:26 -0800
Message-Id: <20210217001032.25741-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191135_703523_A0447753 
X-CRM114-Status: GOOD (  18.96  )
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

The quirk utility functions and structure are defined in the middle of
the file (line:2762) & they are not accessed immediately after their
declaration until we get to nvme_init_identify() (line:3114).

Move quirk related util functions at the top of the file that avoids
any global structure related definitions in the middle of the code
where they are not accessed immediately after definition.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 126 +++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4a59a46193e8..5cb90bd8704d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -93,6 +93,69 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
+struct nvme_core_quirk_entry {
+	/*
+	 * NVMe model and firmware strings are padded with spaces.  For
+	 * simplicity, strings in the quirk table are padded with NULLs
+	 * instead.
+	 */
+	u16 vid;
+	const char *mn;
+	const char *fr;
+	unsigned long quirks;
+};
+
+static const struct nvme_core_quirk_entry core_quirks[] = {
+	{
+		/*
+		 * This Toshiba device seems to die using any APST states.  See:
+		 * https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1678184/comments/11
+		 */
+		.vid = 0x1179,
+		.mn = "THNSF5256GPUK TOSHIBA",
+		.quirks = NVME_QUIRK_NO_APST,
+	},
+	{
+		/*
+		 * This LiteON CL1-3D*-Q11 firmware version has a race
+		 * condition associated with actions related to suspend to idle
+		 * LiteON has resolved the problem in future firmware
+		 */
+		.vid = 0x14a4,
+		.fr = "22301111",
+		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
+	}
+};
+
+/* match is null-terminated but idstr is space-padded. */
+static bool string_matches(const char *idstr, const char *match, size_t len)
+{
+	size_t matchlen;
+
+	if (!match)
+		return true;
+
+	matchlen = strlen(match);
+	WARN_ON_ONCE(matchlen > len);
+
+	if (memcmp(idstr, match, matchlen))
+		return false;
+
+	for (; matchlen < len; matchlen++)
+		if (idstr[matchlen] != ' ')
+			return false;
+
+	return true;
+}
+
+static bool quirk_matches(const struct nvme_id_ctrl *id,
+			  const struct nvme_core_quirk_entry *q)
+{
+	return q->vid == le16_to_cpu(id->vid) &&
+		string_matches(id->mn, q->mn, sizeof(id->mn)) &&
+		string_matches(id->fr, q->fr, sizeof(id->fr));
+}
+
 /*
  * Prepare a queue for teardown.
  *
@@ -2704,69 +2767,6 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
 	}
 }
 
-struct nvme_core_quirk_entry {
-	/*
-	 * NVMe model and firmware strings are padded with spaces.  For
-	 * simplicity, strings in the quirk table are padded with NULLs
-	 * instead.
-	 */
-	u16 vid;
-	const char *mn;
-	const char *fr;
-	unsigned long quirks;
-};
-
-static const struct nvme_core_quirk_entry core_quirks[] = {
-	{
-		/*
-		 * This Toshiba device seems to die using any APST states.  See:
-		 * https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1678184/comments/11
-		 */
-		.vid = 0x1179,
-		.mn = "THNSF5256GPUK TOSHIBA",
-		.quirks = NVME_QUIRK_NO_APST,
-	},
-	{
-		/*
-		 * This LiteON CL1-3D*-Q11 firmware version has a race
-		 * condition associated with actions related to suspend to idle
-		 * LiteON has resolved the problem in future firmware
-		 */
-		.vid = 0x14a4,
-		.fr = "22301111",
-		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
-	}
-};
-
-/* match is null-terminated but idstr is space-padded. */
-static bool string_matches(const char *idstr, const char *match, size_t len)
-{
-	size_t matchlen;
-
-	if (!match)
-		return true;
-
-	matchlen = strlen(match);
-	WARN_ON_ONCE(matchlen > len);
-
-	if (memcmp(idstr, match, matchlen))
-		return false;
-
-	for (; matchlen < len; matchlen++)
-		if (idstr[matchlen] != ' ')
-			return false;
-
-	return true;
-}
-
-static bool quirk_matches(const struct nvme_id_ctrl *id,
-			  const struct nvme_core_quirk_entry *q)
-{
-	return q->vid == le16_to_cpu(id->vid) &&
-		string_matches(id->mn, q->mn, sizeof(id->mn)) &&
-		string_matches(id->fr, q->fr, sizeof(id->fr));
-}
-
 static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ctrl,
 		struct nvme_id_ctrl *id)
 {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
