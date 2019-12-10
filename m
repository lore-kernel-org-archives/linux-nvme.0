Return-Path: <SRS0=hdrt=2A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699EDC3F68F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 06:26:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FA0206E0
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 06:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oZZ7DNVE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lFOzniaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FA0206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hHl7Sr9kQuJCoJSwmqwxybQIbsQIy7fsDJ35a4uk4+U=; b=oZZ7DNVEvg/u5z
	jPPr/bPArvrNsKO/ZXYYwqEO0u2fnoJZdWHQ96JXgFyz02BFfU5GRd80Kp0a6Tqm47JHrIRdn5rJA
	itEcGPsWxwWYeXE+iZV6E/H9WOti6vljQmMnrfs1ZT+AGpLOMKjcV3hZqPuWm7s4fiol3yxNA3m8n
	y8Ku3xloxI9MDTxlcK1DpubdxwJBeCa4x53HQUGt+X4HGWXCyd+mpnZarcLwpr/otccfVdRQe6mWs
	pU2pDVWm94Gp2z966LOcc3gKPSuoIn015kcoYURKLxlbt4/ATRk8/7RVFKKKaT/Gogfqnnx/CDvpb
	WY8K4DQLng6QU+gptTpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ieYyK-0000be-0E; Tue, 10 Dec 2019 06:26:12 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieYyF-0000Yl-7u
 for linux-nvme@lists.infradead.org; Tue, 10 Dec 2019 06:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575959168; x=1607495168;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tlDRbrda+dhWpz6y+AoZpO4zrLfIXp9T6pJOriZjp/A=;
 b=lFOzniaI7fIj4JYSmuWWKAM7KOo6Pf8h5Tz8Cz0bJxYkqu9MxNBGbnBI
 QEy838QAp2FxCsayj9MK2ARwRLHMwl8cp+guqyzSvi6upxfikmN7QBsnv
 ++R0fiYVbgEUjJo3baOsIno/FqhY5J7qJGxWygrIQHzstfA1HCXaUCmep
 HzLtmphQB55Wtw4GQ8TWoF4XaBs4n8bludNq/5nzo2TeswtJ4Ep2s9lxo
 5ByQeUp1iv/9yS7d1TJFgNrcL6b6PQNkEZRPXxdYS5bDkxGX4K4YgjtEE
 9BXZfqUm98h3FkQ30qh3QcLQmFDOSAlFUzRIFbPO7LpHgQLzCvNkN0bAL w==;
IronPort-SDR: UxpD2Ce00RghKfc++zN3SxEfEv0e/zKRdmebcgeXjCojl3Nib7JIGH804unNXMSyiLMTId17Mj
 7PmhjJgX++delr/+M7JGoXgPy5aL5iEMWMpk1FHqgfDIPN4Amxu8CdnVM1Pv/+SSzOESm+lTXK
 r8e3ACbAoK7MfKk7xZvAG1LFDqf+KOgutlNNmdGer3gftt3mWEpShUVMils+3PYDh0VctbXjDL
 kZTf1T76PYKlymyg18S2a+JQQTTjchj74IXpxJSZILTko6qgf+udkrv/cAo7lvM/a3POJGkfLr
 2fs=
X-IronPort-AV: E=Sophos;i="5.69,298,1571673600"; d="scan'208";a="125753999"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 14:26:06 +0800
IronPort-SDR: /r9QjjHnvqWOFNbTTkCcnL7mlpY40MHYfHMV2A1s/rfHL4NxO79Fd9zEi1XUj86YwthGhWVSeA
 2UaOw2Zrcu/NthKJcVGbs0ofGDcBptK99rttatWxxRvSJBoLtjYJsSQsdfNdMSG6xS7DPZ06YP
 XuyUgb9W+fK0dzuKc540u4P/D7wJSDJgNJlTae6EO0F5gY9qxnZsokxd93vi47324Jei8t17Jc
 o9OdaqSOYlU8Q0Q5asXpSBtg166VVkxGmO0pAvRyjg28ON9+O+Dz919sWObZ9nawIVACK7SXF9
 Ljz21f7wM9Hl6kiAKv1enQhT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 22:20:21 -0800
IronPort-SDR: INCey8eiocUfgCd/VOAgu49fFjti4QRA+TR288Ub+658CZhTDg805WlQDZNabgm5Kq3WYjQNkY
 +SfaP4qNEyjLp2Ll6/7kjF9dx9k3jHEsyoSMtGup+GlghpvJ7aMhSwZdNjaC6B2vHIjfWi36uv
 XkQPMV6CAidl6V5mDkNqMWnTzKu6mhzJQDsQd2rylQ4CDfxq6ZntZ/z6Js9WJ9D1cc57LUNRT/
 WsHxNISf6B0oKe2xh7+yN4HdBB393eULdjbtkOyOuq8/LYKGtjLH0VIZNqjQ3hdq9VEys+1hOC
 8gc=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 22:26:05 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: sagi@grimberg.me,
	hch@lst.de
Subject: [RFC PATCH 1/2] nvmet: add bdev-ns polling support
Date: Mon,  9 Dec 2019 22:25:56 -0800
Message-Id: <20191210062557.5171-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191210062557.5171-1-chaitanya.kulkarni@wdc.com>
References: <20191210062557.5171-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191209_222607_288671_C08EA5EA 
X-CRM114-Status: GOOD (  21.64  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds support for the bdev-ns polling. We also add a new
file to keep polling code separate (io-poll.c). The newly added
configfs attribute allows user to enable/disable polling.

We only enable polling for the READ/WRITE operation based on support
from bdev and and use_poll configfs attr.

We configure polling per namespace. For each namespace we create
polling threads. For general approach please have a look at the
cover-letter of this patch-series.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/Makefile      |   3 +-
 drivers/nvme/target/configfs.c    |  29 ++++++
 drivers/nvme/target/core.c        |  13 +++
 drivers/nvme/target/io-cmd-bdev.c |  61 +++++++++--
 drivers/nvme/target/io-poll.c     | 165 ++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h       |  31 +++++-
 6 files changed, 291 insertions(+), 11 deletions(-)
 create mode 100644 drivers/nvme/target/io-poll.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 2b33836f3d3e..8877ba16305c 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -10,7 +10,8 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
 obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o
+			discovery.o io-cmd-file.o io-cmd-bdev.o \
+			io-poll.o
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
 nvmet-fc-y	+= fc.o
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..0e6e8b0dbf79 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -545,6 +545,34 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, buffered_io);
 
+static ssize_t nvmet_ns_use_poll_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_ns(item)->use_poll);
+}
+
+static ssize_t nvmet_ns_use_poll_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool val;
+
+	if (strtobool(page, &val))
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("disable ns before setting use_poll value.\n");
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+
+	ns->use_poll = val;
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, use_poll);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
@@ -552,6 +580,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_ana_grpid,
 	&nvmet_ns_attr_enable,
 	&nvmet_ns_attr_buffered_io,
+	&nvmet_ns_attr_use_poll,
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..d8f9130d1cd1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -510,6 +510,18 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 		ns->nsid);
 }
 
+inline void nvmet_req_done(struct nvmet_req *req)
+{
+	if (req->ns->bdev)
+		nvmet_bdev_req_complete(req);
+}
+
+inline void nvmet_req_poll_complete(struct nvmet_req *req)
+{
+	if (req->ns->bdev)
+		nvmet_bdev_poll_complete(req);
+}
+
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
@@ -653,6 +665,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
+	ns->use_poll = false;
 
 	return ns;
 }
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index b6fca0e421ef..13507e0cbc1d 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -49,10 +49,11 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
+	int fmode = FMODE_READ | FMODE_WRITE;
+	struct request_queue *q;
 	int ret;
 
-	ns->bdev = blkdev_get_by_path(ns->device_path,
-			FMODE_READ | FMODE_WRITE, NULL);
+	ns->bdev = blkdev_get_by_path(ns->device_path, fmode, NULL);
 	if (IS_ERR(ns->bdev)) {
 		ret = PTR_ERR(ns->bdev);
 		if (ret != -ENOTBLK) {
@@ -60,16 +61,21 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 					ns->device_path, PTR_ERR(ns->bdev));
 		}
 		ns->bdev = NULL;
-		return ret;
+		goto out;
 	}
 	ns->size = i_size_read(ns->bdev->bd_inode);
 	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
-	return 0;
+	q = bdev_get_queue(ns->bdev);
+	ns->poll = ns->use_poll && test_bit(QUEUE_FLAG_POLL, &q->queue_flags);
+	ret = ns->poll ? nvmet_ns_start_poll(ns) : 0;
+out:
+	return ret;
 }
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 {
 	if (ns->bdev) {
+		ns->poll ? nvmet_ns_stop_poll(ns) : 0;
 		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
 		ns->bdev = NULL;
 	}
@@ -133,15 +139,39 @@ static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 	return status;
 }
 
-static void nvmet_bio_done(struct bio *bio)
+void nvmet_bdev_req_complete(struct nvmet_req *req)
 {
-	struct nvmet_req *req = bio->bi_private;
+	struct bio *bio = req->b.last_bio;
 
 	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
 	if (bio != &req->b.inline_bio)
 		bio_put(bio);
 }
 
+static void nvmet_bio_done(struct bio *bio)
+{
+	struct nvmet_req *req = bio->bi_private;
+
+	req->b.last_bio = bio;
+
+	req->poll ? complete(&req->wait) : nvmet_bdev_req_complete(req);
+}
+
+void nvmet_bdev_poll_complete(struct nvmet_req *req)
+{
+	struct request_queue *q = bdev_get_queue(req->ns->bdev);
+
+	while (!completion_done(&req->wait)) {
+		int ret = blk_poll(q, req->b.cookie, true);
+
+		if (ret < 0) {
+			pr_err("tid %d poll error %d", req->t->id, ret);
+			break;
+		}
+	}
+	nvmet_bdev_req_complete(req);
+}
+
 static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
@@ -185,7 +215,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_end_io = nvmet_bio_done;
 	bio->bi_opf = op;
 
-	blk_start_plug(&plug);
+	if (!req->poll)
+		blk_start_plug(&plug);
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
 				!= sg->length) {
@@ -204,8 +235,16 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		sg_cnt--;
 	}
 
-	submit_bio(bio);
-	blk_finish_plug(&plug);
+	req->b.last_bio = bio;
+	if (req->poll)
+		req->b.last_bio->bi_opf |= REQ_HIPRI;
+
+	req->b.cookie = submit_bio(bio);
+
+	nvmet_req_prep_poll(req);
+	nvmet_req_issue_poll(req);
+	if (!req->poll)
+		blk_finish_plug(&plug);
 }
 
 static void nvmet_bdev_execute_flush(struct nvmet_req *req)
@@ -330,15 +369,19 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
+		req->poll = req->ns->poll;
 		req->execute = nvmet_bdev_execute_rw;
 		return 0;
 	case nvme_cmd_flush:
+		req->poll = false;
 		req->execute = nvmet_bdev_execute_flush;
 		return 0;
 	case nvme_cmd_dsm:
+		req->poll = false;
 		req->execute = nvmet_bdev_execute_dsm;
 		return 0;
 	case nvme_cmd_write_zeroes:
+		req->poll = false;
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
 	default:
diff --git a/drivers/nvme/target/io-poll.c b/drivers/nvme/target/io-poll.c
new file mode 100644
index 000000000000..175c939c22ff
--- /dev/null
+++ b/drivers/nvme/target/io-poll.c
@@ -0,0 +1,165 @@
+#include <linux/blkdev.h>
+#include <linux/module.h>
+#include <linux/sched/signal.h>
+#include <linux/kthread.h>
+#include <uapi/linux/sched/types.h>
+
+#include "nvmet.h"
+#define THREAD_PER_CPU	(num_online_cpus() * 2)
+
+static int nvmet_poll_thread(void *data);
+
+int nvmet_ns_start_poll(struct nvmet_ns *ns)
+{
+	struct nvmet_poll_data *t;
+	int ret = 0;
+	int i;
+
+	t = kzalloc(sizeof(*t) * THREAD_PER_CPU, GFP_KERNEL);
+	if (!t) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < THREAD_PER_CPU; i++) {
+		init_completion(&t[i].thread_complete);
+		init_waitqueue_head(&t[i].poll_waitq);
+		INIT_LIST_HEAD(&t[i].list);
+		INIT_LIST_HEAD(&t[i].done);
+		mutex_init(&t[i].list_lock);
+		t[i].id = i;
+
+		t[i].thread = kthread_create(nvmet_poll_thread, &t[i],
+					     "nvmet_poll_thread%s/%d",
+					     ns->device_path, i);
+
+		if (IS_ERR(t[i].thread)) {
+			ret = PTR_ERR(t[i].thread);
+			goto err;
+		}
+
+		kthread_bind(t[i].thread, i % num_online_cpus());
+		wake_up_process(t[i].thread);
+		wait_for_completion(&t[i].thread_complete);
+	}
+
+	ns->t = t;
+out:
+	return ret;
+err:
+	nvmet_ns_stop_poll(ns);
+	goto out;
+}
+
+void nvmet_ns_stop_poll(struct nvmet_ns *ns)
+{
+	struct nvmet_poll_data *t = ns->t;
+	int i;
+
+	for (i = 0; i < THREAD_PER_CPU; i++) {
+		if (!t[i].thread)
+			continue;
+
+		if (wq_has_sleeper(&t[i].poll_waitq))
+			wake_up(&t[i].poll_waitq);
+		kthread_park(t[i].thread);
+		kthread_stop(t[i].thread);
+	}
+}
+
+static void nvmet_poll(struct nvmet_poll_data *t)
+{
+	struct nvmet_req *req, *tmp;
+
+	lockdep_assert_held(&t->list_lock);
+
+	list_for_each_entry_safe(req, tmp, &t->list, poll_entry) {
+
+		if (completion_done(&req->wait)) {
+			list_move_tail(&req->poll_entry, &t->done);
+			continue;
+		}
+
+		if (!list_empty(&t->done))
+			break;
+
+		list_del(&req->poll_entry);
+		mutex_unlock(&t->list_lock);
+		nvmet_req_poll_complete(req);
+		mutex_lock(&t->list_lock);
+	}
+	mutex_unlock(&t->list_lock);
+	/*
+	 * In future we can also add batch timeout or nr request to complete.
+	 */
+	while (!list_empty(&t->done)) {
+		/*
+		 * We lock and unlock for t->list which gurantee progress of
+		 * nvmet_xxx_rw_execute() when under pressure while we complete
+		 * the request.
+		 */
+		req = list_first_entry(&t->done, struct nvmet_req, poll_entry);
+		list_del(&req->poll_entry);
+		nvmet_req_done(req);
+	}
+
+	mutex_lock(&t->list_lock);
+}
+
+static int nvmet_poll_thread(void *data)
+{
+	struct nvmet_poll_data *t = (struct nvmet_poll_data *) data;
+	DEFINE_WAIT(wait);
+
+	complete(&t->thread_complete);
+
+	while (!kthread_should_park()) {
+
+		mutex_lock(&t->list_lock);
+		while (!list_empty(&t->list) && !need_resched())
+			nvmet_poll(t);
+		mutex_unlock(&t->list_lock);
+
+		prepare_to_wait(&t->poll_waitq, &wait, TASK_INTERRUPTIBLE);
+		if (signal_pending(current))
+			flush_signals(current);
+		smp_mb();
+		schedule();
+
+		finish_wait(&t->poll_waitq, &wait);
+	}
+
+	kthread_parkme();
+	return 0;
+}
+
+inline void nvmet_req_prep_poll(struct nvmet_req *req)
+{
+	if (!req->poll)
+		return;
+
+	init_completion(&req->wait);
+	req->t = &req->ns->t[smp_processor_id()];
+}
+
+inline void nvmet_req_issue_poll(struct nvmet_req *req)
+{
+	if (!req->poll)
+		return;
+
+	while (!mutex_trylock(&req->t->list_lock)) {
+		if (req->t->id < num_online_cpus())
+			req->t = &req->ns->t[req->t->id + num_online_cpus()];
+		else
+			req->t = &req->ns->t[req->t->id - num_online_cpus()];
+	}
+
+	if (completion_done(&req->wait))
+		list_add(&req->poll_entry, &req->t->list);
+	else
+		list_add_tail(&req->poll_entry, &req->t->list);
+	mutex_unlock(&req->t->list_lock);
+
+	if (wq_has_sleeper(&req->t->poll_waitq))
+		wake_up(&req->t->poll_waitq);
+}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..ef2919e23e0b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -49,11 +49,22 @@
 #define IPO_IATTR_CONNECT_SQE(x)	\
 	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
 
+struct nvmet_poll_data {
+	struct completion		thread_complete;
+	wait_queue_head_t		poll_waitq;
+	struct mutex			list_lock;
+	struct task_struct		*thread;
+	struct list_head		list;
+	struct list_head		done;
+	unsigned int			id;
+};
+
 struct nvmet_ns {
 	struct list_head	dev_link;
 	struct percpu_ref	ref;
 	struct block_device	*bdev;
 	struct file		*file;
+	struct nvmet_poll_data	*t;
 	bool			readonly;
 	u32			nsid;
 	u32			blksize_shift;
@@ -63,6 +74,8 @@ struct nvmet_ns {
 	u32			anagrpid;
 
 	bool			buffered_io;
+	bool			use_poll;
+	bool			poll;
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
@@ -292,9 +305,15 @@ struct nvmet_req {
 	struct nvmet_ns		*ns;
 	struct scatterlist	*sg;
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
+	struct completion	wait;
+	bool			poll;
+	struct nvmet_poll_data  *t;
+	struct list_head	poll_entry;
 	union {
 		struct {
-			struct bio      inline_bio;
+			struct bio		inline_bio;
+			blk_qc_t		cookie;
+			struct bio		*last_bio;
 		} b;
 		struct {
 			bool			mpool_alloc;
@@ -442,6 +461,16 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
 
+int nvmet_ns_start_poll(struct nvmet_ns *ns);
+void nvmet_ns_stop_poll(struct nvmet_ns *ns);
+void nvmet_req_prep_poll(struct nvmet_req *req);
+void nvmet_req_issue_poll(struct nvmet_req *req);
+
+void nvmet_req_poll_complete(struct nvmet_req *req);
+void nvmet_bdev_poll_complete(struct nvmet_req *req);
+void nvmet_bdev_req_complete(struct nvmet_req *req);
+void nvmet_req_done(struct nvmet_req *req);
+
 #define NVMET_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
 #define NVMET_MAX_CMD		NVMET_QUEUE_SIZE
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
