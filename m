Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759EDE77180
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 09:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZyaodD0PaC8r7lNuzoW1GjZWLtU8r/8cY70JxUtR2tM=; b=wEVqgtAE0yjPAtHUQwMiDd2o72
	9uCiMg/Tm7Ths15OsEXDtbkC7x2NhIRs+YkdWHq5nTxUsZxFEGbT3EnA7+3Tz2PnfyN4DRvkh9f3h
	h7Mo+nju68kc2/JuV8nqeSbCBtcOMfoyazBEyJ/kVvy/QZyeVKZ4l9nirmFdhS04Yq9KiusNRGkhA
	9dsmIJyYkmdWuuruduG1hiPKLy7nZxDMAGZzmgTfev1NUCHAzfYw/+Lhs3R9QotI01ipCRw7hvAtR
	bBeEwjafbWRJD6NK88HK+bJoYIWik8K9JQaoRKTXb/AprcewXBp2OLz5LReTiXhwqHUROzSvyq9ZK
	97cxF+FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKwgk-0000000AvZg-24JG;
	Tue, 10 Dec 2024 09:37:54 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKwdb-0000000AuM8-2NRJ
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 09:34:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6238AA40D44;
	Tue, 10 Dec 2024 09:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8B0C4CEE1;
	Tue, 10 Dec 2024 09:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733823278;
	bh=F5ZQQLnxyGHvSOeSYxxMshnQzNkNcQ1CiuLFXiKM4vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXy8KjpqjE4vPdujwiSH/wjqyD8LG9zY0HVG6FcDX8PlVz4R6/d8BLnMFKWJj15RJ
	 ygxJHAXk3E/cWlLT0FgPNHR4hr8SdCjy+bhuHe8imGQGS7YldJYfvwSW0r6vHRSIqZ
	 ZPJB1feUuFnyIAGGHwQ39vq9SChpvoEFMPaDG6HILrWctVc1+VaYNbf7GYQ6kEMdy/
	 +yY15on1u5wlnWQcyB6I/EwiYaGYWZQvr8GVvgGg1TVC4Nyy/LCPYthLnS7/J17j7E
	 icna3DR8RY+kpJ2CYgqB/lZvh+aQQMX5xsRCQrMNXEtdERTdJExzviU+hR5S1fNSvM
	 hH/idbQKqHYew==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 01/17] nvmet: Add vendor_id and subsys_vendor_id subsystem attributes
Date: Tue, 10 Dec 2024 18:33:52 +0900
Message-ID: <20241210093408.105867-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210093408.105867-1-dlemoal@kernel.org>
References: <20241210093408.105867-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_013439_745938_7BB5DEA9 
X-CRM114-Status: GOOD (  13.62  )
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

Define the new vendor_id and subsys_vendor_id configfs attribute for
target subsystems. These attributes are respectively reported as the
vid field and as the ssvid field of the identify controller data of
a target controllers using the subsystem for which these attributes
are set.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/admin-cmd.c |  5 ++--
 drivers/nvme/target/configfs.c  | 45 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 2962794ce881..b73f5fde4d9e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -522,9 +522,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 		goto out;
 	}
 
-	/* XXX: figure out how to assign real vendors IDs. */
-	id->vid = 0;
-	id->ssvid = 0;
+	id->vid = cpu_to_le16(subsys->vendor_id);
+	id->ssvid = cpu_to_le16(subsys->subsys_vendor_id);
 
 	memcpy(id->sn, ctrl->subsys->serial, NVMET_SN_MAX_SIZE);
 	memcpy_and_pad(id->mn, sizeof(id->mn), subsys->model_number,
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index eeee9e9b854c..4b2b8e7d96f5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1412,6 +1412,49 @@ static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_max);
 
+static ssize_t nvmet_subsys_attr_vendor_id_show(struct config_item *item,
+		char *page)
+{
+	return snprintf(page, PAGE_SIZE, "0x%x\n", to_subsys(item)->vendor_id);
+}
+
+static ssize_t nvmet_subsys_attr_vendor_id_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	u16 vid;
+
+	if (kstrtou16(page, 0, &vid))
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	to_subsys(item)->vendor_id = vid;
+	up_write(&nvmet_config_sem);
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_vendor_id);
+
+static ssize_t nvmet_subsys_attr_subsys_vendor_id_show(struct config_item *item,
+		char *page)
+{
+	return snprintf(page, PAGE_SIZE, "0x%x\n",
+			to_subsys(item)->subsys_vendor_id);
+}
+
+static ssize_t nvmet_subsys_attr_subsys_vendor_id_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	u16 ssvid;
+
+	if (kstrtou16(page, 0, &ssvid))
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	to_subsys(item)->subsys_vendor_id = ssvid;
+	up_write(&nvmet_config_sem);
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_subsys_vendor_id);
+
 static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
 					    char *page)
 {
@@ -1640,6 +1683,8 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_serial,
 	&nvmet_subsys_attr_attr_cntlid_min,
 	&nvmet_subsys_attr_attr_cntlid_max,
+	&nvmet_subsys_attr_attr_vendor_id,
+	&nvmet_subsys_attr_attr_subsys_vendor_id,
 	&nvmet_subsys_attr_attr_model,
 	&nvmet_subsys_attr_attr_qid_max,
 	&nvmet_subsys_attr_attr_ieee_oui,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 58328b35dc96..e4a31a37c14b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -324,6 +324,8 @@ struct nvmet_subsys {
 	struct config_group	namespaces_group;
 	struct config_group	allowed_hosts_group;
 
+	u16			vendor_id;
+	u16			subsys_vendor_id;
 	char			*model_number;
 	u32			ieee_oui;
 	char			*firmware_rev;
-- 
2.47.1


