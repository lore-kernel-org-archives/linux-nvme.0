Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A56C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OElSqM8dA5VYcg8LdMZOALPfVZELBuYCm1jtfStlZ2A=; b=Nvbrlv2PQZhN9wB4Tnh8HEAuQr
	4qnsmXyrMCR1PMNyHJb6o86yJzAKF34weiyVR5CHns9LmZFF3J5wxeMxpY3C6MvFJw/8QXucZLSPU
	SFItbpILjap0bP8Uv7q6wgcW00MIWEL3OGqWlz74GIhCkYmWSYBANF4+P9Je/8pMxypLsQudjYghi
	3PBlSp9DojGCgqVqFIGhKdAd/wDcaqLUK4a2DQSBfsR1DQWQGU3vJl0e3iyA79dBWhl9+xy1oDPI3
	oSPg1X8qURBlhj9R2egpVddDpqjNP/+QxqXQITDd4Wy5c3RgMZRs8qfP4+tuOvfTaOv/LxmCd8KUU
	hjyIaJVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o29mS-007BFP-HO; Fri, 17 Jun 2022 11:04:48 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o29jT-0079aF-91
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 11:01:45 +0000
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LPbc14wRDz687hH;
	Fri, 17 Jun 2022 18:57:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 13:01:38 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 12:01:34 +0100
From: John Garry <john.garry@huawei.com>
To: <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
	<bvanassche@acm.org>, <hch@lst.de>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <hare@suse.de>, <satishkh@cisco.com>,
	<sebaddel@cisco.com>, <kartilak@cisco.com>
CC: <linux-rdma@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <mpi3mr-linuxdrv.pdl@broadcom.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nbd@other.debian.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/5] scsi: core: Remove reserved request time-out handling
Date: Fri, 17 Jun 2022 18:55:16 +0800
Message-ID: <1655463320-241202-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_040143_645210_7C8BAB94 
X-CRM114-Status: GOOD (  11.73  )
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

The SCSI code does not currently support reserved commands. As such,
requests which time-out would never be reserved, and scsi_timeout()
'reserved' arg should never be set.

Remove handling for reserved requests and drop wrapper scsi_timeout() as
it now just calls scsi_times_out() always.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/scsi_error.c |  3 ++-
 drivers/scsi/scsi_lib.c   | 12 ++----------
 drivers/scsi/scsi_priv.h  |  3 ++-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 49ef864df581..80cd6835ac70 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -318,6 +318,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 /**
  * scsi_times_out - Timeout function for normal scsi commands.
  * @req:	request that is timing out.
+ * @reserved:	whether the request is a reserved request.
  *
  * Notes:
  *     We do not need to lock this.  There is the potential for a race
@@ -325,7 +326,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
  *     normal completion function determines that the timer has already
  *     fired, then it mustn't do anything.
  */
-enum blk_eh_timer_return scsi_times_out(struct request *req)
+enum blk_eh_timer_return scsi_times_out(struct request *req, bool reserved)
 {
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
 	enum blk_eh_timer_return rtn = BLK_EH_DONE;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6ffc9e4258a8..d635831165d5 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1790,14 +1790,6 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static enum blk_eh_timer_return scsi_timeout(struct request *req,
-		bool reserved)
-{
-	if (reserved)
-		return BLK_EH_RESET_TIMER;
-	return scsi_times_out(req);
-}
-
 static int scsi_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 				unsigned int hctx_idx, unsigned int numa_node)
 {
@@ -1912,7 +1904,7 @@ static const struct blk_mq_ops scsi_mq_ops_no_commit = {
 	.put_budget	= scsi_mq_put_budget,
 	.queue_rq	= scsi_queue_rq,
 	.complete	= scsi_complete,
-	.timeout	= scsi_timeout,
+	.timeout	= scsi_times_out,
 #ifdef CONFIG_BLK_DEBUG_FS
 	.show_rq	= scsi_show_rq,
 #endif
@@ -1941,7 +1933,7 @@ static const struct blk_mq_ops scsi_mq_ops = {
 	.queue_rq	= scsi_queue_rq,
 	.commit_rqs	= scsi_commit_rqs,
 	.complete	= scsi_complete,
-	.timeout	= scsi_timeout,
+	.timeout	= scsi_times_out,
 #ifdef CONFIG_BLK_DEBUG_FS
 	.show_rq	= scsi_show_rq,
 #endif
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 5c4786310a31..8966f20b7d55 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -72,7 +72,8 @@ extern void scsi_exit_devinfo(void);
 
 /* scsi_error.c */
 extern void scmd_eh_abort_handler(struct work_struct *work);
-extern enum blk_eh_timer_return scsi_times_out(struct request *req);
+extern enum blk_eh_timer_return scsi_times_out(struct request *req,
+					       bool reserved);
 extern int scsi_error_handler(void *host);
 extern enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *cmd);
 extern void scsi_eh_wakeup(struct Scsi_Host *shost);
-- 
2.35.3


