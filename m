Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04684C9830B
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DmWiMwtjUNhE7pDI46zh3hWGMwkIrcVg32ax/z+GaCQ=; b=qQu9wrLP5AUPjFkAeJkPL7iJ84
	0AOq2H95Bf3iq7HzlyUcHSY9dgASC7MawfBvo6bfrQa32tLbxv98xvN8ztBRdvScH3Qg/r7VByg7n
	NXI1rdRkHMSAQ93OAk6YLQgeSLxp1GBvgvyvqZneKI+7HEcBlA6MpZeqLSx3EibQwbssOs7vy4BId
	vXssBxZG/N13rHzhImYORLcI2frbzos57YbNQMGRU8pNAqrlcbegbgzrrt6NWv0vUK89CU+183o/O
	nkONit7FK4nsw6AWNHM4kkueMllaz6lYEfM2EwGD/eqwu8DL+u+qvGVIBJYnvkl9Lv69j+lKTt+JD
	ysGqw6YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9TRw-00000009RSc-2n9C;
	Wed, 23 Sep 2026 20:20:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9TRu-00000009RSD-2JWT
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 20:20:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790194813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DmWiMwtjUNhE7pDI46zh3hWGMwkIrcVg32ax/z+GaCQ=;
	b=OJ8/tTlRBnCMNzBxAqaqsz7xs+oLgVqLujTZwE7AzJtGVA/nT1JLbZ3xPNBy/98O1O9WG1
	OD07PlYJnGhiuiJANayXbRObD34Ney/UrAuezioNm+XPRbo6O8+Egcb0eLwTAook3Cq1YJ
	x1scJIjiXPcwNjgL3DQg0vQrxdXych4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-M_l4EBVtMFOSErBqp6mH1Q-1; Wed,
 23 Sep 2026 16:20:10 -0400
X-MC-Unique: M_l4EBVtMFOSErBqp6mH1Q-1
X-Mimecast-MFC-AGG-ID: M_l4EBVtMFOSErBqp6mH1Q_1790194808
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0CDE1954236;
	Wed, 23 Sep 2026 20:20:07 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.16.153])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10F1D1953948;
	Wed, 23 Sep 2026 20:20:05 +0000 (UTC)
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
Subject: [PATCH v2] nvmet: Add traffic based keep alive support to configfs
Date: Wed, 23 Sep 2026 16:20:03 -0400
Message-ID: <20260923202003.1776271-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: ZubjlwrXgzN_D13ACTp2mu_Rhrx6vYs90xg_3S1qlaw_1790194808
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_132014_696016_57D5EC86 
X-CRM114-Status: GOOD (  17.62  )
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
V1 -> V2:
 - Add tbkas to nvmet_ctrl
 - Force reconnect controllers when tbkas is set
 - Use ctrl->tbkas in nvmet_execute_identify_ctrl and nvmet_req_init
---
 drivers/nvme/target/admin-cmd.c |  4 +++-
 drivers/nvme/target/configfs.c  | 29 +++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  4 +++-
 drivers/nvme/target/nvmet.h     |  2 ++
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 7764a3c0195c..26028be8fe4d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -696,7 +696,9 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	/* XXX: figure out what to do about RTD3R/RTD3 */
 	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
-	ctratt = NVME_CTRL_ATTR_HID_128_BIT | NVME_CTRL_ATTR_TBKAS;
+	ctratt = NVME_CTRL_ATTR_HID_128_BIT;
+	if (ctrl->tbkas)
+		ctratt |= NVME_CTRL_ATTR_TBKAS;
 	if (nvmet_is_pci_ctrl(ctrl))
 		ctratt |= NVME_CTRL_ATTR_RHII;
 	id->ctratt = cpu_to_le32(ctratt);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 6286e38436dd..2b879b1d4c3c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1369,6 +1369,34 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
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
+	struct nvmet_ctrl *ctrl;
+	bool tbkas;
+
+	if (kstrtobool(page, &tbkas))
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	subsys->tbkas = tbkas;
+
+	/* Force reconnect */
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		ctrl->ops->delete_ctrl(ctrl);
+	up_write(&nvmet_config_sem);
+
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_tbkas);
+
 static ssize_t nvmet_subsys_attr_cntlid_min_show(struct config_item *item,
 						 char *page)
 {
@@ -1706,6 +1734,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_qid_max,
 	&nvmet_subsys_attr_attr_ieee_oui,
 	&nvmet_subsys_attr_attr_firmware,
+	&nvmet_subsys_attr_attr_tbkas,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 43871a8f56ca..6b4bda231bd9 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1227,7 +1227,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_sq *sq,
 		goto fail;
 	}
 
-	if (sq->ctrl)
+	if (sq->ctrl && sq->ctrl->tbkas)
 		sq->ctrl->reset_tbkas = true;
 
 	return true;
@@ -1677,6 +1677,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	mutex_lock(&subsys->lock);
 
 	ctrl->max_qid = subsys->max_qid;
+	ctrl->tbkas = subsys->tbkas;
 
 	ctrl->sqs = kzalloc_objs(struct nvmet_sq *, ctrl->max_qid + 1);
 	if (!ctrl->sqs)
@@ -1865,6 +1866,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	}
 
 	subsys->ieee_oui = 0;
+	subsys->tbkas = true;
 
 	subsys->firmware_rev = kstrndup(UTS_RELEASE, NVMET_FR_MAX_SIZE, GFP_KERNEL);
 	if (!subsys->firmware_rev) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dbda55895f4f..2bc0e87ea981 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -270,6 +270,7 @@ struct nvmet_ctrl {
 	u16			cntlid;
 	u16			max_qid;
 	u32			kato;
+	bool			tbkas;
 
 	struct nvmet_port	*port;
 
@@ -343,6 +344,7 @@ struct nvmet_subsys {
 	bool			subsys_discovered;
 	char			*subsysnqn;
 	bool			pi_support;
+	bool			tbkas;
 
 	struct config_group	group;
 
-- 
2.55.0


