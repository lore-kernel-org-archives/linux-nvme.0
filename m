Return-Path: <SRS0=hrUZ=HW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B41C433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 15:40:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136A664ECA
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 15:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136A664ECA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hcR+nZaMSNpc6Upvl2qsGfyDAJNBQ9KUwiSI6cjrvYo=; b=dM4lcObZRlohf0YEfYWVSv1rg6
	vMM1VnG7HzAc429TZtvgIeCKq5aL+aO98hYKHYZRAVR6Zk1TCk0OMlygH8NyrUFP1WnGz4w3ZvVvn
	VRNS7x4VuCUtrSUiiXDyMKrHbNNZ732P60JBgEoPyCX44ErjU9K2BOr0AopmC+S+gFDP/LbbmOcm3
	YHvUBK2oYrMlDH0yhCp326OUoCpRuNZ93RBBKT/mfjdf/M4Xo96ZbJxcXfmJkuj7q+hpt/We4xFc6
	1wa4a79/+xzuibbFL31wdluPTujaOTt7VSH+6bpgGNcThDwlpghCSKlvmwbdM5wUtDLnjzlyGXDpW
	uTDbyrig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDUMg-0007aF-1b; Sat, 20 Feb 2021 15:40:14 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDUMd-0007Zk-JK
 for linux-nvme@lists.infradead.org; Sat, 20 Feb 2021 15:40:12 +0000
Received: by mail-pj1-x1032.google.com with SMTP id s23so2736682pji.1
 for <linux-nvme@lists.infradead.org>; Sat, 20 Feb 2021 07:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ujGPtXK+cDaQi+2X4/RnpDRiqYSQnW1/xXIWcPf9vOg=;
 b=C0GX5+1N4Cfb5oDetHXWaxzXgaIE4qG8OnlsGkXpkFCQBBE2ZK8SpsVrF7UTJaFF3G
 EXxB2rwYFi+q3ByMGNBbyPttJDU+0dFl7OYPGNOcYZN4HD8r+jf+hWSon0nsLXXqfxgo
 qhW3cvDXk6PBlhoeEigkfi5qwFWXoZCEzGycf89CRR4MfgzWvxAA2aPJvRckfgnWaRb8
 KQYehxQKYP54HuW41lFxWSen47ycz+v3Yz+xaqCSil1S0e69THQ8uaTE7M1FItwsFJLW
 PiO90HwuE2laYf0xfqRxz1H+HEvlMKAe3Bo7u3SflKKsuKml+9WSamodlpDgMKS5qmGS
 e7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ujGPtXK+cDaQi+2X4/RnpDRiqYSQnW1/xXIWcPf9vOg=;
 b=TO6IU6KRfauojqfAeFiyKAqdN4g6BVneNPhxahx6wVrQf7+aW6dc4vAkPyamVCiwVd
 jm92Jn3P+L0xke4lLzIlr6p9vGKeXVFqjXRDfa3KsqJesYrUKZXABlOCqs1w06oMbCjD
 XTEfgayE0YXogQ4MGKDHb8doJrxC0+5z6vw5GNi9l8Ku5wgmQb4CJWQ60ZJOfbDqHJWI
 bIbgdWllsxIYYRoBYyhR5GaXeC/XUJ51/0MJTAP9tMhQ224rDazgBDR4xJw7igQiWM/z
 DRPd1pvUss04da3gD+8ZWTp0CkyWd91DJQYc+tMOe57QU5vfTteRq0dwD3KCDYLBsaOF
 ISrw==
X-Gm-Message-State: AOAM532TWN/Q64XbtafA1Zwj68EhFeA/SRi9LE8dsFXoJ8Ai//sGytbg
 U+HHotbA7Zq3vepY16EyBPeLZZ6cmh/BlQ==
X-Google-Smtp-Source: ABdhPJxurk+/gN83UUuOBZNanzfGi/YiOhr5TucbpfpwUMPFRI01ssfbsaJC/sa0rtvDxGQOdVJ1aw==
X-Received: by 2002:a17:902:c144:b029:e3:bbae:dcb4 with SMTP id
 4-20020a170902c144b02900e3bbaedcb4mr6846104plj.59.1613835609139; 
 Sat, 20 Feb 2021 07:40:09 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id z5sm3762303pfk.21.2021.02.20.07.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Feb 2021 07:40:08 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: add support namespace management to sysfs
Date: Sun, 21 Feb 2021 00:40:04 +0900
Message-Id: <20210220154004.242622-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210220_104011_683091_5BD55B63 
X-CRM114-Status: GOOD (  23.57  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Namespaces are generally managed by scan_work.  If admin needs to attach
namespace to controller, admin command like `nvme-cli` should be issued
with rescanning controller.

If admin issues a Namespace Attachment command with detach option to a
namespace through IOCTL, kernel is not aware of it.  In this case, block
device for the namespace becomes meaningless, but still shown in the
kernel space as maintained.  After the rescanning the controller
manually, namespace node will be removed from the driver and user-space
will not be able to I/O to the namespace.

Add support for namespace management (attach/detach) to sysfs of
controller instance to make it easy to attach/detach namespaces with
kernel-aware rather than non-kernel-aware passthru via IOCTL.  Also, it
provides closer relationship between the device and kernel for the
namespace perspective (tightly coupled).

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 161 +++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h     |  12 +++
 2 files changed, 173 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d77f3f26d8d3..62a7e0c6e021 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -92,6 +92,9 @@ static struct class *nvme_subsys_class;
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
+static void nvme_ns_remove(struct nvme_ns *ns);
+static struct nvme_ns *nvme_find_get_ns_by_disk_name(struct nvme_ctrl *ctrl,
+						     const char *disk_name);
 
 /*
  * Prepare a queue for teardown.
@@ -3684,6 +3687,142 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
 	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);
 
+static int __nvme_ns_detach(struct nvme_ctrl *ctrl, unsigned int nsid)
+{
+	struct nvme_command c = { };
+	int err;
+	u16 *buf;
+
+	c.ns_attach.opcode = nvme_admin_ns_attach;
+	c.ns_attach.nsid = cpu_to_le32(nsid);
+	c.ns_attach.sel = cpu_to_le32(0x1);
+
+	buf = kmalloc(4096, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = cpu_to_le32(0x1);
+	buf[1] = cpu_to_le32(ctrl->cntlid);
+
+	err = nvme_submit_sync_cmd(ctrl->admin_q, &c, buf, 4096);
+	if (err) {
+		kfree(buf);
+		return err;
+	}
+
+	kfree(buf);
+	return 0;
+}
+
+static int nvme_ns_detach(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
+{
+	int err;
+
+	blk_mq_quiesce_queue(ns->queue);
+
+	err = __nvme_ns_detach(ctrl, ns->head->ns_id);
+	if (err) {
+		blk_mq_unquiesce_queue(ns->queue);
+		return err;
+	}
+
+	nvme_set_queue_dying(ns);
+	nvme_ns_remove(ns);
+
+	return 0;
+}
+
+static int __nvme_ns_attach(struct nvme_ctrl *ctrl, unsigned int nsid)
+{
+	struct nvme_command c = { };
+	int err;
+	u16 *buf;
+
+	c.ns_attach.opcode = nvme_admin_ns_attach;
+	c.ns_attach.nsid = cpu_to_le32(nsid);
+	c.ns_attach.sel = cpu_to_le32(0x0);
+
+	buf = kmalloc(4096, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = cpu_to_le32(0x1);
+	buf[1] = cpu_to_le32(ctrl->cntlid);
+
+	err = nvme_submit_sync_cmd(ctrl->admin_q, &c, buf, 4096);
+	if (err) {
+		kfree(buf);
+		return err;
+	}
+
+	kfree(buf);
+	return 0;
+}
+
+static int nvme_ns_attach(struct nvme_ctrl *ctrl, unsigned int nsid, bool scan)
+{
+	int err;
+
+	if (!(ctrl->oacs & NVME_CTRL_OACS_NS_MANAGEMENT))
+		return -EOPNOTSUPP;
+
+	err = __nvme_ns_attach(ctrl, nsid);
+	if (err)
+		return err;
+
+	if (scan)
+		nvme_queue_scan(ctrl);
+
+	return 0;
+}
+
+static ssize_t detach_ns_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_ns *ns;
+	int err;
+
+	if (!(ctrl->oacs & NVME_CTRL_OACS_NS_MANAGEMENT))
+		return -EOPNOTSUPP;
+
+	ns = nvme_find_get_ns_by_disk_name(ctrl, buf);
+	if (!ns)
+		return -EINVAL;
+
+	err = nvme_ns_detach(ctrl, ns);
+	if (err) {
+		nvme_put_ns(ns);
+		return err;
+	}
+
+	nvme_put_ns(ns);
+	return count;
+}
+static DEVICE_ATTR_WO(detach_ns);
+
+static ssize_t attach_ns_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int nsid;
+	int err;
+
+	/*
+	 * 'nsid' is device namespace id which is reported by NVMe controller.
+	 */
+	err = kstrtou32(buf, 10, &nsid);
+	if (err)
+		return err;
+
+	err = nvme_ns_attach(ctrl, nsid, true);
+	if (err)
+		return err;
+
+	return count;
+}
+static DEVICE_ATTR_WO(attach_ns);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -3703,6 +3842,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
 	&dev_attr_reconnect_delay.attr,
+	&dev_attr_detach_ns.attr,
+	&dev_attr_attach_ns.attr,
 	NULL
 };
 
@@ -3902,6 +4043,25 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
 
+static struct nvme_ns *nvme_find_get_ns_by_disk_name(struct nvme_ctrl *ctrl,
+		const char *disk_name)
+{
+	struct nvme_ns *ns, *ret = NULL;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (!strcmp(ns->disk->disk_name, disk_name)) {
+			if (!kref_get_unless_zero(&ns->kref))
+				continue;
+			ret = ns;
+			break;
+		}
+	}
+	up_read(&ctrl->namespaces_rwsem);
+
+	return ret;
+}
+
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_ns_ids *ids)
 {
@@ -4751,6 +4911,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_ns_attach) != 64);
 }
 
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b08787cd0881..bc6c2a162bbb 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -322,6 +322,7 @@ enum {
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
+	NVME_CTRL_OACS_NS_MANAGEMENT		= 1 << 3,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
 	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
@@ -1398,6 +1399,16 @@ struct streams_directive_params {
 	__u8	rsvd2[6];
 };
 
+struct nvme_ns_attach {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u32			rsvd2[8];
+	__le32			sel;
+	__u32			rsvd11[5];
+};
+
 struct nvme_command {
 	union {
 		struct nvme_common_command common;
@@ -1421,6 +1432,7 @@ struct nvme_command {
 		struct nvmf_property_get_command prop_get;
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
+		struct nvme_ns_attach ns_attach;
 	};
 };
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
