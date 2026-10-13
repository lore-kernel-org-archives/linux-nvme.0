Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDA6CA9EC5
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 02:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ba8HIyTEZioFYwA6Xp49Au3oQ6zPI5Xf2mDJ4f5gLv8=; b=4dVDjg9hGaAQg8iabE0ZfA0Rpv
	OT9dtnoNXtPHi5aCReWBCe8nr5v4+J+XWCz9iYPe5utSS2UluWWtMWvBjI2OuV8lffTBIcqYcluhM
	fJeYfcP12SyziuhqTZiAEFRKLkA/b/eFSa/3e1xu+NUt7BJKqP/GbFPEh+9cUL7v9eGJNYK25k1lr
	X4VY2bCvTc1YgyUJwDiH85QcqVafZKHMEzb1T9OVrkGkKmK3fheIzm10Z4sSZpZl26/D1NV2u3wxi
	BVYhgM9g2dq97W1E6jHWEc4r6GsntesxacmCNuXgWfC0srl2iIaMNquXWKCUCcvPo8D+xClJsCVFO
	oc7vNTdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS90-0000000BmcD-1GDz;
	Tue, 13 Oct 2026 02:21:34 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS8t-0000000BmUx-3pfu
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 02:21:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791858086; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Ba8HIyTEZioFYwA6Xp49Au3oQ6zPI5Xf2mDJ4f5gLv8=;
	b=jJPmr2n+jz69h2dJlqccqzSFii91aj3yAxGBPCzVqFUrHtZIKR9cWzIqLd9G9HCPlGnbVvFlxFxwenF+OipqlXKhutPpMp5QSYFl54nwrsU7y6gLpBbRLnMzi6cO/xlWxFWfkwLalYurJg6a8+9e4IuyvDKMBSdd2qGMbMzB93A=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCk-8he_1791858085;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCk-8he_1791858085 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 10:21:25 +0800
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
Subject: [PATCH 10/11] nvmet: translate placement identifiers of writes to write streams
Date: Tue, 13 Oct 2026 10:21:08 +0800
Message-ID: <20261013022109.1507911-11-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261013022109.1507911-1-kanie@linux.alibaba.com>
References: <20261013022109.1507911-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_192128_132985_39E390A8 
X-CRM114-Status: GOOD (  14.00  )
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

A write command that carries the Data Placement Directive names a
placement identifier in the Directive Specific field.  Both sides of
the bridge use identity mapped handles: the write streams of the
backing device map to the placement handles one by one, in the order
the reclaim unit handle status reports them.  Translate the placement
identifier to the matching backing write stream on the write path, so
the data lands in the reclaim unit of the backing device that the
host selected.  The enable of the namespace has verified that the
backing placement identifiers are identity mapped.

Writes without the directive, and writes with a placement identifier
that is out of range, keep the default stream 0: the spec lets the
controller place such data itself.

Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  4 ++++
 drivers/nvme/target/nvmet.h       | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2d9e8901df4e..ff480f9ab9906 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -300,6 +300,10 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
+	if (req->cmd->rw.opcode == nvme_cmd_write &&
+	    nvmet_fdp_enabled(req->ns)) {
+		bio->bi_write_stream = nvmet_fdp_write_stream(req);
+	}
 
 	blk_start_plug(&plug);
 	if (req->metadata_len)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5bcc719973a57..af77591053226 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -1005,6 +1005,26 @@ void nvmet_execute_io_mgmt_recv(struct nvmet_req *req);
 void nvmet_execute_io_mgmt_send(struct nvmet_req *req);
 void nvmet_execute_get_log_page_fdp_configs(struct nvmet_req *req);
 void nvmet_fdp_log_forward(struct nvmet_req *req);
+
+/*
+ * Both sides of the bridge use identity mapped handles, so placement
+ * identifier i routes to backing write stream i+1; stream 0, the
+ * default, places the data without a directive.
+ */
+static inline u8 nvmet_fdp_write_stream(struct nvmet_req *req)
+{
+	u16 control = le16_to_cpu(req->cmd->rw.control);
+	u16 pid;
+
+	if ((control & 0xf0) != (NVME_RW_DTYPE_DPLCMT & 0xf0))
+		return 0;
+
+	pid = le32_to_cpu(req->cmd->rw.dsmgmt) >> 16;
+	if (pid >= req->ns->fdp.nruh)
+		return 0;
+
+	return pid + 1;
+}
 #else
 static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
 {
-- 
2.43.7


