Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFA7C5AD49
	for <linux-nvme@archiver.kernel.org>; Thu, 29 May 2025 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mrtiVI3wsdb9531QjYvBSe8ap8oJiLcbu6nHBGOyHOI=; b=kH9kmcO3He+s1hvMEbi7UxNvLD
	4VxSr6vJ3XbcbXGuB++/lp/7On7A27YRBa2avitQOuXPavoLhDPpHEX7IaxRjVbDwRF451R4cGmCh
	v04RvO5oQNy6u4svbrl004lpmZOa7aYm1sMtk6UXNSDpkau6Xot/UyH5hjz+8wYvSZi0djjx+r3xz
	fKdeOVTxMeVGhKpe8XFd49KJyD8UTGE2/NZHD2oDyj6LZRJKV3XhxWGDooRZnV3pvLtDK0CVRmPIU
	/kR9ReeP7FBrrsJNeMaMmNzAOvpS84yC4dnfN2PB68fKw0/Pw4vcciO7nLKcbFP45KzFUTq2u6jJm
	84csnj/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKh4t-0000000GHzt-1YIZ;
	Thu, 29 May 2025 17:30:03 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKh4q-0000000GHz4-3MLl
	for linux-nvme@lists.infradead.org;
	Thu, 29 May 2025 17:30:01 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-234fcadde3eso14007445ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748539799; x=1749144599; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrtiVI3wsdb9531QjYvBSe8ap8oJiLcbu6nHBGOyHOI=;
        b=cSxMLtNNP1TZdhHokfpN169qCyj5eDBMl/Ak7byFZX+l9bRBpF3m078t44fzmu/TPM
         xyjm8rAXlx9VfCXIUdAAaY5RlnjpWR5pUs2WgPnSSRoWgix2DQzFdcxETb7p++1sBnto
         ZRGgNqGxCIzGkhRa+44N61qMdnLs/KcubL6/9B/OlmyZhKhVD1ERTdfyCsNLSqA9fvrJ
         nR72li6QFkQte6EQreCPbB+MkZozECgmdOBvpow2NNBRnzk7XgpVd5xxM/akz2ZqgGFI
         y5rj2jFT/QC58tdyh/UvMJZli5N4nPemUbOtrJF03bPZehA88xOpHQ5VXQJCN0BK26PO
         A9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748539799; x=1749144599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrtiVI3wsdb9531QjYvBSe8ap8oJiLcbu6nHBGOyHOI=;
        b=SatkDAaIcBuQcYCmAkaymAQ4oX0xEse2I5JN8dwxGnM/uC4BKeNAQtR+IZY+RbIiLF
         9WTs5y3HRL4EYLFBejUeP62WwNVHj5TpTjCAJGso+8dJadt/dMcoZKNQDm4n258ozxbi
         ISn+/lYuhimj161Q+o1ytWVVJ6dnMFv9pYP1o6Qp/XO8jYTEAaA6lQ+1nwkSdTzqEZtl
         QT5qmmxvzflvezGCEnhOmQX09M9FW2s1aqEYF3+5ENW+XvPGpAwgwRtXNuanuAkmEeDJ
         vJreeWM/PTSIOSDit6ob1ll9GdGTNe1KbBCVZbQQH1anS5rHIn3aJLkO5VN9wx3OU2Wa
         io6A==
X-Gm-Message-State: AOJu0Yx1CoHDa1vnw9UPw27QuXbMlBLm/WkSnnq8ojugQ3GyR4e5bw4x
	7srwBAWIGn5E1cCKSbgmu/FhYIpR56ZybukHw4OMYHW2fZqSMZEHtxIouU4YWw==
X-Gm-Gg: ASbGncsuejohKGmD+ualD25m4//vpa8329CFF6TwErNaM8KM8a20XE41PV/wU8UXnJ9
	watPnSSUVuN5pc0mQOXpXe/seQkrsO29PNjeKxAMsxZx8DtRHpdW3D40OUTfZZ/1LiyZM8u97OR
	2kcO17PDewaHOMgFa137upLAfDtjvSWnQqDWgqT8XWtw4rt+TT7R49SAuaPxHEWK1IZe4FmNCm6
	9CTYclfyqCwRdAdoIYhtnEqa4PPDV52A6JHX7cbcjl/TISCaf3577+RXe3+L1lNruLXe5NSCHPM
	cTMFIIAwQ1tSQ0nyIxIqAr1sRI9eYTp4iG/stobfw0LXie0C2T3x3TpZdYdDroHbntt76WGyp2b
	z6Q==
X-Google-Smtp-Source: AGHT+IF4aIgxHj0fB/OI5GrQTmgn3nz1vAuq7wvv42Ba3KC3A7xl07ih002gx5MWD6u6KV8lrI65TA==
X-Received: by 2002:a17:902:f693:b0:234:9670:cc8a with SMTP id d9443c01a7336-235294fd982mr6147785ad.24.1748539799199;
        Thu, 29 May 2025 10:29:59 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:31a7:446:9364:5b1f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf5233sm14757665ad.201.2025.05.29.10.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 10:29:58 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v2] nvme-pci: add NVMe controller statistics
Date: Fri, 30 May 2025 02:29:02 +0900
Message-ID: <20250529172954.5217-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_103000_855436_81D633E5 
X-CRM114-Status: GOOD (  13.12  )
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

This is to count the controller warning events.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
Changes since v1:
- Split the sysfs stats attribute to create 4 new files.
- Create stats subdirectory for the attibutes split.
- Change the device attributes to read-write version.

 drivers/nvme/host/nvme.h |   9 +++
 drivers/nvme/host/pci.c  | 127 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ad0c1f834f09..5a6d0aebc9f8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -277,6 +277,13 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FROZEN		= 6,
 };
 
+struct nvme_stats {
+	unsigned long timeouts;
+	unsigned long aborts;
+	unsigned long resets;
+	unsigned long disables;
+};
+
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
@@ -411,6 +418,8 @@ struct nvme_ctrl {
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
 	u16 awupf; /* 0's based value. */
+
+	struct nvme_stats stats;
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e0bfe04a2bc2..632b222b51ff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1467,6 +1467,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 		dev_warn(dev->ctrl.device,
 			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
 			 csts, result);
+	dev->ctrl.stats.resets++;
 
 	if (csts != ~0)
 		return;
@@ -1528,6 +1529,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 		dev_warn(dev->ctrl.device,
 			 "I/O tag %d (%04x) QID %d timeout, completion polled\n",
 			 req->tag, nvme_cid(req), nvmeq->qid);
+		dev->ctrl.stats.timeouts++;
 		return BLK_EH_DONE;
 	}
 
@@ -1565,6 +1567,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 			 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout, reset controller\n",
 			 req->tag, nvme_cid(req), opcode,
 			 nvme_opcode_str(nvmeq->qid, opcode), nvmeq->qid);
+		dev->ctrl.stats.resets++;
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		goto disable;
 	}
@@ -1584,6 +1587,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 		 req->tag, nvme_cid(req), opcode, nvme_get_opcode_str(opcode),
 		 nvmeq->qid, blk_op_str(req_op(req)), req_op(req),
 		 blk_rq_bytes(req));
+	dev->ctrl.stats.aborts++;
 
 	abort_req = blk_mq_alloc_request(dev->ctrl.admin_q, nvme_req_op(&cmd),
 					 BLK_MQ_REQ_NOWAIT);
@@ -2424,9 +2428,130 @@ static const struct attribute_group nvme_pci_dev_attrs_group = {
 	.is_visible	= nvme_pci_attrs_are_visible,
 };
 
+static ssize_t timeouts_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", ctrl->stats.timeouts);
+}
+
+static ssize_t timeouts_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned long timeouts;
+	int err;
+
+	err = kstrtoul(buf, 10, &timeouts);
+	if (err)
+		return -EINVAL;
+
+	ctrl->stats.timeouts = timeouts;
+
+	return count;
+}
+static DEVICE_ATTR_RW(timeouts);
+
+static ssize_t aborts_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", ctrl->stats.aborts);
+}
+
+static ssize_t aborts_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned long aborts;
+	int err;
+
+	err = kstrtoul(buf, 10, &aborts);
+	if (err)
+		return -EINVAL;
+
+	ctrl->stats.aborts = aborts;
+
+	return count;
+}
+static DEVICE_ATTR_RW(aborts);
+
+static ssize_t resets_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", ctrl->stats.resets);
+}
+
+static ssize_t resets_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned long resets;
+	int err;
+
+	err = kstrtoul(buf, 10, &resets);
+	if (err)
+		return -EINVAL;
+
+	ctrl->stats.resets = resets;
+
+	return count;
+}
+static DEVICE_ATTR_RW(resets);
+
+static ssize_t disables_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", ctrl->stats.disables);
+}
+
+static ssize_t disables_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned long disables;
+	int err;
+
+	err = kstrtoul(buf, 10, &disables);
+	if (err)
+		return -EINVAL;
+
+	ctrl->stats.disables = disables;
+
+	return count;
+}
+static DEVICE_ATTR_RW(disables);
+
+static umode_t nvme_stats_attrs_are_visible(struct kobject *kobj,
+					    struct attribute *a, int n)
+{
+	return a->mode;
+}
+
+static struct attribute *nvme_stats_attrs[] = {
+	&dev_attr_timeouts.attr,
+	&dev_attr_aborts.attr,
+	&dev_attr_resets.attr,
+	&dev_attr_disables.attr,
+	NULL,
+};
+
+static const struct attribute_group nvme_stats_attrs_group = {
+	.name		= "stats",
+	.attrs		= nvme_stats_attrs,
+	.is_visible	= nvme_stats_attrs_are_visible,
+};
+
 static const struct attribute_group *nvme_pci_dev_attr_groups[] = {
 	&nvme_dev_attrs_group,
 	&nvme_pci_dev_attrs_group,
+	&nvme_stats_attrs_group,
 	NULL,
 };
 
@@ -3057,6 +3182,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	dev_warn(dev->ctrl.device, "Disabling device after reset failure: %d\n",
 		 result);
+	dev->ctrl.stats.disables++;
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_dev_disable(dev, true);
 	nvme_sync_queues(&dev->ctrl);
@@ -3593,6 +3719,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_frozen:
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
+		dev->ctrl.stats.resets++;
 		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
 			nvme_dev_disable(dev, true);
 			return PCI_ERS_RESULT_DISCONNECT;
-- 
2.48.1


