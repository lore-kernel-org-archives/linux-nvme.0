Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3391CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 08:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VdQ8/syqoCr4OgNcEb0+WrnTWGD3glgP++bm4Yv4b2Y=; b=BfDoTobAKfQuwSpO+CLBCWy8E8
	6DGBzm5BD1K7G2X0jqEKAalXButQlji9pUp5Wa9VM7uS/50sk0tfwUYZ9Un//0Fpj+RdsY4w5j/Ts
	IxHpDoMEbtEvOUAFWYtIXBaHvCIGIUvzbnQsIQKL2UVhideY/Ms1UoZZ7vncMmXR1tKdYYF1RjT56
	sYpaAmOTehiSTiRBsPfJtmX14W+ZH0jdjWg/VfrFlkLQnLzJef1JDq3tvXXqWfcYnimmaq7X2EvFs
	zjSRG9arBRblqINTfJGDSt3ASP49lHC8Yi4x5Fg9FPCN4aewQ9Trt3entWS7vaMCDLpZYVOp4YVyG
	6paElmpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiWi8-007H0b-8v; Wed, 12 Oct 2022 08:03:28 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiWi5-007GzC-9g
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 08:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665561805; x=1697097805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lGJNCy53HNUKECV2HHWhqh0zmLk/E4fjQ/BhtIcZCJ8=;
  b=Ti1JPTbu4sm677R5KK+njkpg+YtlHM9gxbzLdZvjQM8pfhGLvTiSL78+
   h6tpABvYJobXXt/BvzGnrCe4UZTJ2QNJOSkbywoFja8tIrl6S//IsruP0
   Fl9gIDvQftUwlI0QBZi5+seC6pedZw9W3f0T0suBXRuhMidc76ZmDpv93
   TwEC46Eldj7Pl60h+ajt8+h20sm065RVUlEWoM03fePsIh8XucNkV6wrq
   i1NwgKQwUqzIzuKKVDVLiOQtNEW5Ws+ZS9ji0QJ/eq822AA/ob4BFm/Lj
   al5NuGBudCaC5r64ikD94VcruDUYyuBo4R/B36u9xZw9vknFHRW3rDzoT
   g==;
X-IronPort-AV: E=Sophos;i="5.95,178,1661788800"; 
   d="scan'208";a="218757244"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2022 16:03:20 +0800
IronPort-SDR: MF9HzdAYV68u4pSubm41iU8zDQCsLMMzWdSB9TCOGIq4Iur/Rk0AhHzwFGQxTCEkq3IXYtwySP
 gmsfxF2YgLeSEETL8xIw54Km1MoeqT/rgC1tOtEWM6+RGCqz3UvMAvk5HxUCQj0cAks0BKXD4t
 QvMU3UROd3tDbPJseXoVt0fOlZnj59ggiKD+JHkloNr8uuYgcp54iqTWMZQ9hdAa1gqzlqvVNB
 KlW1oT21SM+xJOwX94eETFNbzCfL8pf0xDJwolXsFqgQrnbH0Xcs6SSTNFZPNimtZ4glqDSbrC
 f+M9v6jiA1SBjBxYvIuF7wLo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2022 00:23:00 -0700
IronPort-SDR: SLzD2zaIGCtNp20g+gDcscjn6SBjBn2CcN6yuxXAdlJdpBLSU2CdI4R2H3HJZD0HnAzlX8ow+T
 mpKzgOt1etTNkoAKCsnPRAVwt+zoiN7P97/DkHOMt1AAk2TSpJuRq0ox3wmEKM1PShVP3hyds4
 K+JKlc/eYusZNAQnvDuTQwxuaZwDKJQjXjJ2PHwRWSpz8pf7Oy0Y5FZsGqV0tzP0WMDV/95YFt
 qMWCr4xmFNZsa56tpXzK1UQH5fhu1wpJ9p0O8ElH9eBUnqjh7Igx3nVpBtJtwFEm4DVwrBDETf
 YBE=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Oct 2022 01:03:19 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvme: avoid deadlock warning in sync_io_queues() path
Date: Wed, 12 Oct 2022 17:03:18 +0900
Message-Id: <20221012080318.705449-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_010325_396205_1BE1D569 
X-CRM114-Status: GOOD (  17.85  )
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

The commit c0feea594e05 ("workqueue: don't skip lockdep work dependency
in cancel_work_sync()") restored a lockdep check and it triggered
deadlock warning in sync_io_queues() path. This function locks
namespaces_rwsem to traverse namespace list and calls blk_sync_queue()
for each namespace. blk_sync_queue() calls cancel_work_sync() to wait
for nvme_timeout() completion which has paths to lock the
namespaces_rwsem again. Hence, the deadlock warning was reported.

This deadlock is not expected to happen in real use cases since the
queues to call blk_sync_queue() are already quiesced at that point. Left
issue is confusion by the deadlock warning. It is not ideal to suppress
the warning with lockdep_off/on() since it will hide unseen deadlock
scenarios. It is desired to suppress the warning without losing deadlock
detection ability.

Instead of lockdep_off/on(), this patch suppresses the warning by adding
another lock named 'namespaces_sync_io_queues_mutex'. It works together
with namespaces_rwsem. Lock only namespaces_rwsem for fast read access
to the namespaces in hot paths. Lock both the locks to modify the list.
Lock only namespaces_sync_io_queues_mutex to call blk_sync_queue() so
that namespaces_rwsem can be locked in nvme_timeout() without the
deadlock warning.

Link: https://lore.kernel.org/linux-block/20220930001943.zdbvolc3gkekfmcv@shindev/
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++--
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8d5a7ae19844..4c535deaf269 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4234,9 +4234,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (nvme_update_ns_info(ns, info))
 		goto out_unlink_ns;
 
+	mutex_lock(&ctrl->namespaces_sync_io_queues_mutex);
 	down_write(&ctrl->namespaces_rwsem);
 	nvme_ns_add_to_ctrl_list(ns);
 	up_write(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->namespaces_sync_io_queues_mutex);
 	nvme_get_ctrl(ctrl);
 
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups))
@@ -4252,9 +4254,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
  out_cleanup_ns_from_list:
 	nvme_put_ctrl(ctrl);
+	mutex_lock(&ctrl->namespaces_sync_io_queues_mutex);
 	down_write(&ctrl->namespaces_rwsem);
 	list_del_init(&ns->list);
 	up_write(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->namespaces_sync_io_queues_mutex);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
@@ -4304,9 +4308,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
 	del_gendisk(ns->disk);
 
+	mutex_lock(&ns->ctrl->namespaces_sync_io_queues_mutex);
 	down_write(&ns->ctrl->namespaces_rwsem);
 	list_del_init(&ns->list);
 	up_write(&ns->ctrl->namespaces_rwsem);
+	mutex_unlock(&ns->ctrl->namespaces_sync_io_queues_mutex);
 
 	if (last_path)
 		nvme_mpath_shutdown_disk(ns->head);
@@ -4399,12 +4405,14 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
 
+	mutex_lock(&ctrl->namespaces_sync_io_queues_mutex);
 	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
 		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
 			list_move_tail(&ns->list, &rm_list);
 	}
 	up_write(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->namespaces_sync_io_queues_mutex);
 
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
@@ -4565,9 +4573,11 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
+	mutex_lock(&ctrl->namespaces_sync_io_queues_mutex);
 	down_write(&ctrl->namespaces_rwsem);
 	list_splice_init(&ctrl->namespaces, &ns_list);
 	up_write(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->namespaces_sync_io_queues_mutex);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
@@ -4901,6 +4911,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	xa_init(&ctrl->cels);
 	init_rwsem(&ctrl->namespaces_rwsem);
+	mutex_init(&ctrl->namespaces_sync_io_queues_mutex);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
@@ -5121,10 +5132,16 @@ void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
+	/*
+	 * Guard ctrl->namespaces with namespaces_sync_io_queues_mutex instead
+	 * of namespaces_rwsem to avoid deadlock warning. namespace_rwsem lock
+	 * here for cancel_work_sync() via blk_sync_queue() would conflict with
+	 * nvme_timeout() which locks namespaces_rwsem.
+	 */
+	mutex_lock(&ctrl->namespaces_sync_io_queues_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_sync_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->namespaces_sync_io_queues_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_sync_io_queues);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1bdf714dcd9e..3f484b6c21d2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -250,6 +250,7 @@ struct nvme_ctrl {
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
 	struct rw_semaphore namespaces_rwsem;
+	struct mutex namespaces_sync_io_queues_mutex;
 	struct device ctrl_device;
 	struct device *device;	/* char device */
 #ifdef CONFIG_NVME_HWMON
-- 
2.37.1


