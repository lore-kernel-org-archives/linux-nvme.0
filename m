Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922C606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lPLvD0QE;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=FJUGCreY;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CKYwpzCd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HjYXYfZlv+QyOB31C+haC4gTu+lLwzg9gQxK7ehwk80=; b=lPLvD0QEOtPjM1
	hdNuLdrCSCTY59A43DspmxZ4X/vWSfMbDJUR0ziE2sWVOjc2v+86AzIBXTguGEE9A42859o2omvDS
	Lq/yFl+8h+JKnqnMqbxFzfZ9w0j+eqeBuGH84kzIJfs9pDqJqZmVd/4E5MQ58OktG2c8/xqy/QmJS
	ge/wEao6JM4d7Om7deEL+9cTKKD9jWiB76XxZcpTRarcaQqUCBSlZqb5QJvdx037thHTLGo9AUSsa
	pzruODwiZSsXu8dXtaTwSqTs9+eQMp38GkKSLIkkU6j1N71sDNvkW28WZe6eI0Zd1vQqTBmpVGeL+
	3hkVcRu5VvSueZw3wAYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAFN-0000000FrA1-2byu;
	Fri, 23 Oct 2026 08:03:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAFK-0000000Fr4j-3IIC
	for linux-nvme@bombadil.infradead.org;
	Fri, 23 Oct 2026 08:03:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=HjYXYfZlv+QyOB31C+haC4gTu+lLwzg9gQxK7ehwk80=; b=FJUGCreYilpmWPrSGr7th/nMlP
	a/ArrsYF1/5Z6uaiPZ3rCapZNy+8wJ81UiGkXTfWxpbkrYhpxmQY01TpX2PpGj77qYOSWW3SjrBGB
	0QSYsFDhXvR9G1wRGPDf8hdMtMlwzxmYbBF+96Vf1xLUUxZZPWSW/1237PjhxfzT6xWzbeVsgpeNK
	R6Fl6cadC7rkY1Ii+SnUZ6TklRIbvRCiA2V69IqUtFSctSIpl+guvctxA/CIiQKyYyVhEe1AN4qxG
	oVqsO1M0H/P6dDwobxgqhSgpgAFjuPvskNI/YSvHTs+wsdsdLcHnCLDxMXYCEZlAoyJ+Lr4tS3IHO
	I2WymAYA==;
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAFG-000000095dL-05Jg
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:03:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792742591; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HjYXYfZlv+QyOB31C+haC4gTu+lLwzg9gQxK7ehwk80=;
	b=CKYwpzCdDciJ952PEYp7AfLZSte7D8mSuoQCiYJQLmTj9nreW5xFCOnch/n8kYli7eYlWEityaxI0pEXBDEDX0F19PldRDb5/K7TDb7p16kcsWfRCVhLzU3q8UUcBzIiNBPJeKuibCmFQ603EnkCg63UWE8e7+x7uSLV/8yq4qo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLPeKt_1792742589;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLPeKt_1792742589 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 16:03:10 +0800
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
Date: Fri, 23 Oct 2026 16:02:51 +0800
Message-ID: <20261023080251.2606443-12-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023080251.2606443-1-kanie@linux.alibaba.com>
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_090322_974644_1F9FCAD4 
X-CRM114-Status: GOOD (  11.24  )
X-Spam-Score: -15.7 (---------------)
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 832b406442440..a8f3ad736335f 100644
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


