Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09469C48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 02:50:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04E36134F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 02:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04E36134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sApk7e/OZ/4lgudW7myWnnL6Mtp1WV/PECRTj6lOdN0=; b=GEgNOeQ77DaMFD
	4ik5M9IKmX+rKF7hfBRnwMhUa11VUf92CoN69bsEihwsq8eIsVrS941VqGRGGtF7S/HdcmeuhiN3O
	p5ugJ5Dkr+DnBmUPRTH+SZJooTJgUNKXXYXvwUfU8DuQJbbVMNMdMzhrDP/slXCVFKJHeQI9k8lFS
	GswNvl5tgiTfEfk1V5hAUAL6YX3kDTk88KOarhfYp/ay33NjI2milqwhxKTaTVQbUIEC9SlwjPJtW
	3DsClEB4rk4joYWcZqiOyAYFCIMtoElNMOTLLTe5r7D8SIqyKiBTi52/Xoz+WzkXSOR0+wxXXUhLz
	hszObUHmQmrlWiMvcT4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lscfw-00C7Sl-NU; Mon, 14 Jun 2021 02:50:08 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lscfr-00C7Rv-Na
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 02:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623639004; x=1655175004;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UnYzI8MJAq4/u9Z/m0vN9BnMCiO3ouODlwY9EwfSrVA=;
 b=K7TjZU6xHKlgdwMUdaPrFmLlpEua5nqSak9HSpD9TGBCQV+rinKMawCO
 FqUyyzjeHOCZVYyHCjy2cBVA4VAYpTwD+mf/0lRDouLdEa2HFVNXR/Apw
 MyX5dDLMA6wLVsX4XXAMC1713CxlKR6TjzMaVXvcpOdHGVmmolihNkwxO
 3Gz+N9MV+HqGpsfsT61g/aBo6Z1jvSm70/m7eysEczlfGg0M4M+AVxfAV
 5qZlzmZQGGwejMKd0G8lAfBs5earFmvUZGb2n4YIZX8TflBdo9aVe04z1
 bmZnVYCNgK+bDIenq7P9ebLzkUSyJH53ignjAxhrZZOuPJg249F6QpqY8 g==;
IronPort-SDR: GqFELa1CfBFZJd8O0at9kG2ghoKk8LFs6jCekk+vbVeSFbLcr9uayFGxuaWTiErAPBtAX1hq4E
 SEJ2mQin7qRvLiEficbyvvBBh+SVjd5Zvvdocs9hD6dxSXTsRc71EXadt67/V09fFyhGzjcaW/
 Xcea9Tsr0QvoOB6o42ptxXc39IXDyN5Ng6yJJGfbMjrKScaYoBq/AYu5HSLrpEZMBijvavjSe6
 gHFzG++s0kyvCviuKSDTYPJJUkAevzbUF9qEqhoytSMbO4OmaCFOU8flo7vay3UtAZkeb+baCB
 Obw=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; d="scan'208";a="172343644"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 10:50:03 +0800
IronPort-SDR: K1cylyrNE70Ct9oUKncOG2KMb3/zrF49Twt7TCB/53PLANMl4oMYn+P0m7RT3mRiHrpAkOho7t
 ArJHaipOVuIrZXA7CpnRi721nPWLkXW/zyhXzGo3J6NE61pWb6MkHFGRp/WXY2wcw20LLenKl4
 dBNAaR6CQ4qyL71BlWdhIWgdYHTADo7OyDfhkgj8QEV/BlR2Fc4YfhaL1cmnJy+k/efpZyvsfx
 MpMpcsDRKct3v05lSAvE+QADSUy/Yb+kTg9EHyjnA9tkQ3yhOyJACNkvpWR77a8zaOjYVN4UEB
 A+vc3cvTm2wB+4B83x2ecyPX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 19:27:33 -0700
IronPort-SDR: ZnF71v1bOYCZGU5gCnVPySee1uT2nERnMJVijsWe4HlAuC9gGScMABaNWarcKBw5XdcTfbHlXG
 AmNdcZyFvp9hRtDLvNKt2WuUeFXWzcAvsqbbdB9pahwmER73xtEPWat02hcaB3WFhVtuDi7/5F
 WZvhn4YWeUZMbakvGObAeDlVUqDcRkMfHW7htoh8izM4DGBIQMHeWcKi0J3TpCRF0zo4t0rnfP
 8rs9QtxLVRTnFIvt9XN9xQSI1UWCR3Hshv5gtoEVmHlrA4+BnCptw/9parrtsGUZNaSifidbea
 gpk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jun 2021 19:50:02 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH RFC] nvme: move sysfs code into separate file
Date: Sun, 13 Jun 2021 19:49:59 -0700
Message-Id: <20210614024959.11925-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_195003_974686_347837A7 
X-CRM114-Status: GOOD (  19.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Move sysfs related code into it's separate file since to trim down the
host/core.c.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/Makefile |   2 +-
 drivers/nvme/host/core.c   | 440 +-----------------------------------
 drivers/nvme/host/nvme.h   |   4 +
 drivers/nvme/host/sysfs.c  | 441 +++++++++++++++++++++++++++++++++++++
 4 files changed, 449 insertions(+), 438 deletions(-)
 create mode 100644 drivers/nvme/host/sysfs.c

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index cbc509784b2e..a89f15194082 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
 obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 
-nvme-core-y				:= core.o ioctl.o
+nvme-core-y				:= core.o ioctl.o sysfs.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb1a76a3d42a..42945af7059c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -217,7 +217,7 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
-static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
+void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
 {
 	dev_info(ctrl->device,
 		 "Removing ctrl: NQN \"%s\"\n", ctrl->opts->subsysnqn);
@@ -247,18 +247,6 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_delete_ctrl);
 
-static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
-{
-	/*
-	 * Keep a reference until nvme_do_delete_ctrl() complete,
-	 * since ->delete_ctrl can free the controller.
-	 */
-	nvme_get_ctrl(ctrl);
-	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
-		nvme_do_delete_ctrl(ctrl);
-	nvme_put_ctrl(ctrl);
-}
-
 static blk_status_t nvme_error_status(u16 status)
 {
 	switch (status & 0x7ff) {
@@ -2073,7 +2061,7 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
 #define nvme_report_zones	NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 
-static const struct block_device_operations nvme_bdev_ops = {
+const struct block_device_operations nvme_bdev_ops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
 	.open		= nvme_open,
@@ -3078,428 +3066,6 @@ static const struct file_operations nvme_dev_fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 };
 
-static ssize_t nvme_sysfs_reset(struct device *dev,
-				struct device_attribute *attr, const char *buf,
-				size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	int ret;
-
-	ret = nvme_reset_ctrl_sync(ctrl);
-	if (ret < 0)
-		return ret;
-	return count;
-}
-static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
-
-static ssize_t nvme_sysfs_rescan(struct device *dev,
-				struct device_attribute *attr, const char *buf,
-				size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	nvme_queue_scan(ctrl);
-	return count;
-}
-static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
-
-static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
-{
-	struct gendisk *disk = dev_to_disk(dev);
-
-	if (disk->fops == &nvme_bdev_ops)
-		return nvme_get_ns_from_dev(dev)->head;
-	else
-		return disk->private_data;
-}
-
-static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct nvme_ns_head *head = dev_to_ns_head(dev);
-	struct nvme_ns_ids *ids = &head->ids;
-	struct nvme_subsystem *subsys = head->subsys;
-	int serial_len = sizeof(subsys->serial);
-	int model_len = sizeof(subsys->model);
-
-	if (!uuid_is_null(&ids->uuid))
-		return sysfs_emit(buf, "uuid.%pU\n", &ids->uuid);
-
-	if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
-		return sysfs_emit(buf, "eui.%16phN\n", ids->nguid);
-
-	if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
-		return sysfs_emit(buf, "eui.%8phN\n", ids->eui64);
-
-	while (serial_len > 0 && (subsys->serial[serial_len - 1] == ' ' ||
-				  subsys->serial[serial_len - 1] == '\0'))
-		serial_len--;
-	while (model_len > 0 && (subsys->model[model_len - 1] == ' ' ||
-				 subsys->model[model_len - 1] == '\0'))
-		model_len--;
-
-	return sysfs_emit(buf, "nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id,
-		serial_len, subsys->serial, model_len, subsys->model,
-		head->ns_id);
-}
-static DEVICE_ATTR_RO(wwid);
-
-static ssize_t nguid_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	return sysfs_emit(buf, "%pU\n", dev_to_ns_head(dev)->ids.nguid);
-}
-static DEVICE_ATTR_RO(nguid);
-
-static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
-
-	/* For backward compatibility expose the NGUID to userspace if
-	 * we have no UUID set
-	 */
-	if (uuid_is_null(&ids->uuid)) {
-		printk_ratelimited(KERN_WARNING
-				   "No UUID available providing old NGUID\n");
-		return sysfs_emit(buf, "%pU\n", ids->nguid);
-	}
-	return sysfs_emit(buf, "%pU\n", &ids->uuid);
-}
-static DEVICE_ATTR_RO(uuid);
-
-static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	return sysfs_emit(buf, "%8ph\n", dev_to_ns_head(dev)->ids.eui64);
-}
-static DEVICE_ATTR_RO(eui);
-
-static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ns_id);
-}
-static DEVICE_ATTR_RO(nsid);
-
-static struct attribute *nvme_ns_id_attrs[] = {
-	&dev_attr_wwid.attr,
-	&dev_attr_uuid.attr,
-	&dev_attr_nguid.attr,
-	&dev_attr_eui.attr,
-	&dev_attr_nsid.attr,
-#ifdef CONFIG_NVME_MULTIPATH
-	&dev_attr_ana_grpid.attr,
-	&dev_attr_ana_state.attr,
-#endif
-	NULL,
-};
-
-static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
-		struct attribute *a, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
-
-	if (a == &dev_attr_uuid.attr) {
-		if (uuid_is_null(&ids->uuid) &&
-		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
-			return 0;
-	}
-	if (a == &dev_attr_nguid.attr) {
-		if (!memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
-			return 0;
-	}
-	if (a == &dev_attr_eui.attr) {
-		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
-			return 0;
-	}
-#ifdef CONFIG_NVME_MULTIPATH
-	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
-		if (dev_to_disk(dev)->fops != &nvme_bdev_ops) /* per-path attr */
-			return 0;
-		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
-			return 0;
-	}
-#endif
-	return a->mode;
-}
-
-static const struct attribute_group nvme_ns_id_attr_group = {
-	.attrs		= nvme_ns_id_attrs,
-	.is_visible	= nvme_ns_id_attrs_are_visible,
-};
-
-const struct attribute_group *nvme_ns_id_attr_groups[] = {
-	&nvme_ns_id_attr_group,
-#ifdef CONFIG_NVM
-	&nvme_nvm_attr_group,
-#endif
-	NULL,
-};
-
-#define nvme_show_str_function(field)						\
-static ssize_t  field##_show(struct device *dev,				\
-			    struct device_attribute *attr, char *buf)		\
-{										\
-        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
-        return sysfs_emit(buf, "%.*s\n",					\
-		(int)sizeof(ctrl->subsys->field), ctrl->subsys->field);		\
-}										\
-static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
-
-nvme_show_str_function(model);
-nvme_show_str_function(serial);
-nvme_show_str_function(firmware_rev);
-
-#define nvme_show_int_function(field)						\
-static ssize_t  field##_show(struct device *dev,				\
-			    struct device_attribute *attr, char *buf)		\
-{										\
-        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
-        return sysfs_emit(buf, "%d\n", ctrl->field);				\
-}										\
-static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
-
-nvme_show_int_function(cntlid);
-nvme_show_int_function(numa_node);
-nvme_show_int_function(queue_count);
-nvme_show_int_function(sqsize);
-nvme_show_int_function(kato);
-
-static ssize_t nvme_sysfs_delete(struct device *dev,
-				struct device_attribute *attr, const char *buf,
-				size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (device_remove_file_self(dev, attr))
-		nvme_delete_ctrl_sync(ctrl);
-	return count;
-}
-static DEVICE_ATTR(delete_controller, S_IWUSR, NULL, nvme_sysfs_delete);
-
-static ssize_t nvme_sysfs_show_transport(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%s\n", ctrl->ops->name);
-}
-static DEVICE_ATTR(transport, S_IRUGO, nvme_sysfs_show_transport, NULL);
-
-static ssize_t nvme_sysfs_show_state(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	static const char *const state_name[] = {
-		[NVME_CTRL_NEW]		= "new",
-		[NVME_CTRL_LIVE]	= "live",
-		[NVME_CTRL_RESETTING]	= "resetting",
-		[NVME_CTRL_CONNECTING]	= "connecting",
-		[NVME_CTRL_DELETING]	= "deleting",
-		[NVME_CTRL_DELETING_NOIO]= "deleting (no IO)",
-		[NVME_CTRL_DEAD]	= "dead",
-	};
-
-	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
-	    state_name[ctrl->state])
-		return sysfs_emit(buf, "%s\n", state_name[ctrl->state]);
-
-	return sysfs_emit(buf, "unknown state\n");
-}
-
-static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
-
-static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%s\n", ctrl->subsys->subnqn);
-}
-static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
-
-static ssize_t nvme_sysfs_show_hostnqn(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%s\n", ctrl->opts->host->nqn);
-}
-static DEVICE_ATTR(hostnqn, S_IRUGO, nvme_sysfs_show_hostnqn, NULL);
-
-static ssize_t nvme_sysfs_show_hostid(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%pU\n", &ctrl->opts->host->id);
-}
-static DEVICE_ATTR(hostid, S_IRUGO, nvme_sysfs_show_hostid, NULL);
-
-static ssize_t nvme_sysfs_show_address(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return ctrl->ops->get_address(ctrl, buf, PAGE_SIZE);
-}
-static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
-
-static ssize_t nvme_ctrl_loss_tmo_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-
-	if (ctrl->opts->max_reconnects == -1)
-		return sysfs_emit(buf, "off\n");
-	return sysfs_emit(buf, "%d\n",
-			  opts->max_reconnects * opts->reconnect_delay);
-}
-
-static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-	int ctrl_loss_tmo, err;
-
-	err = kstrtoint(buf, 10, &ctrl_loss_tmo);
-	if (err)
-		return -EINVAL;
-
-	if (ctrl_loss_tmo < 0)
-		opts->max_reconnects = -1;
-	else
-		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
-						opts->reconnect_delay);
-	return count;
-}
-static DEVICE_ATTR(ctrl_loss_tmo, S_IRUGO | S_IWUSR,
-	nvme_ctrl_loss_tmo_show, nvme_ctrl_loss_tmo_store);
-
-static ssize_t nvme_ctrl_reconnect_delay_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (ctrl->opts->reconnect_delay == -1)
-		return sysfs_emit(buf, "off\n");
-	return sysfs_emit(buf, "%d\n", ctrl->opts->reconnect_delay);
-}
-
-static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	unsigned int v;
-	int err;
-
-	err = kstrtou32(buf, 10, &v);
-	if (err)
-		return err;
-
-	ctrl->opts->reconnect_delay = v;
-	return count;
-}
-static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
-	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);
-
-static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (ctrl->opts->fast_io_fail_tmo == -1)
-		return sysfs_emit(buf, "off\n");
-	return sysfs_emit(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
-}
-
-static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-	int fast_io_fail_tmo, err;
-
-	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
-	if (err)
-		return -EINVAL;
-
-	if (fast_io_fail_tmo < 0)
-		opts->fast_io_fail_tmo = -1;
-	else
-		opts->fast_io_fail_tmo = fast_io_fail_tmo;
-	return count;
-}
-static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
-	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
-
-static struct attribute *nvme_dev_attrs[] = {
-	&dev_attr_reset_controller.attr,
-	&dev_attr_rescan_controller.attr,
-	&dev_attr_model.attr,
-	&dev_attr_serial.attr,
-	&dev_attr_firmware_rev.attr,
-	&dev_attr_cntlid.attr,
-	&dev_attr_delete_controller.attr,
-	&dev_attr_transport.attr,
-	&dev_attr_subsysnqn.attr,
-	&dev_attr_address.attr,
-	&dev_attr_state.attr,
-	&dev_attr_numa_node.attr,
-	&dev_attr_queue_count.attr,
-	&dev_attr_sqsize.attr,
-	&dev_attr_hostnqn.attr,
-	&dev_attr_hostid.attr,
-	&dev_attr_ctrl_loss_tmo.attr,
-	&dev_attr_reconnect_delay.attr,
-	&dev_attr_fast_io_fail_tmo.attr,
-	&dev_attr_kato.attr,
-	NULL
-};
-
-static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
-		struct attribute *a, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (a == &dev_attr_delete_controller.attr && !ctrl->ops->delete_ctrl)
-		return 0;
-	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
-		return 0;
-	if (a == &dev_attr_hostnqn.attr && !ctrl->opts)
-		return 0;
-	if (a == &dev_attr_hostid.attr && !ctrl->opts)
-		return 0;
-	if (a == &dev_attr_ctrl_loss_tmo.attr && !ctrl->opts)
-		return 0;
-	if (a == &dev_attr_reconnect_delay.attr && !ctrl->opts)
-		return 0;
-	if (a == &dev_attr_fast_io_fail_tmo.attr && !ctrl->opts)
-		return 0;
-
-	return a->mode;
-}
-
-static const struct attribute_group nvme_dev_attrs_group = {
-	.attrs		= nvme_dev_attrs,
-	.is_visible	= nvme_dev_attrs_are_visible,
-};
-
-static const struct attribute_group *nvme_dev_attr_groups[] = {
-	&nvme_dev_attrs_group,
-	NULL,
-};
 
 static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
 		unsigned nsid)
@@ -4417,7 +3983,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 			ctrl->instance);
 	ctrl->device->class = nvme_class;
 	ctrl->device->parent = ctrl->dev;
-	ctrl->device->groups = nvme_dev_attr_groups;
+	ctrl->device->groups = nvme_get_device_attr_groups();
 	ctrl->device->release = nvme_free_ctrl;
 	dev_set_drvdata(ctrl->device, ctrl);
 	ret = dev_set_name(ctrl->device, "nvme%d", ctrl->instance);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1f397ecba16c..cc8052a6c196 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -36,6 +36,9 @@ extern unsigned int admin_timeout;
 #define  NVME_INLINE_METADATA_SG_CNT  1
 #endif
 
+const struct attribute_group **nvme_get_device_attr_groups(void);
+extern const struct block_device_operations nvme_bdev_ops;
+
 /*
  * Default to a 4K page size, with the intention to update this
  * path in the future to accommodate architectures with differing
@@ -670,6 +673,7 @@ void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
+void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
new file mode 100644
index 000000000000..9cb46012bfa3
--- /dev/null
+++ b/drivers/nvme/host/sysfs.c
@@ -0,0 +1,441 @@
+#include "nvme.h"
+#include "fabrics.h"
+
+static ssize_t nvme_sysfs_reset(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int ret;
+
+	ret = nvme_reset_ctrl_sync(ctrl);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
+
+static ssize_t nvme_sysfs_rescan(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	nvme_queue_scan(ctrl);
+	return count;
+}
+static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
+
+static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	if (disk->fops == &nvme_bdev_ops)
+		return nvme_get_ns_from_dev(dev)->head;
+	else
+		return disk->private_data;
+}
+
+static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+	struct nvme_ns_ids *ids = &head->ids;
+	struct nvme_subsystem *subsys = head->subsys;
+	int serial_len = sizeof(subsys->serial);
+	int model_len = sizeof(subsys->model);
+
+	if (!uuid_is_null(&ids->uuid))
+		return sysfs_emit(buf, "uuid.%pU\n", &ids->uuid);
+
+	if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
+		return sysfs_emit(buf, "eui.%16phN\n", ids->nguid);
+
+	if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
+		return sysfs_emit(buf, "eui.%8phN\n", ids->eui64);
+
+	while (serial_len > 0 && (subsys->serial[serial_len - 1] == ' ' ||
+				  subsys->serial[serial_len - 1] == '\0'))
+		serial_len--;
+	while (model_len > 0 && (subsys->model[model_len - 1] == ' ' ||
+				 subsys->model[model_len - 1] == '\0'))
+		model_len--;
+
+	return sysfs_emit(buf, "nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id,
+		serial_len, subsys->serial, model_len, subsys->model,
+		head->ns_id);
+}
+static DEVICE_ATTR_RO(wwid);
+
+static ssize_t nguid_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sysfs_emit(buf, "%pU\n", dev_to_ns_head(dev)->ids.nguid);
+}
+static DEVICE_ATTR_RO(nguid);
+
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
+
+	/*
+	 * For backward compatibility expose the NGUID to userspace if
+	 * we have no UUID set
+	 */
+	if (uuid_is_null(&ids->uuid)) {
+		printk_ratelimited(KERN_WARNING
+				   "No UUID available providing old NGUID\n");
+		return sysfs_emit(buf, "%pU\n", ids->nguid);
+	}
+	return sysfs_emit(buf, "%pU\n", &ids->uuid);
+}
+static DEVICE_ATTR_RO(uuid);
+
+static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sysfs_emit(buf, "%8ph\n", dev_to_ns_head(dev)->ids.eui64);
+}
+static DEVICE_ATTR_RO(eui);
+
+static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ns_id);
+}
+static DEVICE_ATTR_RO(nsid);
+
+static struct attribute *nvme_ns_id_attrs[] = {
+	&dev_attr_wwid.attr,
+	&dev_attr_uuid.attr,
+	&dev_attr_nguid.attr,
+	&dev_attr_eui.attr,
+	&dev_attr_nsid.attr,
+#ifdef CONFIG_NVME_MULTIPATH
+	&dev_attr_ana_grpid.attr,
+	&dev_attr_ana_state.attr,
+#endif
+	NULL,
+};
+
+static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
+
+	if (a == &dev_attr_uuid.attr) {
+		if (uuid_is_null(&ids->uuid) &&
+		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
+			return 0;
+	}
+	if (a == &dev_attr_nguid.attr) {
+		if (!memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
+			return 0;
+	}
+	if (a == &dev_attr_eui.attr) {
+		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
+			return 0;
+	}
+#ifdef CONFIG_NVME_MULTIPATH
+	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
+		if (dev_to_disk(dev)->fops != &nvme_bdev_ops) /* per-path attr */
+			return 0;
+		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
+			return 0;
+	}
+#endif
+	return a->mode;
+}
+
+static const struct attribute_group nvme_ns_id_attr_group = {
+	.attrs		= nvme_ns_id_attrs,
+	.is_visible	= nvme_ns_id_attrs_are_visible,
+};
+
+const struct attribute_group *nvme_ns_id_attr_groups[] = {
+	&nvme_ns_id_attr_group,
+#ifdef CONFIG_NVM
+	&nvme_nvm_attr_group,
+#endif
+	NULL,
+};
+
+#define nvme_show_str_function(field)						\
+static ssize_t  field##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)		\
+{										\
+        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
+        return sysfs_emit(buf, "%.*s\n",					\
+		(int)sizeof(ctrl->subsys->field), ctrl->subsys->field);		\
+}										\
+static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
+
+nvme_show_str_function(model);
+nvme_show_str_function(serial);
+nvme_show_str_function(firmware_rev);
+
+#define nvme_show_int_function(field)						\
+static ssize_t  field##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)		\
+{										\
+        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
+        return sysfs_emit(buf, "%d\n", ctrl->field);				\
+}										\
+static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
+
+nvme_show_int_function(cntlid);
+nvme_show_int_function(numa_node);
+nvme_show_int_function(queue_count);
+nvme_show_int_function(sqsize);
+nvme_show_int_function(kato);
+
+static ssize_t nvme_sysfs_delete(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (device_remove_file_self(dev, attr)) {
+
+		/*
+		 * Keep a reference until nvme_do_delete_ctrl() complete,
+		 * since ->delete_ctrl can free the controller. This deletes
+		 * ctrl synchronously.
+		 */
+		nvme_get_ctrl(ctrl);
+		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
+			nvme_do_delete_ctrl(ctrl);
+		nvme_put_ctrl(ctrl);
+	}
+	return count;
+}
+static DEVICE_ATTR(delete_controller, S_IWUSR, NULL, nvme_sysfs_delete);
+
+static ssize_t nvme_sysfs_show_transport(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", ctrl->ops->name);
+}
+static DEVICE_ATTR(transport, S_IRUGO, nvme_sysfs_show_transport, NULL);
+
+static ssize_t nvme_sysfs_show_state(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	static const char *const state_name[] = {
+		[NVME_CTRL_NEW]		= "new",
+		[NVME_CTRL_LIVE]	= "live",
+		[NVME_CTRL_RESETTING]	= "resetting",
+		[NVME_CTRL_CONNECTING]	= "connecting",
+		[NVME_CTRL_DELETING]	= "deleting",
+		[NVME_CTRL_DELETING_NOIO]= "deleting (no IO)",
+		[NVME_CTRL_DEAD]	= "dead",
+	};
+
+	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
+	    state_name[ctrl->state])
+		return sysfs_emit(buf, "%s\n", state_name[ctrl->state]);
+
+	return sysfs_emit(buf, "unknown state\n");
+}
+
+static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
+
+static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", ctrl->subsys->subnqn);
+}
+static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
+
+static ssize_t nvme_sysfs_show_hostnqn(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", ctrl->opts->host->nqn);
+}
+static DEVICE_ATTR(hostnqn, S_IRUGO, nvme_sysfs_show_hostnqn, NULL);
+
+static ssize_t nvme_sysfs_show_hostid(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%pU\n", &ctrl->opts->host->id);
+}
+static DEVICE_ATTR(hostid, S_IRUGO, nvme_sysfs_show_hostid, NULL);
+
+static ssize_t nvme_sysfs_show_address(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return ctrl->ops->get_address(ctrl, buf, PAGE_SIZE);
+}
+static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
+
+static ssize_t nvme_ctrl_loss_tmo_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+
+	if (ctrl->opts->max_reconnects == -1)
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n",
+			  opts->max_reconnects * opts->reconnect_delay);
+}
+
+static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	int ctrl_loss_tmo, err;
+
+	err = kstrtoint(buf, 10, &ctrl_loss_tmo);
+	if (err)
+		return -EINVAL;
+
+	if (ctrl_loss_tmo < 0)
+		opts->max_reconnects = -1;
+	else
+		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
+						opts->reconnect_delay);
+	return count;
+}
+static DEVICE_ATTR(ctrl_loss_tmo, S_IRUGO | S_IWUSR,
+	nvme_ctrl_loss_tmo_show, nvme_ctrl_loss_tmo_store);
+
+static ssize_t nvme_ctrl_reconnect_delay_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->opts->reconnect_delay == -1)
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n", ctrl->opts->reconnect_delay);
+}
+
+static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int v;
+	int err;
+
+	err = kstrtou32(buf, 10, &v);
+	if (err)
+		return err;
+
+	ctrl->opts->reconnect_delay = v;
+	return count;
+}
+static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
+	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);
+
+static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->opts->fast_io_fail_tmo == -1)
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
+}
+
+static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	int fast_io_fail_tmo, err;
+
+	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
+	if (err)
+		return -EINVAL;
+
+	if (fast_io_fail_tmo < 0)
+		opts->fast_io_fail_tmo = -1;
+	else
+		opts->fast_io_fail_tmo = fast_io_fail_tmo;
+	return count;
+}
+static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
+	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
+
+static struct attribute *nvme_dev_attrs[] = {
+	&dev_attr_reset_controller.attr,
+	&dev_attr_rescan_controller.attr,
+	&dev_attr_model.attr,
+	&dev_attr_serial.attr,
+	&dev_attr_firmware_rev.attr,
+	&dev_attr_cntlid.attr,
+	&dev_attr_delete_controller.attr,
+	&dev_attr_transport.attr,
+	&dev_attr_subsysnqn.attr,
+	&dev_attr_address.attr,
+	&dev_attr_state.attr,
+	&dev_attr_numa_node.attr,
+	&dev_attr_queue_count.attr,
+	&dev_attr_sqsize.attr,
+	&dev_attr_hostnqn.attr,
+	&dev_attr_hostid.attr,
+	&dev_attr_ctrl_loss_tmo.attr,
+	&dev_attr_reconnect_delay.attr,
+	&dev_attr_fast_io_fail_tmo.attr,
+	&dev_attr_kato.attr,
+	NULL
+};
+
+static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (a == &dev_attr_delete_controller.attr && !ctrl->ops->delete_ctrl)
+		return 0;
+	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
+		return 0;
+	if (a == &dev_attr_hostnqn.attr && !ctrl->opts)
+		return 0;
+	if (a == &dev_attr_hostid.attr && !ctrl->opts)
+		return 0;
+	if (a == &dev_attr_ctrl_loss_tmo.attr && !ctrl->opts)
+		return 0;
+	if (a == &dev_attr_reconnect_delay.attr && !ctrl->opts)
+		return 0;
+	if (a == &dev_attr_fast_io_fail_tmo.attr && !ctrl->opts)
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group nvme_dev_attrs_group = {
+	.attrs		= nvme_dev_attrs,
+	.is_visible	= nvme_dev_attrs_are_visible,
+};
+
+static const struct attribute_group *nvme_dev_attr_groups[] = {
+	&nvme_dev_attrs_group,
+	NULL,
+};
+
+const struct attribute_group **nvme_get_device_attr_groups(void)
+{
+	return nvme_dev_attr_groups;
+}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
