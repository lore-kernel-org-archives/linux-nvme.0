Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F69C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 10:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=njBm3F4ghZp3I2T2lc9YUf5ew6i+9J0XGP00DaQkz1k=; b=K/jJ1PVzgi/KRhR/ijDNrVnV53
	C6Y3+rvKeswWtmYns7BemD/AiVwNvhKvI9YTVnbfRGURCZyWgbpAgTEITquDsBm00+7Vgw4U5PAGR
	JL1t/A15a0bCi5VWN58PkcLsF+jhTWpX1wg8exJPHWq1HP9V7EersbxOpwLtq0ZgYbhpXs5XvxLxt
	sH/D5/flD5XHBOV30L0s44RrEtOFh98/QGls8cEzfm9QQ3pefF78Gg4edC7kJ7jgSAsMWflobJEQK
	ac3FLF41UfV6kv8dbYLNWPJE+qPjJm728pk9kgLmOC7aVBdjZk4XNP1i3ZtWDrH6yw4mtAb0pqP2l
	DiLXo78w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7YsV-0025Vg-0w;
	Mon, 27 Nov 2023 10:30:11 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7YsR-0025S0-0N
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 10:30:08 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 20A1F202AC;
	Mon, 27 Nov 2023 10:30:03 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CB66132A6;
	Mon, 27 Nov 2023 10:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id N8CeAatvZGXgfwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 27 Nov 2023 10:30:03 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Date: Mon, 27 Nov 2023 11:32:08 +0100
Message-ID: <20231127103208.25748-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 20A1F202AC
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Spamd-Result: default: False [8.27 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 NEURAL_HAM_LONG(-0.32)[-0.317];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_023007_308614_C8B14E09 
X-CRM114-Status: GOOD (  17.14  )
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

libnvme is using the sysfs for enumarating the nvme resources. Though
there are few missing attritbutes in the sysfs. For these libnvme issues
commands during discovering.

As the kernel already knows all these attributes and we would like to
avoid libnvme to issue commands all the time, expose these missing
attributes.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

As discussed during ALPPS, these here are the missing attribures which libnvme
is still looking up via commands. I've tested this with a modified libnvme and
didn't observe any ioctls anymore.

I'm pretty sure the naming is a bit off for the variables. Not really sure if we
want to stick to the spec naming sceme or have our own one, e.g. 'nsze' vs
'capacity'.

Also getting a pointer to the nvme_ns data structure is a bit strange
(dev_to_nvme_ns). This stip is necessary as many of the ns attributes are in
nvme_ns. Shouldn't these per path values not all be the same and thus couldn't
these be in nvme_ns_head? Anyway, just not sure who to deal with this. So any
pointers highly welcomed!

Cheers,
Daniel

 drivers/nvme/host/core.c  |  2 ++
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/sysfs.c | 72 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 80673ea63fea..f100ee241bd7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2029,6 +2029,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
 	ns->lba_shift = id->lbaf[lbaf].ds;
+	ns->nsze = le64_to_cpu(id->nsze);
+	ns->nuse = le64_to_cpu(id->nuse);
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
 	nvme_configure_metadata(ns, id);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..97652bf2c787 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -487,6 +487,8 @@ struct nvme_ns {
 	struct nvme_ns_head *head;
 
 	int lba_shift;
+	u64 nsze;
+	u64 nuse;
 	u16 ms;
 	u16 pi_size;
 	u16 sgs;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 212e1b05d298..b46faee50361 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -114,12 +114,84 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
+static struct nvme_ns *dev_to_nvme_ns(struct device *dev)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	if (disk->fops == &nvme_bdev_ops)
+		return nvme_get_ns_from_dev(dev);
+	else {
+		struct nvme_ns_head *head = disk->private_data;
+		struct nvme_subsystem *subsys = head->subsys;
+		struct nvme_ctrl *ctrl;
+		struct nvme_ns *ns, *ret = NULL;
+
+		list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+			down_read(&ctrl->namespaces_rwsem);
+			list_for_each_entry(ns, &ctrl->namespaces, list) {
+				ret = ns;
+				break;
+			}
+			up_read(&ctrl->namespaces_rwsem);
+		}
+		return ret;
+	}
+}
+
+static ssize_t csi_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ids.csi);
+}
+static DEVICE_ATTR_RO(csi);
+
+static ssize_t lba_ds_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns = dev_to_nvme_ns(dev);
+
+	return sysfs_emit(buf, "%d\n", ns->lba_shift);
+}
+static DEVICE_ATTR_RO(lba_ds);
+
+static ssize_t lba_ms_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns = dev_to_nvme_ns(dev);
+
+	return sysfs_emit(buf, "%d\n", ns->ms);
+}
+static DEVICE_ATTR_RO(lba_ms);
+
+static ssize_t nsze_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns = dev_to_nvme_ns(dev);
+
+	return sysfs_emit(buf, "%llu\n", ns->nsze);
+}
+static DEVICE_ATTR_RO(nsze);
+
+static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns = dev_to_nvme_ns(dev);
+
+	return sysfs_emit(buf, "%llu\n", ns->nuse);
+}
+static DEVICE_ATTR_RO(nuse);
+
 static struct attribute *nvme_ns_id_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
+	&dev_attr_csi.attr,
 	&dev_attr_nsid.attr,
+	&dev_attr_lba_ds.attr,
+	&dev_attr_lba_ms.attr,
+	&dev_attr_nsze.attr,
+	&dev_attr_nuse.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
-- 
2.43.0


