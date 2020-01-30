Return-Path: <SRS0=3CeD=3T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE7C2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 18:29:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E41820658
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 18:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MyoOsYpl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HE4s1SaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E41820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z4VPCGWOAreA66q9Yh0n3OGlzehXXC+5Msi3GX+kh6U=; b=MyoOsYplj9+FUy
	AeDjMS4MQkoW+moMMzHgu27gSckTbpPPsRBP1p94oDigliinU/ZwdxF4w00zTtr5KglgP61+Q9/5e
	tDFWUkPExj59eu2K6ObD2SKTzJyvhCHyoPY0wXY1TXTtTej74XVIlnFOwKJjB+aJ0Y0y6Qmgr59Dk
	fE5bQA2zSgQrTHGXdlFxxtFK57Z++9MCY3comZvUjMbfmahBpdUgmSDpvuWGYajgv7YUUA9PmgCfr
	0kMlv9iJWwbf1glH8hh1PzAICPMrzC1CoScyaN/6zDNhHFVW987zT3orl1EPCZ7RP4boeuV2S4oNO
	BYcZD8T2NTbXST564fVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixEZZ-000519-Jz; Thu, 30 Jan 2020 18:29:49 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ixEZS-0004wF-BA
 for linux-nvme@lists.infradead.org; Thu, 30 Jan 2020 18:29:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580408982; x=1611944982;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lziYktOPctwQIqibgTpzdTHDFAx0T7Ky/bHvMzscczM=;
 b=HE4s1SaWwJLL4eMDBpMxDnqu9BLmY27QU33lJm5EI1FHMFTTF9EtTNaC
 NKFtClUqo+wLLoKmiAkODWFrcXR9bBUanQNPp5IBNFjQvv3la5rk2grbl
 EPmLrJrewiWV9t9r5hTqz+5Yol2yiHXsOk35yBLVIKNTNnVspaLzJ89c/
 goqXaFbRyv8dyn/iPLRh4ZvREImLQsrgygAODwdyJwLjy+QC1jp4UPNe2
 KJF40uuvR0ldRPNnKN0api4m84RbGmTnlKgk+WxgEA9p7hLGtu2VqK8wW
 4TWo1SpbTHfObHziqt4PB/MOOcKlCrcjjKy2G/dGNNL1X3MZokJ0skoFQ w==;
IronPort-SDR: /Cw8ISUnj1XRSXQIOquGRnpUclkLDrBlTOgY5wLFKrBuIJvSkNtBI6u1eTOOxZaYXuvkZ55AMS
 h609Xs2nVdiP+JHT5WwKGwTZbLxA2we+10/lKyQ8JtLZZPEm1WGaJzS0odRPy3B1jqlIiRQc8n
 2WcBw11C1pvbwoOUbDPG1t4Y6/xO5XSFVkfXtv0DQb/q6Xy9/2sDms65AcI251GPvJdzgNbpnE
 ZMN3ntbnlBtXN3dWI21Mu2qoAbjFJz4JEcxucyS2Ugbmc6WNwdOC8uClr0qumhReBr+CXpCu4n
 AD0=
X-IronPort-AV: E=Sophos;i="5.70,382,1574092800"; d="scan'208";a="236698375"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2020 02:29:41 +0800
IronPort-SDR: Ei88O6effNPmEmPHBIV2h5g4WaGzT3qABU3aBqnllEyecuRO9cXDhGz2UGx1BWvZ4cMh8ONgF0
 iasjta3EwLe96UH/8aqMfrCcRf+CJMItuih9pk7SjVsAuPnh7w7vQgzV8tyb2BMnpaVsyGQQ3g
 Du1MVZzsZecyTEcWPmTotXQthouM1h9N/BSghA2+T5bX20uTTn6Y3yhgeAlj5tEUDKoTGgLgti
 BIbQ2fRCBxnMXDFB/r6oZzza0/l1wAPr930vO63bPS9OxdJGLvhGmoWR6/luYLSTgPI8LQ7481
 FMrEt491bV9msfY9rRz5Ldol
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2020 10:22:52 -0800
IronPort-SDR: 9F5G/PMJ3NSczI5aPpa/lIZQmNzG0jBxxXBbPVuD8SoI5VLOsi9RtwQ6qjQXENsHsscg8XwlsR
 iUCsiy1jiKTx2QO24cVl1rMPGHFwwQS7bgx8CT8/xXPaiZT9L/4jhO4IBUrxpzcQcorXCpyNQ0
 OfT9fucGSPhQBiRSi4+TzEo113nk1T3ddc4I+aFk4FrDx5cpwtqEHviW+iqmPftsSws3izs5oO
 ncjbcHj7vihZ4TvF2/7I/f9SsmaPCPa5Tifc2Pb7l+2J+jvYD9dSyTzTMllFspYRhp5cTrhdrg
 rH4=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Jan 2020 10:29:41 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 1/4] nvmet: make ctrl-id configurable
Date: Thu, 30 Jan 2020 10:29:31 -0800
Message-Id: <20200130182934.6109-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130182934.6109-1-chaitanya.kulkarni@wdc.com>
References: <20200130182934.6109-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200130_102942_388099_DD9359AA 
X-CRM114-Status: GOOD (  16.44  )
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

This patch adds a new target subsys attribute which allows user to
optionally specify target controller IDs which then used in the
nvmet_execute_identify_ctrl() to fill up the nvme_id_ctrl structure.

For example, when using a cluster setup with two nodes, with a dual
ported NVMe drive and exporting the drive from both the nodes,
The connection to the host fails due to the same controller ID and
results in the following error message:-

"nvme nvmeX: Duplicate cntlid XXX with nvmeX, rejecting"

With this patch now user can partition the controller IDs for each
subsystem by setting up the cntlid_min and cntlid_max. These values
will be used at the time of the controller ID creation. By partitioning
the ctrl-ids for each subsystem results in the unique ctrl-id space
which avoids the collision.

When new attribute is not specified target will fall back to original
cntlid calculation method.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V3:-

1. Remove error message in nvmet_subsys_attr_attr_cntlid_[min|max]().
2. Remove the return variable and simplify tail of the functions.

Changes from V2:-

1. Reduce the size of the lock for sscanf for cntlid_min and cntlid_max.
2. Remove the common show and store function for cntlid.
3. Move cntlid_min and cntlid_max check into the store function. 
4. Update the patch description.
5. Move check for valid cntlid_[min|max] parameter into configfs
   respective store function.

Changes from V1:-

1. Add cntlid max and min configfs attributes.
2. Use simple if .. else statements instead of ternary operators.
---
 drivers/nvme/target/configfs.c | 62 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  8 +++--
 drivers/nvme/target/nvmet.h    |  2 ++
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..c62f8b8b3d53 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -862,10 +862,72 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
+static ssize_t nvmet_subsys_attr_cntlid_min_show(struct config_item *item,
+						 char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cntlid_min);
+}
+
+static ssize_t nvmet_subsys_attr_cntlid_min_store(struct config_item *item,
+						  const char *page, size_t cnt)
+{
+	u16 cntlid_min;
+
+	if (sscanf(page, "%hu\n", &cntlid_min) != 1)
+		return -EINVAL;
+
+	if (cntlid_min == 0)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	if (cntlid_min >= to_subsys(item)->cntlid_max)
+		goto out_unlock;
+	to_subsys(item)->cntlid_min = cntlid_min;
+	up_write(&nvmet_config_sem);
+	return cnt;
+
+out_unlock:
+	up_write(&nvmet_config_sem);
+	return -EINVAL;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_min);
+
+static ssize_t nvmet_subsys_attr_cntlid_max_show(struct config_item *item,
+						 char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cntlid_max);
+}
+
+static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
+						  const char *page, size_t cnt)
+{
+	u16 cntlid_max;
+
+	if (sscanf(page, "%hu\n", &cntlid_max) != 1)
+		return -EINVAL;
+
+	if (cntlid_max == 0)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	if (cntlid_max <= to_subsys(item)->cntlid_min)
+		goto out_unlock;
+	to_subsys(item)->cntlid_max = cntlid_max;
+	up_write(&nvmet_config_sem);
+	return cnt;
+
+out_unlock:
+	up_write(&nvmet_config_sem);
+	return -EINVAL;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_max);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
 	&nvmet_subsys_attr_attr_serial,
+	&nvmet_subsys_attr_attr_cntlid_min,
+	&nvmet_subsys_attr_attr_cntlid_max,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..990ad4c7bdfd 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1267,8 +1267,11 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl->sqs)
 		goto out_free_cqs;
 
+	if (subsys->cntlid_min > subsys->cntlid_max)
+		goto out_free_cqs;
+
 	ret = ida_simple_get(&cntlid_ida,
-			     NVME_CNTLID_MIN, NVME_CNTLID_MAX,
+			     subsys->cntlid_min, subsys->cntlid_max,
 			     GFP_KERNEL);
 	if (ret < 0) {
 		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
@@ -1416,7 +1419,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		kfree(subsys);
 		return ERR_PTR(-ENOMEM);
 	}
-
+	subsys->cntlid_min = NVME_CNTLID_MIN;
+	subsys->cntlid_max = NVME_CNTLID_MAX;
 	kref_init(&subsys->ref);
 
 	mutex_init(&subsys->lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..6492d12e626a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -211,6 +211,8 @@ struct nvmet_subsys {
 	struct list_head	namespaces;
 	unsigned int		nr_namespaces;
 	unsigned int		max_nsid;
+	u16			cntlid_min;
+	u16			cntlid_max;
 
 	struct list_head	ctrls;
 
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
