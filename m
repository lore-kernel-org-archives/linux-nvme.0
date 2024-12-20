Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6BEE7718B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 03:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FCDcz2ORiHhY2xQmX4GF7vsBuD9XD40t3yNZS2lUJHY=; b=DgbPjzHAUIMF/ZLMB9dMNcGSN2
	qZgpbiyIg9A/FbADfMHfT119h0VkSMqZ2p6ozNnwcTIUv5mX8HexLBKs6fgrUnztHaMgxlznHrxAm
	+WKi0a+6BKJx6vdtdwYY9jmFbqLzpnD7I8/IaSvaJz6MjyQAjD+BuGcpVkgwijhZkn2oPN11UkWZr
	Wz31K5FLShLLlrzhmYOJoEsAphhFxCLD0sjphhxlajSw6d/Uw6FyV0jgzz7Py41VP8uAFfANqDQMs
	Zt4um4IfrlY9lyBimOPRrJyGi5ful/cxPiZ4NnzeR7WK4pGncDjOC4T4Z/Dqr5lPTTqQ7Hl5QstLb
	t/Kaw8+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOU5p-00000003plY-2l7P;
	Fri, 20 Dec 2024 03:54:25 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOU5m-00000003pk7-1pmu
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 03:54:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 25E44A42A5D;
	Fri, 20 Dec 2024 03:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7FEC4CEDD;
	Fri, 20 Dec 2024 03:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666861;
	bh=N/B1pRo6hOVQWHt3ZbjWuweqtwlmHGsn/bfBCzS3Z8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gh2sTzL5v0aToEI/hgmzJg2qNz0+mT1o+6LvKEqSsNm0lnvxmmu5+0WBzeiMngBam
	 8YhOzsFR39z6ZB8dg43ObAS9kV4Qp1CLCTqM92/r493fRVzrzbzsEjwTrigBxfQBHe
	 rHn+MRQvcqlWRIhyrzTM+wqVAqDeMpQ1wqEmt1Hkyv0xIQuqPT5sli3dtYpxlh3HiH
	 p1Sw4VCLSzIz8FogZyUBPG164HsTzRgkqmnRVJVBaGM9+AiMMApY/uOg4v0vgujfgm
	 k7GUzejtDZBlpOUkE1Xev999FfGXA12vxj85lhXTXmXBiYs4yF8BcRAADqb1cLOS3j
	 UxYjE6YoJiVzQ==
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
Subject: [PATCH v6 02/18] nvmet: Add vendor_id and subsys_vendor_id subsystem attributes
Date: Fri, 20 Dec 2024 12:54:25 +0900
Message-ID: <20241220035441.600193-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220035441.600193-1-dlemoal@kernel.org>
References: <20241220035441.600193-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_195422_602983_27327145 
X-CRM114-Status: GOOD (  14.07  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
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


