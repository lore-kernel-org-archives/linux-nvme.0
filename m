Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCDEC5AE59
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WYpiT92YHLYzhFRrhxpyygD3If8meFiLhCvabJQFoOk=; b=V97cbeZAtmb7kiFr6VifNLko0L
	ngXnAH/tZQIH1JisVggMhNVPW0FEr87BPM/8Iilv1xvh29qcyAtXOseVanh35UDX8lAYuOC8fnNZQ
	NUYhlWnwcoMIUmqaPS1mphIGbmhEvyhCZxrFCRP5erozACtM68YU5LwA6Q9SpeMLOClSGv+1psNsy
	+hby1KWhZDf4mCdWubLOIqfc2lskI2olX804z/Zk8NRHEiYFfwHf2d44RVuc9400cbxIe30lGKNxI
	uso07SZbQzJuzDIqI72wWNJLNMLitxgfHtaLP1ugbFfwf2LDg8E7QTu80aYp8x2vlCIcPJjDFLtK1
	jOKGKsCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMTZ3-0000000BHVe-0dVL;
	Tue, 03 Jun 2025 15:28:33 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMSKH-0000000B8ap-0B57
	for linux-nvme@lists.infradead.org;
	Tue, 03 Jun 2025 14:09:14 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso7081296b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jun 2025 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748959752; x=1749564552; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WYpiT92YHLYzhFRrhxpyygD3If8meFiLhCvabJQFoOk=;
        b=gFGOk1dgAVilATNU1VG071QHyzD6x/K3Wbd2V9sB2y8+A4D4oPI2zocWRCUxxWS6Yj
         C3HymaJ3MY1XfyN7g1LMvAWC4G700u3/ItW/DTHnye3udccjG8Y7Yd9X/1qO2sAEIrDs
         fVOGmWPbonhdTuMDwY3exy82niuoeJqU5jzPFt1xis4qmFuXZl3u8RpL/ztXef+p7Pn9
         ZsbudG/Cth+AwHDNkdnypq2cRKJhLM0lEgZfT7YIHCLvdg51xUVv/5I98G0vyOTqJorl
         EvT/LD+dtDH+Ce/O5DJjpL8behMhMpJUZp10kOZ6TIMlVxxHYoy1DEqsMo3CDGy75Hl7
         H7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748959752; x=1749564552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYpiT92YHLYzhFRrhxpyygD3If8meFiLhCvabJQFoOk=;
        b=qDwHIt63NRYE3FBWy3X0NXrclP6kjjLqLj0k1ilAjXvhLF1rTS/WHHgdyV/Nrl/bPm
         oVK95pnkDBxBw7kb/d7ltmftGv+jOR1Ulygcp8kB0mIVfCKJ9hk4kwJYNyEPl8v47jMU
         osYOrNfDK/8gkU7R56L48bM1RpuVtfJEspxpJVrdpQP6/HePc93CxFKdY9fUyowXPoR+
         PzLh0S9u7G3xdHT74+jlfRw1bqsB8dEA4WajL8RMhzjDpNFm6J4rmLkGuk2M/eDJruL9
         TQgksIpXtPJFwRm1ClTMO9iK0wSVUnd0YZViRPz7XSHY6WrQ9nOF7N0S61BMnK+ep/cn
         ytug==
X-Gm-Message-State: AOJu0YyDfUIQ8R+k524O0xTRDJLUzpc3f6+1OkgJn61oFFByMbla69ab
	8h6IcjhQ1v0I3Pcnwr+fgK3SxvHvQHWzWl6c9C4GKTABccLKzvH0bZjXE+b6MQ==
X-Gm-Gg: ASbGncsRyKXARBRuq+f5cxh2+P6+OAFd3Rh/ydiQYdZMXutZpaquvU6N7kxmEUYX8/u
	W9dmfmrN7PTLOQSYb2IRVJ96yi3w/2XJQfj2tA95HTkSSHMgVhiwKrasXEp5GUcjBeLeu5QiHLu
	1SDfKZjcVjoYePq6B2Fr2dicSDRwyENPUk6Ilp9NCG9VhUaUO2Sr0afKQqaUqem44mv1nyZN11Q
	ojtz7ZvGOJyhBiJsA5u3qNAlN0/VutNKm15boKnVHWrAXrgKG8g0TQWIHT+7KhRBRDeJBfS+PW/
	sT+roc035H7L4ZLfUkH5b4C88cjfR7ScF5tR6wqjRnjzknjSQrMqMRbo2661/0VszoZtIImjRdy
	0aJnuuHglQU2JPg==
X-Google-Smtp-Source: AGHT+IGb1TKrSU0O7jkCLV3Q+I/iGcwm2DTDoM3yHk3RXmdYgHUCu7Mz0Qt9joWHtIv8/RNR2Tpfzg==
X-Received: by 2002:a05:6a00:cc5:b0:747:bd3b:eadc with SMTP id d2e1a72fcca58-747c1c65802mr22076794b3a.23.1748959751493;
        Tue, 03 Jun 2025 07:09:11 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:f673:8e3f:62c4:400f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe96481sm9768251b3a.14.2025.06.03.07.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 07:09:11 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v3] nvme-pci: add NVMe controller statistics
Date: Tue,  3 Jun 2025 23:08:35 +0900
Message-ID: <20250603140906.9120-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_070913_102978_EC7FBBC7 
X-CRM114-Status: GOOD (  16.16  )
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
The statistics counters can be used to check the warning behavior cause.
It is for any unstable issue behavior caused on a drive.
There is no performance impact since only counts for the warning cases.
The read-write attributes then user can reset the counter value if needed.
And accumulate the counter value on user application.
But it is also okay for the purpose as not be very long for the lifetime.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
Changes since v2 to v3:
- Update the commit log.

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


