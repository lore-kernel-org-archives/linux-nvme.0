Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712CE606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ileWl4J7;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GabYr3tZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4oHzHcFnSqncGkOcD94XAkGt7omQJMMviU1YI7Fnwzk=; b=ileWl4J7SWjGt8
	FzISsVYarC+p/81uE6nv66u5vD8tISsp/VMigW3FZrFOibaZtKWb50nqQ1P3wgNjTQEaKiaAQWJ1+
	vFrJUv6nLyup/p6F0BTzXFnMOdhVbRxDd6la5T37+VTcCo+ON361OW87S8BGfTUk/HFhcSQv5XEbM
	09BGhuWpKYG86YaEV8QyAWpSnqKzA/ukjEB/lOy0FGCDqYUHGhYEpAGgqMtbJM6aG9XPXlufNcSd7
	jZII9OSMAX/iXeZHzoADiJjH8sIvfUOusD+XSy0Ws05y5+KJ53dVYB3flAZtwmWKisRhykAZWwn6T
	Ysa8UUWOp+OXUwulrfQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPG3-000000099Y2-0Dtc;
	Thu, 29 Oct 2026 12:29:27 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFy-000000099Ln-35te
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:29:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793276960; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4oHzHcFnSqncGkOcD94XAkGt7omQJMMviU1YI7Fnwzk=;
	b=GabYr3tZI4g6Tpl1midV9Pmeh2dYkYABYoUrkdQi+kbUjmU2ij+kG1EWjK0yT6n6xh1QC2rfTHdZjmGi58cnoZb5BNRqQRx3tyYg9qlaOJtn7BzAgSZGQcrkuAkpcZk7Boh5e9ufNoDYXkBKmHzA0xXTC/dVfy9kbxzhH6pK0ik=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDjUB7a_1793276959;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDjUB7a_1793276959 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 20:29:19 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 12/12] nvmet: add an FDP write translation tracepoint
Date: Thu, 29 Oct 2026 20:28:33 +0800
Message-ID: <20261029122833.284572-13-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261029122833.284572-1-kanie@linux.alibaba.com>
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_052922_975975_45A1DBEC 
X-CRM114-Status: GOOD (  10.65  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a tracepoint to the write path that reports the placement
identifier carried by a write command with the Data Placement
Directive and the backing write stream it is translated to.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  8 ++++++++
 drivers/nvme/target/trace.h       | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 1390f70748af..6757d099b66a 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -9,6 +9,7 @@
 #include <linux/memremap.h>
 #include <linux/module.h>
 #include "nvmet.h"
+#include "trace.h"
 
 void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 {
@@ -305,6 +306,13 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	    nvmet_fdp_enabled(req->ns)) {
 		write_stream = nvmet_fdp_write_stream(req);
 		bio->bi_write_stream = write_stream;
+
+		if (write_stream) {
+			u16 pid = le32_to_cpu(req->cmd->rw.dsmgmt) >> 16;
+
+			trace_nvmet_fdp_write_translate(req, pid,
+							write_stream);
+		}
 	}
 
 	blk_start_plug(&plug);
diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 7f7ebf9558e5..0ab725296079 100644
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


