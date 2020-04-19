Return-Path: <SRS0=4bXW=6D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9AAC38A29
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:53:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0F92064A
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bablT0xR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jI4Qfwll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0F92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ktKn6UwOjGDoeWoiSyQj2yzSoqYffQf+vM9pW6zNLE4=; b=bablT0xR4mgL9h
	3n/nF/Ekw+hhyT3Y+B0Mc+PZJy+GCrGMDPk1Z0h1tZBDik9hDT9DeXEcthZFynWzfkNsubkniv5n6
	xCkWCzqefdfZx2ZCTxgzD0w3khR7dAKDlwViQ3onpwGqblsD2vt0M+G5xw3hLSorvICTrg4m8uvIR
	aUCIdPiE8peOzdKJb8i1YdWip4GpLI4fXRD2hsek8UXsmbl0ovEv3vXdMU7PFStsSx6r7lzNoW9E7
	BtLzHtHP1XCcaw8t+2XGbo7xtfaoswMJdpQ9nfEPl6JirOZSbk5sEiJj7XmOO2QWyGoktC+WxO2r7
	2xbxobszfk8elBrCQnrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQJko-0001GR-Rc; Sun, 19 Apr 2020 23:53:38 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJkX-00012B-1K
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:53:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340402; x=1618876402;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NitMR5vnR06+2CaZTV/57jrup4aylLkWkWfC5/Gm+30=;
 b=jI4Qfwll7YbSBd3ga/mGjMVf3UQw2AHGd2FkVxUaGXGyeYzsyVm2mIfh
 wlH91BqjBMAyz50alXjKlCyGJbfO5ZZ/9dIbwYVHQqKwtf22RhuIU0e/R
 rUaV9R+chvz5DgYdlpxBpo+RCLP8D//XvXS2f+A2SVtq91ozzQKBmk1Pt
 UMSEpCIFrsmyQNp5SSIl9dLJ6JkOVLfxBxwVoQ+/IhwteRpyzr9N5otGC
 c0MTqlRZUTSHtvtHSLwH4QZW+s7U7k12H1ofVPBH7S8JMezENTnPKQfqx
 11MiISTgj1T3jKDwex5PmiFFFXCUUM3ykJuEvbAq2rJTHyA1tgsgws8rZ A==;
IronPort-SDR: NurnU714wJo4cE91RChu2YvcnEV6OVfBIa7JObvlf+e3vaxnmcNNbVfWgR78kVVTqUC5qOqfV0
 Uqmj4IyUIaLTFW11eMo8aiJqBZaZMxbEZkSvjWpXDTkudlpvREHRcI5STqByu1z1TUIbW+LBb0
 9UGpbHwpmMAi0H+vKbtQTKsXCq+gb86H8RZCbod14HeyFWbHQ/OSapKyCmnjmYJ5Jw5yOMSkya
 Gh0wCrId+aTfDWB0BKsC8B1BYoeYq+1io7WxCwQVIZ/Rk341B3nbY70EbLKzvEYA8FW7bB1AEN
 4+I=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="140022594"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:53:21 +0800
IronPort-SDR: pXCpaEm76yPDDQDFLCBK7nJ2WReZbUkSczhPTUtJMjvvgMXT9AnJPqpH8rnQ8hM8qKn1xHOBeY
 kFVsoccAogcCBpkUQrWLLHBRBit5oqDGk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:44:14 -0700
IronPort-SDR: YQUPl+HrwBs076emtHgpapTBsQanx+0FkWzssbl76JWZEsPeUHUXrnao+NYJ7ypu+0nCJ2rmvS
 Yl1UJAmVx+mA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:53:19 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 4/6] nvmet: use type-name map for address treq
Date: Sun, 19 Apr 2020 16:52:40 -0700
Message-Id: <20200419235242.60355-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
References: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_165321_233081_57F633E7 
X-CRM114-Status: GOOD (  12.85  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently nvmet_addr_treq_[store|show]() uses switch and if else
ladder for address transport requirements to string and reverse
mapping. With addtion of the generic nvmet_type_name_map structure
we can get rid of the switch and if else ladder with string duplication
and use for-loop-compare-success-return pattern which aligns with the
existing code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 48 ++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index bb0810f28541..883348f7699a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -145,20 +145,24 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, addr_traddr);
 
-static ssize_t nvmet_addr_treq_show(struct config_item *item,
-		char *page)
+static const struct nvmet_type_name_map nvmet_addr_treq[] = {
+	{ NVMF_TREQ_NOT_SPECIFIED,	"not specified" },
+	{ NVMF_TREQ_REQUIRED,		"required" },
+	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
+};
+
+static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 {
-	switch (to_nvmet_port(item)->disc_addr.treq &
-		NVME_TREQ_SECURE_CHANNEL_MASK) {
-	case NVMF_TREQ_NOT_SPECIFIED:
-		return sprintf(page, "not specified\n");
-	case NVMF_TREQ_REQUIRED:
-		return sprintf(page, "required\n");
-	case NVMF_TREQ_NOT_REQUIRED:
-		return sprintf(page, "not required\n");
-	default:
-		return sprintf(page, "\n");
+	u8 treq = to_nvmet_port(item)->disc_addr.treq &
+		NVME_TREQ_SECURE_CHANNEL_MASK;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
+		if (treq == nvmet_addr_treq[i].type)
+			return sprintf(page, "%s\n", nvmet_addr_treq[i].name);
 	}
+
+	return sprintf(page, "\n");
 }
 
 static ssize_t nvmet_addr_treq_store(struct config_item *item,
@@ -166,6 +170,7 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 {
 	struct nvmet_port *port = to_nvmet_port(item);
 	u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
+	int i;
 
 	if (port->enabled) {
 		pr_err("Cannot modify address while enabled\n");
@@ -173,19 +178,16 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 		return -EACCES;
 	}
 
-	if (sysfs_streq(page, "not specified")) {
-		treq |= NVMF_TREQ_NOT_SPECIFIED;
-	} else if (sysfs_streq(page, "required")) {
-		treq |= NVMF_TREQ_REQUIRED;
-	} else if (sysfs_streq(page, "not required")) {
-		treq |= NVMF_TREQ_NOT_REQUIRED;
-	} else {
-		pr_err("Invalid value '%s' for treq\n", page);
-		return -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
+		if (sysfs_streq(page, nvmet_addr_treq[i].name)) {
+			treq |= nvmet_addr_treq[i].type;
+			port->disc_addr.treq = treq;
+			return count;
+		}
 	}
-	port->disc_addr.treq = treq;
 
-	return count;
+	pr_err("Invalid value '%s' for treq\n", page);
+	return -EINVAL;
 }
 
 CONFIGFS_ATTR(nvmet_, addr_treq);
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
