Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC1BCCF2E4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 03:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nx09b3aplpXwRCI+pjPIFZ6yvnMtfaKSUeWLrmcmfO4=; b=CWT/aWG5J+j5wDdyyRmyJhlVYR
	QLkV+zs4eglgMn35fVqwZDehWxTF+g3GNE+yZcVGFB3e3VBwDliRnP7ux9H1TaqggZny1joeW7Z8k
	oV8eo7lZ4pDdJ7GcciohboMv7L2hYhUoHxJOr8z2ezocZOGmCZMk/t6s19hEI6mwKWlc9FZXJ/jF7
	xqMePiU+UlObXz65wtZJh6ocZPjlYx690jbOInLYbai43JdDD2vvJAyg5LPo8+mfNL/iVp4U4uy0y
	kvZgrv/sSaUjIs7Y1FzPGcYkDe90OuFvMmIq5fpCmDEBZusPolns4ehZ6yR7+HzF1W1Hp7uGUt5OT
	0Q7uzJeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeB6-00000006XnV-2qDu;
	Mon, 19 Oct 2026 03:36:48 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeB0-00000006Xfr-19yR
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 03:36:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792381000; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Nx09b3aplpXwRCI+pjPIFZ6yvnMtfaKSUeWLrmcmfO4=;
	b=lU3WsijhFRkESO/oap51B8UZt3Ueiy7XoFtGxy6EAWTkG4UaDK3GwM8TsTd/85JsmNu9b+PYFfTS/HoJVVnaEu9V7mqczi0x6qhIKJ/4esgauBjUBdy+B3J+rLXnEmVetFhxJPJGDuPWpNlSgzUdfUkKA0EDdg/P/CGZHgBx+lM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XD-YSEV_1792380999;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD-YSEV_1792380999 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 11:36:40 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 11/11] nvmet: add an FDP write translation tracepoint
Date: Mon, 19 Oct 2026 11:36:24 +0800
Message-ID: <20261019033624.402337-12-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261019033624.402337-1-kanie@linux.alibaba.com>
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_203642_545844_CB92D954 
X-CRM114-Status: GOOD (  10.89  )
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


