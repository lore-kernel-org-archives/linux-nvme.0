Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CC3C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 15:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A0ei+56QWX499gBjzi+hrVej1/fjvR5fi8SC0ejFYMo=; b=RE/5a0742rYEtg2SRSudcCantm
	N9J9UB/RQB4TvkS1xQYx7+zD/qM3a3eo1CpvRMvHWdt0ozqNxu3zaCqvEO+IeHgxDh68SKQ5e9v14
	JLQFOk6OIDTle3mOjcgUUC63cROB9OceZ1OUTXth+W/GvwJ/wxAorligrj4AInvgNu8JqpJHmlQ+q
	rqxvbE9qU3fNnuSlEibCi+NuhUzQE8lxwxbVGuBnKiIqpYBgqMvYlTHaWkVX9Nt2oLeKsLua9B8d2
	vXfO53wZbKN0OEKXQKNiG0Y+Bq5C/GdJ/nzCYAEJkjC08z/i2Pvy+UtJ5WXXX3FDXxm31uvsY10ix
	KDXb6P1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nybAI-008Hwq-R0; Tue, 07 Jun 2022 15:30:42 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nybAF-008Hu3-CH
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 15:30:41 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25751U8f022120
	for <linux-nvme@lists.infradead.org>; Tue, 7 Jun 2022 08:30:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=A0ei+56QWX499gBjzi+hrVej1/fjvR5fi8SC0ejFYMo=;
 b=MrMuTew+a9YFOLBQD+wx/zWENau0T1O4q0hNG6tqg15T3kHTY9jsm5620X04VHmiezL2
 GVlDSibLCs9moarl+YJF9k43C13YYeA0JDAM/JEKxfKl0KePYslthaeBT5Y3QqS46cgB
 vvVgIPrMbMEKrs+VhCSsFg4ywfI9hd2SOAs= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ghy4su4bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 07 Jun 2022 08:30:34 -0700
Received: from twshared35153.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 7 Jun 2022 08:30:32 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 929424CE3141; Tue,  7 Jun 2022 08:30:29 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] nvme: add bug report info for global duplicate id
Date: Tue, 7 Jun 2022 08:30:29 -0700
Message-ID: <20220607153029.157439-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MiLlMfRslBFy6m-jXGsE9Wabm-MLxa1H
X-Proofpoint-GUID: MiLlMfRslBFy6m-jXGsE9Wabm-MLxa1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-07_07,2022-06-07_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_083039_622131_778E9A39 
X-CRM114-Status: GOOD (  18.63  )
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

From: Keith Busch <kbusch@kernel.org>

The recent global id check is finding poorly implemented devices in the
wild. Include relavant device information in the output to help quicken
an appropriate quirk patch.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Allow transport drivers to define their own device info op. For PCI,
  this will let us print the device id in addition to the vendor.

 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/nvme.h | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/pci.c  | 16 ++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee3c8..5c9f3648c7d6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3863,6 +3863,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, un=
signed nsid,
 	if (ret) {
 		dev_err(ctrl->device,
 			"globally duplicate IDs for nsid %d\n", nsid);
+		nvme_print_device_info(ctrl);
 		return ret;
 	}
=20
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b72b6ecf33c..0da94b233fed 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -503,6 +503,7 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+	void (*print_device_info)(struct nvme_ctrl *ctrl);
 };
=20
 /*
@@ -548,6 +549,33 @@ static inline struct request *nvme_cid_to_rq(struct =
blk_mq_tags *tags,
 	return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
 }
=20
+/*
+ * Return the length of the string without the space padding
+ */
+static inline int nvme_strlen(char *s, int len)
+{
+	while (s[len - 1] =3D=3D ' ')
+		len--;
+	return len;
+}
+
+static inline void nvme_print_device_info(struct nvme_ctrl *ctrl)
+{
+	struct nvme_subsystem *subsys =3D ctrl->subsys;
+
+	if (ctrl->ops->print_device_info) {
+		ctrl->ops->print_device_info(ctrl);
+		return;
+	}
+
+	dev_err(ctrl->device,
+		"VID:%04x model:%.*s firmware:%.*s\n", subsys->vendor_id,
+		nvme_strlen(subsys->model, sizeof(subsys->model)),
+		subsys->model, nvme_strlen(subsys->firmware_rev,
+					   sizeof(subsys->firmware_rev)),
+		subsys->firmware_rev);
+}
+
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 			    const char *dev_name);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9d963f6cdbae..be053d943731 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2984,6 +2984,21 @@ static int nvme_pci_get_address(struct nvme_ctrl *=
ctrl, char *buf, int size)
 	return snprintf(buf, size, "%s\n", dev_name(&pdev->dev));
 }
=20
+
+static void nvme_pci_print_device_info(struct nvme_ctrl *ctrl)
+{
+	struct pci_dev *pdev =3D to_pci_dev(to_nvme_dev(ctrl)->dev);
+	struct nvme_subsystem *subsys =3D ctrl->subsys;
+
+	dev_err(ctrl->device,
+		"VID:DID %04x:%04x model:%.*s firmware:%.*s\n",
+		pdev->vendor, pdev->device,
+		nvme_strlen(subsys->model, sizeof(subsys->model)),
+		subsys->model, nvme_strlen(subsys->firmware_rev,
+					   sizeof(subsys->firmware_rev)),
+		subsys->firmware_rev);
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops =3D {
 	.name			=3D "pcie",
 	.module			=3D THIS_MODULE,
@@ -2995,6 +3010,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops=
 =3D {
 	.free_ctrl		=3D nvme_pci_free_ctrl,
 	.submit_async_event	=3D nvme_pci_submit_async_event,
 	.get_address		=3D nvme_pci_get_address,
+	.print_device_info	=3D nvme_pci_print_device_info,
 };
=20
 static int nvme_dev_map(struct nvme_dev *dev)
--=20
2.30.2


