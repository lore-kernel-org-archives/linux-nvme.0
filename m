Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D317C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 22:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QKBHB0Yl26NC6TA5ViY7tN9xRp2XnM1tboGiczSYXL8=; b=GE3QnjDm0qQlz3r559tOvTXCYd
	75mdS5qj/yPl3XA54AOraPg2b5s0eDOtjcidjxHfQFJKbiX3NSbfd5F4Sr6RE9qKaKCwRlHBUPYg2
	QlCUHOQFO3z5wd7sj5jUCDPHQ2fMu8d6kqX4q6vF7773dxXc0bQK5NC7xDedYf+71OKUB8McfreOM
	dac+TIb1/t+lY6jYmI7cROmOCWo2+17PDmrnJIZ85kmi5WEIE3y7WD3/GurIUNfWEijdZZDBwr6Gs
	0jL6x4JiFqH81OIIiAU7Fdnx8C8UOmXvxEDhfPhvJS2QfUvY7F3MQS1HLjQYoCKScujSbKgf1Zs1S
	w/B8hbFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o498a-00CSbf-UW; Wed, 22 Jun 2022 22:47:52 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o498X-00CSZ5-80
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 22:47:51 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MIppR1003244;
	Wed, 22 Jun 2022 22:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=QKBHB0Yl26NC6TA5ViY7tN9xRp2XnM1tboGiczSYXL8=;
 b=yJVOo8bkL/Ku89RXuj178ZbWdioLAhDFe0K98LhMY67rc111rOFcQd+061AM2GI6WTza
 PZgfIZrYYMFYg4wWYV+1Q6V0ScESxGLEFL1TEh6Yd4qJdriEWc+6E+JeNIy7uTcHsr0d
 sbQDGRx2pTBgZUa7uCPyAd+mFJGfXx3D24S7CMNgNOfX0uwObmztV9RC7LekLVC6fW16
 Tf79HqcqDTPf3V93VHDQB92yHAbzUsOAc3A+prPO/pw+rjv9DCLH30ahH2jyqaYLxzSX
 DZrxoBp+DfUOBxOWHBxqf0p+W3JK3kbN9y1jWZsvVVlFXorY7a6nW0YzKYyXtpYLgMK2 Rw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78u1nx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jun 2022 22:47:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25MMk21G020139;
	Wed, 22 Jun 2022 22:47:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfw3ggc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jun 2022 22:47:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25MMlesR022609;
	Wed, 22 Jun 2022 22:47:40 GMT
Received: from dhcp-10-159-150-168.vpn.oracle.com (dhcp-10-159-150-168.vpn.oracle.com [10.159.150.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfw3ge1-1;
	Wed, 22 Jun 2022 22:47:40 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [PATCH] Add new clear_ids attribute for passthru targets
Date: Wed, 22 Jun 2022 15:47:24 -0700
Message-Id: <20220622224724.19623-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3QZTX7fJb6lPTPcv3q4_UH0WAxPFT5KF
X-Proofpoint-ORIG-GUID: 3QZTX7fJb6lPTPcv3q4_UH0WAxPFT5KF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_154749_502509_0A42D9BB 
X-CRM114-Status: GOOD (  24.01  )
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

If the clear_ids attribute is set to true, the EUI/GUID/UUID is
cleared for the passthru target.  By default, loop targets will
set clear_ids to true.

This resolves an issue where a connect to a passthru target fails
when using a trtype of 'loop' because EUI/GUID/UUID is not unique.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 drivers/nvme/target/configfs.c | 20 ++++++++++++
 drivers/nvme/target/core.c     |  4 +++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 58 ++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e44b2988759e..ff77c3d2354f 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -773,11 +773,31 @@ static ssize_t nvmet_passthru_io_timeout_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_passthru_, io_timeout);
 
+static ssize_t nvmet_passthru_clear_ids_show(struct config_item *item,
+		char *page)
+{
+	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->clear_ids);
+}
+
+static ssize_t nvmet_passthru_clear_ids_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	unsigned int clear_ids;
+
+	if (kstrtouint(page, 0, &clear_ids))
+		return -EINVAL;
+	subsys->clear_ids = clear_ids;
+	return count;
+}
+CONFIGFS_ATTR(nvmet_passthru_, clear_ids);
+
 static struct configfs_attribute *nvmet_passthru_attrs[] = {
 	&nvmet_passthru_attr_device_path,
 	&nvmet_passthru_attr_enable,
 	&nvmet_passthru_attr_admin_timeout,
 	&nvmet_passthru_attr_io_timeout,
+	&nvmet_passthru_attr_clear_ids,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 90e75324dae0..d4203d582343 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1374,6 +1374,10 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	ctrl->port = req->port;
 	ctrl->ops = req->ops;
 
+	/* By default, set loop targets to clear IDS by default */
+	if (ctrl->port->disc_addr.trtype == NVMF_TRTYPE_LOOP)
+		subsys->clear_ids = 1;
+
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
 	INIT_LIST_HEAD(&ctrl->async_events);
 	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69818752a33a..2b3e5719f24e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -249,6 +249,7 @@ struct nvmet_subsys {
 	struct config_group	passthru_group;
 	unsigned int		admin_timeout;
 	unsigned int		io_timeout;
+	unsigned int		clear_ids;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 
 #ifdef CONFIG_BLK_DEV_ZONED
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b1f7efab3918..e8c033fbdb5c 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -30,6 +30,55 @@ void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl)
 		ctrl->cap &= ~(1ULL << 43);
 }
 
+static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	void *data;
+	struct nvme_ns_id_desc *cur;
+	u16 status = NVME_SC_SUCCESS;
+	u8 csi;
+	int pos, len;
+	bool csi_seen;
+
+	if (!ctrl->subsys->clear_ids)
+		return status;
+
+	data = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
+	if (!data)
+		return NVME_SC_INTERNAL;
+
+	status = nvmet_copy_from_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
+	if (status)
+		goto out_free;
+
+	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
+		cur = data + pos;
+
+		if (cur->nidl == 0)
+			break;
+		len = cur->nidl;
+		if (cur->nidt == NVME_NIDT_CSI) {
+			memcpy(&csi, data + pos + sizeof(struct nvme_ns_id_desc),
+			       NVME_NIDT_CSI_LEN);
+			csi_seen = 1;
+			break;
+		}
+		len += sizeof(struct nvme_ns_id_desc);
+	}
+
+	memset(data, 0, NVME_IDENTIFY_DATA_SIZE);
+	if (csi_seen) {
+		cur = data;
+		cur->nidt = NVME_NIDT_CSI;
+		cur->nidl = NVME_NIDT_CSI_LEN;
+		memcpy(data + sizeof(struct nvme_ns_id_desc), &csi,  NVME_NIDT_CSI_LEN);
+	}
+	status = nvmet_copy_to_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
+out_free:
+	kfree(data);
+	return status;
+}
+
 static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -127,6 +176,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 
 static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
 {
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	u16 status = NVME_SC_SUCCESS;
 	struct nvme_id_ns *id;
 	int i;
@@ -152,6 +202,11 @@ static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
 	 */
 	id->mc = 0;
 
+	if (ctrl->subsys->clear_ids) {
+		memset(id->nguid, 0, NVME_NIDT_NGUID_LEN);
+		memset(id->eui64, 0, NVME_NIDT_EUI64_LEN);
+	}
+
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
 out_free:
@@ -176,6 +231,9 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 		case NVME_ID_CNS_NS:
 			nvmet_passthru_override_id_ns(req);
 			break;
+		case NVME_ID_CNS_NS_DESC_LIST:
+			nvmet_passthru_override_id_descs(req);
+			break;
 		}
 	} else if (status < 0)
 		status = NVME_SC_INTERNAL;
-- 
2.31.1


