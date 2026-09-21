Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE995C982EE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 08:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9/U5YsTQDbEtLCS+m4OMu/MI0ucvMA3OS3vtvMVO/M=; b=HN9IlZ2RqvFpqq7uVqeDqBPMdg
	2FQRWaliQSGSiS6a3B6JcdNP3ER0lv8zHUCAeS8AEw2XYf3xgcgHm4lvlmWP3+/Kac5WKmNVJ9ATa
	gh230jD6nuBt0xlj9IBmdUllzxuMUepm14UFLO1rzb80tt0N244An6fXqSMQu1o3KxytcPLhJC2zF
	Hq8Vt6qZtk53MBhiXt//qQozZztC++rpelK+mLEdO4M0wJDvoGkkEZ8npMi1z34gKaLUd4FkVkSTg
	tjG4IJnWJVb6qmJ3bw2Ocepvi1UBQmVFbsAErphN7cJnmxqfTu5GIz5f/Jo0xHjTi5n6nzqZRBtOC
	FmYFtlhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZXk-00000001McQ-1jd2;
	Mon, 21 Sep 2026 08:38:32 +0000
Received: from out-41.mta1.migadu.com ([2001:41d0:203:375::29] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZXX-00000001MRb-0hbe
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 08:38:22 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=lo+3hYrHbOxtP+yhhzev+iunFmIbTKcxkOK8eO47HeM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789979897; v=1; x=1790584697;
 b=lSXdiOQUnmMvl/VHbFJgzutIS1h8AXdoxa1RXyfLS2I2/jK2YRNtzW9DQV2sq/Qval3XEyfC
 +MMKWmGEmTpvf9cnczjdIbSDdSJkRXMHDsbhMkAV+wk/J7x9bzVneyfWm94M4AcDp3YxNT1ZbHd
 h1ilfnvY667FrgteW/qFAssk=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id 9969d023204782c0;
	Mon, 21 Sep 2026 08:38:17 +0000
X-Mizu-Trace-ID: 9969d023204782c0
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v4 3/4] nvme-multipath: clone head disk partitions to per-path disks
Date: Mon, 21 Sep 2026 09:37:51 +0100
Message-ID: <20260921083752.1154316-4-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921083752.1154316-1-john.garry@linux.dev>
References: <20260921083752.1154316-1-john.garry@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_013819_424969_05A659CF 
X-CRM114-Status: GOOD (  14.30  )
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

To fix diskstats per partition, it is required that the per-path disk
actually has an up-to-date partition table. This partition table would be
a clone of the head disk partition table.

At two points the partition table needs to be updated:
- when the per-path disk is added in nvme_mpath_add_disk()
- for partition table updates to the head disk, add
  nvme_ns_head_disk_changed() to clone the partition table to per-path
  disks

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/nvme/host/multipath.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..e871ad40d893 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -623,6 +623,23 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
 #define nvme_ns_head_report_zones	NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+static void nvme_ns_head_disk_changed(struct gendisk *disk)
+{
+	struct nvme_ns_head *head = disk->private_data;
+	struct nvme_ns *ns;
+	int srcu_idx;
+
+	lockdep_assert_held(&disk->open_mutex);
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
+		if (bdev_clone_partitions(head->disk, ns->disk))
+			clear_bit(NVME_NS_READY, &ns->flags);
+	}
+	srcu_read_unlock(&head->srcu, srcu_idx);
+}
+
 const struct block_device_operations nvme_ns_head_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= nvme_ns_head_submit_bio,
@@ -634,6 +651,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.get_unique_id	= nvme_ns_head_get_unique_id,
 	.report_zones	= nvme_ns_head_report_zones,
 	.pr_ops		= &nvme_pr_ops,
+	.disk_changed_notify	= nvme_ns_head_disk_changed,
 };
 
 static const struct file_operations nvme_ns_head_chr_fops = {
@@ -1360,6 +1378,20 @@ void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns)
 
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
+	struct nvme_ns_head *head = ns->head;
+	int ret;
+
+	if (!head->disk)
+		return;
+
+	mutex_lock(&head->disk->open_mutex);
+	ret = bdev_clone_partitions(head->disk, ns->disk);
+	mutex_unlock(&head->disk->open_mutex);
+	if (ret) {
+		clear_bit(NVME_NS_READY, &ns->flags);
+		return;
+	}
+
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
 		struct nvme_ana_group_desc desc = {
 			.grpid = anagrpid,
-- 
2.43.0


