Return-Path: <SRS0=yQ2W=6E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7675EC38A29
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 01:00:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44214214AF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 01:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pczCsgWC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lnCak/hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44214214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wMCH9h1OuNVtE7cXEAtBUE7lQ3KMqMFEF2X3leazrME=; b=pczCsgWCNjq+g8
	F64OzwcyxC2TcYyNQ9B/Xh1GZQaJ0f//2p0N2+zisMjViAeOX2qJuJ1RJFt3G/pLjqW33gT+deKFL
	OB5TJ/Hyj+JV/G0i/QJpDFXbCh/77LMmJvyuDbPK8aKurNQwBBq8VjMgQIGiwDkFfJhjk+Im1F7m6
	itbiqypCMz6rM04j3f8wKd7c4ifuwEYwEkrQV1MvkcYIZk79LWhVRQEgFvSn47Lg0HjObjnmy70jb
	8vA8+QQYusdHX+he5XZVc10KtGkO2YG7SCvyc8Rq/mInkz/HaNSB7dPyqaQWyZCDwOZ0mPWkWMHmc
	3ChUcMY0rLAFW3m1Zn+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQKnL-00041b-Pa; Mon, 20 Apr 2020 01:00:19 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJkm-0001EX-PE
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:53:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340416; x=1618876416;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=afl7ciT/1mLpaL08ubd3GevvZW5wXTO7ATmTiI2XlA8=;
 b=lnCak/hugxFfJYu9AMAU9zf68p+2+YO4dX2S5hpv9jd+NY1jEH86LYNk
 jvnsWLFjdpPQFU8iwlhM51LNnuSaTA/fQMSiQGcN1+QQPqYuRJPlCRk4g
 NOHXiQimGII1bBvISsa0vEE/m4SqtOtCDhnEG6xR+uUaq0E+8Qy6YJxD9
 K5xe4uEjrJG2NIpQEQj/QnFd9DIBgnoI8atWRGrtrX9a6j+E65fVMIukJ
 P1W/SBRWB1Zv2yOrCNpxrW3PWiGQmaASaOKMdaLwnrAkBSKrtV4OmlNq7
 9xbS6w8ZEdirDAN94jzPVHfY/NabAk4h+nlezyAUu7HaNVUeNb4+SGjtl w==;
IronPort-SDR: x2oz8h0qMW+mIvd3AAdm5Kdp2Py4J05vvq1w9KlFc97kutP4hPPepKiaVLPpFL2kf6jhVGlITE
 ltSR1+mzs5iv32guuKICEPRjh7UdWWGX7+gGxoVavGPdohlZPJmeOGTQZAdP4SesJPkZMScMS/
 xDHU3gJbnbCQuIAoYTl6Eh+QwbOFWKTqLRi4351TXmI20Ts6qjX3Iu1SWBJdurht+O37Dc6RUB
 gWSiYk4DZULpWxqFB29LbtmBuwwI5H4mdP77B0EsdJGiizUANzcDYmyoWkY5Qyacm7jQdT/bvM
 Rf4=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="137097008"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:53:26 +0800
IronPort-SDR: 5mh2vUJEbunnYqbSur/ILeyfYPP/2dRDG+zYH5MrqDoXJn7E0culH4HmXGP8jFQ/9nUs89tL5m
 gr57Vz9or7Dwp/zY+zt8VpJXh03YzE+kk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:43:47 -0700
IronPort-SDR: xp/xSaB42Sbpd5v1LURgOjDpif7ekT7+r8DFItWcbc0q8MUbeLB+6OrwRN0mlvT08di5RnT39+
 6STMQb9q1mYw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:53:26 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 5/6] nvmet: centralize port enable access for configfs
Date: Sun, 19 Apr 2020 16:52:41 -0700
Message-Id: <20200419235242.60355-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
References: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_165336_925143_AFBC6341 
X-CRM114-Status: GOOD (  14.21  )
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

The configfs attributes which are supposed to set when port is disable
such as addr[addrfam|portid|traddr|treq|trsvcid|inline_data_size|trtype]
has repetitive check and generic error message printing.

This patch creates centralize helper to check and print an error
message that also accepts caller as a parameter with added
locking. This makes error message easy to parse for the user, removes
the duplicate code, uses appropriate locks and makes it available for
futures such scenarios.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 58 ++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 883348f7699a..80a7b669b581 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -40,6 +40,29 @@ static const struct nvmet_type_name_map nvmet_addr_family[] = {
 	{ NVMF_ADDR_FAMILY_FC,	"fc" },
 };
 
+static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
+{
+	bool enabled;
+
+	/*
+	 * Right now port->enabled is accessed in follwoing two code paths
+	 * which are protected by the nvmet_config_sem :-
+	 * 1. nvmet_subsys allow/drop link() -> nvmet_port_enable/disable()
+	 *    setting port->enabled true/false respectively.
+	 * 2. nvmet_referral_enable/disable() -> nvmet_port_enable/disable()
+	 *    setting port->enabled true/false respectively.
+	 * Use read nvmet_config_sem when reading enable condition.
+	 */
+	down_read(&nvmet_config_sem);
+	enabled = p->enabled;
+	up_read(&nvmet_config_sem);
+
+	if (enabled)
+		pr_err("Disable port '%u' before changing attribute in %s\n",
+				le16_to_cpu(p->disc_addr.portid), caller);
+	return enabled;
+}
+
 /*
  * nvmet_port Generic ConfigFS definitions.
  * Used in any place in the ConfigFS tree that refers to an address.
@@ -63,11 +86,8 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	int i;
 
-	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	}
 
 	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
 		if (sysfs_streq(page, nvmet_addr_family[i].name)) {
@@ -102,11 +122,8 @@ static ssize_t nvmet_addr_portid_store(struct config_item *item,
 		return -EINVAL;
 	}
 
-	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	}
 	port->disc_addr.portid = cpu_to_le16(portid);
 	return count;
 }
@@ -132,11 +149,8 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 		return -EINVAL;
 	}
 
-	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	}
 
 	if (sscanf(page, "%s\n", port->disc_addr.traddr) != 1)
 		return -EINVAL;
@@ -172,11 +186,8 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
 	int i;
 
-	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
 		if (sysfs_streq(page, nvmet_addr_treq[i].name)) {
@@ -210,11 +221,8 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 		pr_err("Invalid value '%s' for trsvcid\n", page);
 		return -EINVAL;
 	}
-	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	}
 
 	if (sscanf(page, "%s\n", port->disc_addr.trsvcid) != 1)
 		return -EINVAL;
@@ -237,11 +245,8 @@ static ssize_t nvmet_param_inline_data_size_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	int ret;
 
-	if (port->enabled) {
-		pr_err("Cannot modify inline_data_size while port enabled\n");
-		pr_err("Disable the port before modifying\n");
+	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	}
 	ret = kstrtoint(page, 0, &port->inline_data_size);
 	if (ret) {
 		pr_err("Invalid value '%s' for inline_data_size\n", page);
@@ -279,11 +284,8 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	int i;
 
-	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
 		if (sysfs_streq(page, nvmet_transport[i].name)) {
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
