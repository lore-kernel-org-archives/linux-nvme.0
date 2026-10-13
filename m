Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE10CC6B01
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 02:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nx09b3aplpXwRCI+pjPIFZ6yvnMtfaKSUeWLrmcmfO4=; b=BL5mLk45SkLXQ4pJBYlKdfl08S
	si4lW1lVjePlKHggucIgN3UPgHanGAXTDDaZ4bG/khN5275fPOXGNhqyIvn6Tillh6jdDm5ND6cB/
	u4reMtpkO6GXYi8awNNz0wFmNkwG8v6lYpKYQ5ijwgQ56nDrDf1PmrOX5Dd2djgdtIF7YQUUC/9mo
	+ow2DTaAxXVxXRdvIKDQUKEi/1pVCZiouhqLmL9etnj/xAmvz380vhONY1DZLVp5XhzfCCghG+9Dd
	1w9obl/ZuC0gyctvDhVDcf2PcENdjrSC8q3qmeGqJGVE/lIySiBUeHV6OQXQ7/xCp3PEW4y43c2lu
	qjFSu2ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS90-0000000Bmcb-2CNN;
	Tue, 13 Oct 2026 02:21:34 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS8v-0000000BmVs-0IbC
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 02:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791858087; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Nx09b3aplpXwRCI+pjPIFZ6yvnMtfaKSUeWLrmcmfO4=;
	b=fkhb07kDGxw8TQNl0OPu4VrWgZ4IzQG1suOyrFeCzQt7Qzc2G3FwbyVX2HHOB86XA54o6EkbGF4sZm5lyx0DRyzCquMXQuvuGHFbmYQ9akTN/2vIam4gPClDZUgpkqORzgI5krAYJLk4zs5ZRak2GJAiIRo7ZWQiuvrHmK+iWo4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCk4UT6_1791858086;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCk4UT6_1791858086 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 10:21:26 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 11/11] nvmet: add an FDP write translation tracepoint
Date: Tue, 13 Oct 2026 10:21:09 +0800
Message-ID: <20261013022109.1507911-12-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261013022109.1507911-1-kanie@linux.alibaba.com>
References: <20261013022109.1507911-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_192129_306135_2512FE57 
X-CRM114-Status: GOOD (  10.46  )
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

Add a tracepoint to the write path that reports the placement
identifier carried by a write command with the Data Placement
Directive and the backing write stream it is translated to.

Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  4 ++++
 drivers/nvme/target/trace.h       | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index ff480f9ab9906..139be9edad969 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -9,6 +9,7 @@
 #include <linux/memremap.h>
 #include <linux/module.h>
 #include "nvmet.h"
+#include "trace.h"
 
 void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 {
@@ -302,7 +303,10 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_end_io = nvmet_bio_done;
 	if (req->cmd->rw.opcode == nvme_cmd_write &&
 	    nvmet_fdp_enabled(req->ns)) {
+		u16 pid = le32_to_cpu(req->cmd->rw.dsmgmt) >> 16;
+
 		bio->bi_write_stream = nvmet_fdp_write_stream(req);
+		trace_nvmet_fdp_write_translate(req, pid, bio->bi_write_stream);
 	}
 
 	blk_start_plug(&plug);
diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 7f7ebf9558e50..0ab7252960790 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -131,6 +131,29 @@ TRACE_EVENT(nvmet_req_complete,
 
 );
 
+TRACE_EVENT(nvmet_fdp_write_translate,
+	TP_PROTO(struct nvmet_req *req, u16 pid, u8 stream),
+	TP_ARGS(req, pid, stream),
+	TP_STRUCT__entry(
+		__field(u16, ctrl_id)
+		__array(char, disk, DISK_NAME_LEN)
+		__field(u32, nsid)
+		__field(u16, pid)
+		__field(u8, stream)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvmet_req_to_ctrl_id(req);
+		__assign_req_name(__entry->disk, req);
+		__entry->nsid = req->ns->nsid;
+		__entry->pid = pid;
+		__entry->stream = stream;
+	),
+	TP_printk("nvmet%s: %snsid=%u, pid=%u, write_stream=%u",
+		__print_ctrl_id(__entry->ctrl_id),
+		__print_disk_name(__entry->disk),
+		__entry->nsid, __entry->pid, __entry->stream)
+);
+
 #define aer_name(aer) { aer, #aer }
 
 TRACE_EVENT(nvmet_async_event,
-- 
2.43.7


