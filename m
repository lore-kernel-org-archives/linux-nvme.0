Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAD9C4363D
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 02:44:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7183F21531
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 02:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WZZGgunv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bxusiuhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7183F21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ng731uR7T8lWjFumnvmiIrIG+0ucumrtZ68ZOsF6FTA=; b=WZZGgunv+2b0nz7EUaZpLrv5+
	47HC029htGAGP2a6GdMkBJBwDxt7Z0OBIJJlDgIJ+ZB9Ot/ZBi9tJ2cKfgktvS8B/uRKTn01wl5Et
	AhnkqCq/ApY6+5pnHD8NMbuUUgjqNJH3Im5xGp6rgfzD/1YO6OaNW5hOO0lW+73AOGLskGhcy28NQ
	FgGni0EJvEEc+EYJhxQ/+bk/VtcplPXCwlw7KIJIxd2fS8O3f1YrnMjdjfgj9Ry5b19oFYMWYOnd/
	++CEKgxcKqJYtGWkrqtRZoncZ3mSgZyA4g9oIMNnChCOWXtdyPb9kU4Y+5ckj30U3R6D5PzkPry8R
	SkucQMjHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNoaJ-0006UW-KL; Thu, 01 Oct 2020 02:44:43 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNoaH-0006U6-8M
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 02:44:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601520281; x=1633056281;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qsgCHp/7Y5JCQ8/aE9o0QSWWaV7Nygt+F25mA26lWQA=;
 b=bxusiuhfn90MOGr1G7qLW/VuF8LvhTXspSDMzRuUck6oKc9BVmkIUoM2
 GLuJ0XnlAta1bc/tfxJzVNZj2fV3kCTHGH5c41wbFqDd5wy4alxULdQ2Y
 ef5nZ9wTi02OhCjfvrp6x/uWB5+9wvbn84UT9qqHHyYSIxNMsqyZ2jYvU
 E1EP527/aqLnNv2XejgsSZUqfkm70BVe7u5LfGmddTicvWjfcPdJWUSQK
 TIfIc4oQt7qFZaI+00KqUBZUtTwliudw+C3KHm5/SGzNtPxjhVqxdzrpP
 IcRFT+oL+xUbUreAt28FExsLhSVO9le+fJPvxP30Jt7i8r0eNqHRAF50Q Q==;
IronPort-SDR: AsAg7IeJBI9td/xXQdwYGFumzznQFBMcbyekEnd0r8akHAYZMngqY1fljiLgvpfsyKXauTDleB
 1EIHjJZtCJjUIIac9UMW9YrXVn3EQAXQol8Bqt9PX0jRyY1xmpTLJmSwjwyx13Omr5nic/S7vX
 4Me5lvUn3gNW3PE3FOXIYT6rivtO1g3aPwUyn752IAkJiyD7xj3OoHcBh03Gah9Ns6jLoOxjVH
 /vCFJf7SXQua0b3RmTIPLMSC3weuIw6p7O7r2bYjy0+SF4kCJCodkiNwEnB+yvYav0DpyPAtpI
 cIc=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; d="scan'208";a="148633437"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 10:44:38 +0800
IronPort-SDR: JiH43vAqfuuo/YZVgdVVOMkHBoTjO/3zhMayCDxX9oz6QSNXzbYbkbbXtAyAan7Nz7zVkr2VyK
 OR2qjIAttIjA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 19:31:30 -0700
IronPort-SDR: fFZIO8JYzdmZUtoU68p8JCc4DbZxKzm8isxzL+CA8mavua3L+qBCJgGTpAHIp8gOmE/RJ5C2lk
 B+EEMd3/HEKA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Sep 2020 19:44:38 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvmet: allow user to set the ns readonly
Date: Wed, 30 Sep 2020 19:44:25 -0700
Message-Id: <20201001024427.40753-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201001024427.40753-1-chaitanya.kulkarni@wdc.com>
References: <20201001024427.40753-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_224441_425191_5CACB5F4 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: mruijter@primelogic.nl, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: "Mark Ruijter" <mruijter@primelogic.nl>

User may want to export readonly ns to host in order to export
read-only snapshots. Right now we don't have configfs attribute to
allow user to mark readonly & export ns.

Add a configfs attribute such that user can set the ns and export ns
readonly when it is not enabled.

Signed-off-by: Mark Ruijter <mruijter@primelogic.nl>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..90c55ffab802 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -570,6 +570,34 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, buffered_io);
 
+static ssize_t nvmet_ns_readonly_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_ns(item)->readonly);
+}
+
+static ssize_t nvmet_ns_readonly_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool val;
+
+	if (strtobool(page, &val))
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("disable ns before setting readonly value.\n");
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+
+	ns->readonly = val;
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, readonly);
+
 static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
 		const char *page, size_t count)
 {
@@ -602,6 +630,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_ana_grpid,
 	&nvmet_ns_attr_enable,
 	&nvmet_ns_attr_buffered_io,
+	&nvmet_ns_attr_readonly,
 	&nvmet_ns_attr_revalidate_size,
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
