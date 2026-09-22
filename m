Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ECFC982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f7WaOHgKg8Vd0Ib9aySxYndrKCmtGTXszN0D/8f6w8s=; b=xMpVHdijS+sbpIHZOr4T0DUWKs
	8fYBgD5A6rstDOemCs/oxuAXnaC/PuxNUDaO/P5h/J+u8aAMHLLz+yi010UO2etBIHU93jJ8cwMTS
	ylj85lL6JKCJ3U/Wg++vejZeoLQiptJKDnHLka1aAtTWf8afNUWWD/fnRBAimGWJMHsQj+4LfpQEq
	Kb2UH8nTPlh3bfuSsdJqmi07Q5kcR1i0XF51eKFod8zohDv5p2e/LguzMNeRiJWe955xeiLqz3lJF
	f7Yryz4MLOUDj2vw07ohoX+EdkHAkeyhBCutdVB2LbPe+c20aJt3vOJktqyQyW28JfTryoDx0Co27
	RpTRrnCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x971D-00000006Wl9-0orz;
	Tue, 22 Sep 2026 20:23:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x971A-00000006Wkj-1weo
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 20:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790108586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f7WaOHgKg8Vd0Ib9aySxYndrKCmtGTXszN0D/8f6w8s=;
	b=LCwNXaa0PbI6Qbg7klQd58BsMCqOZT8MQURnafjTjUOmPBHLsBxbL4UsnE5jar/O9BPlhG
	S37bntvvt9GeZu4I0LCWft4Rv6c6iJXzIqkovUKfQHM8PolxH2jq9W2nsmgH6QUCz2MCec
	EdK3I0vKJZnRkUv3uk8kGIldu/KxyHw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-ax_MA_zrP2OKe7MhJAu_Ig-1; Tue,
 22 Sep 2026 16:23:04 -0400
X-MC-Unique: ax_MA_zrP2OKe7MhJAu_Ig-1
X-Mimecast-MFC-AGG-ID: ax_MA_zrP2OKe7MhJAu_Ig_1790108583
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90AEE1800626;
	Tue, 22 Sep 2026 20:23:02 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.64.21])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7185041B;
	Tue, 22 Sep 2026 20:22:59 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [PATCH v1] nvmet: Add traffic based keep alive support to configfs
Date: Tue, 22 Sep 2026 16:22:56 -0400
Message-ID: <20260922202257.1434980-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: QXCG87Xb57grWS3iyxFszfs3G-peVSufPSgooLnzPpg_1790108583
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_132308_578710_E34CEEA2 
X-CRM114-Status: GOOD (  17.54  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add the ability to turn on and off tbkas (traffic based keep alive
support) via configfs. This is useful for testing and debugging.

Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
---
 drivers/nvme/target/admin-cmd.c |  4 +++-
 drivers/nvme/target/configfs.c  | 27 +++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  3 ++-
 drivers/nvme/target/nvmet.h     |  1 +
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 7764a3c0195c..e734e4b68784 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -696,7 +696,9 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	/* XXX: figure out what to do about RTD3R/RTD3 */
 	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
-	ctratt = NVME_CTRL_ATTR_HID_128_BIT | NVME_CTRL_ATTR_TBKAS;
+	ctratt = NVME_CTRL_ATTR_HID_128_BIT;
+	if (subsys->tbkas)
+		ctratt |= NVME_CTRL_ATTR_TBKAS;
 	if (nvmet_is_pci_ctrl(ctrl))
 		ctratt |= NVME_CTRL_ATTR_RHII;
 	id->ctratt = cpu_to_le32(ctratt);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 6286e38436dd..5766e594e724 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1369,6 +1369,32 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
+static ssize_t nvmet_subsys_attr_tbkas_show(struct config_item *item,
+					     char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%d\n", to_subsys(item)->tbkas);
+}
+
+static ssize_t nvmet_subsys_attr_tbkas_store(struct config_item *item,
+					      const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	bool tbkas;
+
+	if (subsys->subsys_discovered) {
+		pr_err("Can't set traffic based keep alive support. %d is already assigned\n",
+		       subsys->tbkas);
+		return -EINVAL;
+	}
+
+	if (kstrtobool(page, &tbkas))
+		return -EINVAL;
+
+	subsys->tbkas = tbkas;
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_tbkas);
+
 static ssize_t nvmet_subsys_attr_cntlid_min_show(struct config_item *item,
 						 char *page)
 {
@@ -1706,6 +1732,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_qid_max,
 	&nvmet_subsys_attr_attr_ieee_oui,
 	&nvmet_subsys_attr_attr_firmware,
+	&nvmet_subsys_attr_attr_tbkas,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 43871a8f56ca..20aeb9624be0 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1227,7 +1227,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_sq *sq,
 		goto fail;
 	}
 
-	if (sq->ctrl)
+	if (sq->ctrl && sq->ctrl->subsys->tbkas)
 		sq->ctrl->reset_tbkas = true;
 
 	return true;
@@ -1865,6 +1865,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	}
 
 	subsys->ieee_oui = 0;
+	subsys->tbkas = true;
 
 	subsys->firmware_rev = kstrndup(UTS_RELEASE, NVMET_FR_MAX_SIZE, GFP_KERNEL);
 	if (!subsys->firmware_rev) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dbda55895f4f..241eac4fa969 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -343,6 +343,7 @@ struct nvmet_subsys {
 	bool			subsys_discovered;
 	char			*subsysnqn;
 	bool			pi_support;
+	bool			tbkas;
 
 	struct config_group	group;
 
-- 
2.55.0


