Return-Path: <SRS0=qmg+=6S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C9CC3A5A9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 08:58:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BECB20735
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 08:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G60Zphcq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AlEyb8Bs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EuUOCZ3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BECB20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K6oozDEO6KXaDph15NOxTerQB57TmOHp31/JN4BiDkA=; b=G60ZphcqKNXujR
	tvroXT8dGMb/sCnRoYKy8a5jmIvRojakRF/vcy2b5XWN9LajBGOWA5Z+C+UEVAxK1jKtetSC5zcWU
	bV+DqnXqIFQlO4ISmqQUWH++MiF/xV1/j6R7IQC60kvXUerHcaDU3/5F5F0loT62VIMSqIaGy+pQd
	nj9AShykEudvVep8wLVTbB6otQKdBQAwglehldZjJCYR4Z1sMCY1p6gGOHvMmC5+8t4Fv87nkMJfL
	O0T2NscgMGfJr4VoPZtepRmiUL5RqNSl0DARKXC8Zc4y1kzd2tdGiTLAulsvaFEGVemYgzaRa5TyZ
	/IvN5uE0IEYbfXiKhhtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jVWvS-0005II-SF; Mon, 04 May 2020 08:58:10 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVWuw-0004pb-0o
 for linux-nvme@bombadil.infradead.org; Mon, 04 May 2020 08:57:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Xl46FbJIB/4h40peL7KAoKXbbYeYxUkj91nXqtEP/ao=; b=AlEyb8BsvhbyaSKhmn/XOoWp3a
 EUTB61+bEwMw9hZ2LRwScE1ucipgjCzhm7vgrJ6HI/GVws3bsBdmZYTQk+2Zo/15jK5yV289M0tix
 6MAxGrl92e9ZIrRL5194N6axGBGj/GaCXAjxw1hF5/IxSPWOGkZp81Pz6T5EAwWLbcDydkncC0oFi
 BLpvEnHENrF9CCSB3xEh0kKpIq6tD5riXmnlwILFif4PdwBV5kBI+qrs1D7MeMxWMeImitzhL+6PB
 4JmBcV905Xzk9otBJlJVBrKHLKuMEwl9QiGuCcDzf7ua2UBJEsaIypz73qKHyRCg7SLw4RnYuGIDi
 AK6UrWIw==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVWut-0006sP-DG
 for linux-nvme@lists.infradead.org; Mon, 04 May 2020 08:57:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588582655; x=1620118655;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RK/srFOogUkfcVsV1fdw2DXuEhAs10qxgQneH23eyy0=;
 b=EuUOCZ3j5InCyqUo2nQWaA8d1xrEsgNoMbBKWzRM7DMeZIfAdwsjY6uV
 0M2+LbSwgpK0C9Hvx0SH2zZKiDS66DYLcufZ7/TrqLC2XfxUaJQi/d0NW
 lhEtH7MTIUYvyASt+GfkMK+qBG+aWpH6Jy/KZ+8/62Th74qW2l9XAUgBE
 wCPpaMG//QDDpApIdCJh7tR1Sx7IM/nC/nbzUfgDfV/8BP9epq0RCjOhA
 Kr+7vRI1FDKJMYWACLlJDFJuWUXXjCjbL768568Gpmj2vSyyv+oInlbuH
 Rs9nqN+jWQt0wW+zRPiQWpW8zXTgX4FQlfBlPwjQqCtzvsooCbwnPOTuW w==;
IronPort-SDR: Tv1KIFwRwKgNJ+NKHlSiCWxkGXVewvE7E0yiBfgL3IKKqcgpSy27idFzUNM3c5IO6xFBG9aWvD
 oHUOTF37FJ91tY76JrK8bjSDtzqBYsczIXoZ4OgSJMGnLv7i9IOFCXc/CP3AdgkAnX1VMkPuuI
 tsI6DwYVG5f5cse5AkyWtpQXcGUKlZ7slonEeOuRgRqCeE9rd1KTtRNN6V+VB/WsBmeMbYflhE
 FdbT+8dodohrDlBYiVxjqbU8dWQ/fYWTFa5emH9XFUheC4+AgkpzVCMcHxIIp257qHUvk665uH
 yhU=
X-IronPort-AV: E=Sophos;i="5.73,351,1583164800"; d="scan'208";a="245696729"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 May 2020 16:57:29 +0800
IronPort-SDR: 0A+fVOBiUMXxyoNarbLLk5i2iRQXhEI5rhHGC4B4KZZXKcJAQ6DGXz2hfYf8ddYreqcClfTMjU
 McvsNaZINJ4NpYmI0aVSz6MkNLRe3AgTo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2020 01:47:26 -0700
IronPort-SDR: uhsWpBAmQ+XlcP9h84KXWEnUnC5KfTWcS+3O+6OyOxhD8P65sWy/ZKTopyx2sLQVyIEstSZi6R
 Csnw8YnWUlnw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2020 01:57:29 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 5/6] nvmet: centralize port enable access for configfs
Date: Mon,  4 May 2020 01:56:47 -0700
Message-Id: <20200504085648.15549-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200504085648.15549-1-chaitanya.kulkarni@wdc.com>
References: <20200504085648.15549-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The configfs attributes which are supposed to set when port is disable
such as addr[addrfam|portid|traddr|treq|trsvcid|inline_data_size|trtype]
has repetitive check and generic error message printing.

This patch creates centralize helper to check and print an error
message that also accepts caller as a parameter. This makes error
message easy to parse for the user, removes the duplicate code and
makes it available for futures such scenarios.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 44 +++++++++++++---------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9c808f4185a0..20779587eefe 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -40,6 +40,14 @@ static const struct nvmet_type_name_map nvmet_addr_family[] = {
 	{ NVMF_ADDR_FAMILY_FC,	"fc" },
 };
 
+static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
+{
+	if (p->enabled)
+		pr_err("Disable port '%u' before changing attribute in %s\n",
+				le16_to_cpu(p->disc_addr.portid), caller);
+	return p->enabled;
+}
+
 /*
  * nvmet_port Generic ConfigFS definitions.
  * Used in any place in the ConfigFS tree that refers to an address.
@@ -63,11 +71,8 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	int i;
 
-	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	}
 
 	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
 		if (sysfs_streq(page, nvmet_addr_family[i].name))
@@ -104,11 +109,9 @@ static ssize_t nvmet_addr_portid_store(struct config_item *item,
 		return -EINVAL;
 	}
 
-	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	}
+
 	port->disc_addr.portid = cpu_to_le16(portid);
 	return count;
 }
@@ -134,11 +137,8 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
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
@@ -174,11 +174,8 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
 	int i;
 
-	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
 		if (sysfs_streq(page, nvmet_addr_treq[i].name))
@@ -214,11 +211,8 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
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
@@ -241,11 +235,8 @@ static ssize_t nvmet_param_inline_data_size_store(struct config_item *item,
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
@@ -283,11 +274,8 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	int i;
 
-	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
 		if (sysfs_streq(page, nvmet_transport[i].name))
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
