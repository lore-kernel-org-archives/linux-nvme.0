Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7758CCA485
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 11:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7XLC3XCHNt6ZcFPpAEBBdaX44CTgjdo3rPNDyZddxjY=; b=r7XKRwajU2Ck7NLSd8tyevhvWg
	/Vm4QbGeppvpUzWNPZA4LJSCpWJPCCviSiHyXll2yGgTXajSmsm0vp27W6yqJQ1R1kvkvi8vE7HgS
	gX/y5NGXldiLkZxeYRv4oJPYCcyhFio5mepqllzFS8cXGUPQBIKwgGTjdIR/EBdy5z77Cl396hPsK
	JGHBZKeTEbQBxnVbjiPbXSaVDakq6UMvOlhKLK0xMpIYQ9PP9+PNiY/hoyq+u6xwawyZamjj4NMOC
	YAgVrjYULY3SB+mwLA9NsWMhj3obpdl2jrlQwLiiuCa0VdX41BKMK226oTEOMm0fYaVwNwFgHLnAh
	Z37tqgbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3bxh-0052MD-SD; Tue, 21 Jun 2022 11:22:25 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3bxa-0052KF-3J
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 11:22:20 +0000
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LS3sg57ktz687S7;
	Tue, 21 Jun 2022 19:18:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 13:22:06 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 12:22:01 +0100
From: John Garry <john.garry@huawei.com>
To: <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
	<bvanassche@acm.org>, <hch@lst.de>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <hare@suse.de>, <satishkh@cisco.com>,
	<sebaddel@cisco.com>, <kartilak@cisco.com>
CC: <linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<mpi3mr-linuxdrv.pdl@broadcom.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nbd@other.debian.org>, John Garry
	<john.garry@huawei.com>
Subject: [PATCH v2 1/6] scsi: core: Remove reserved request time-out handling
Date: Tue, 21 Jun 2022 19:15:38 +0800
Message-ID: <1655810143-67784-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
References: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_042218_478867_8651AF55 
X-CRM114-Status: GOOD (  17.61  )
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

The SCSI core code does not currently support reserved commands. As such,
requests which time-out would never be reserved, and scsi_timeout()
'reserved' arg should never be set.

Remove handling for reserved requests, drop the wrapper scsi_timeout()
as it now just calls scsi_times_out() always, and finally rename
scsi_times_out() -> scsi_timeout() to match the blk_mq_ops method name.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 Documentation/scsi/scsi_eh.rst          | 3 +--
 Documentation/scsi/scsi_mid_low_api.rst | 2 +-
 drivers/scsi/scsi_error.c               | 7 ++++---
 drivers/scsi/scsi_lib.c                 | 8 --------
 drivers/scsi/scsi_priv.h                | 3 ++-
 5 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/Documentation/scsi/scsi_eh.rst b/Documentation/scsi/scsi_eh.rst
index 885395dc1f15..bad624fab823 100644
--- a/Documentation/scsi/scsi_eh.rst
+++ b/Documentation/scsi/scsi_eh.rst
@@ -87,8 +87,7 @@ with the command.
 1.2.2 Completing a scmd w/ timeout
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-The timeout handler is scsi_times_out().  When a timeout occurs, this
-function
+The timeout handler is scsi_timeout().  When a timeout occurs, this function
 
  1. invokes optional hostt->eh_timed_out() callback.  Return value can
     be one of
diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi/scsi_mid_low_api.rst
index 63ddea2b9640..a8c5bd15a440 100644
--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -731,7 +731,7 @@ Details::
     *      Notes: If 'no_async_abort' is defined this callback
     *  	will be invoked from scsi_eh thread. No other commands
     *	will then be queued on current host during eh.
-    *	Otherwise it will be called whenever scsi_times_out()
+    *	Otherwise it will be called whenever scsi_timeout()
     *      is called due to a command timeout.
     *
     *      Optionally defined in: LLD
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 49ef864df581..a8b71b73a5a5 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -139,7 +139,7 @@ static bool scsi_eh_should_retry_cmd(struct scsi_cmnd *cmd)
  *
  * Note: this function must be called only for a command that has timed out.
  * Because the block layer marks a request as complete before it calls
- * scsi_times_out(), a .scsi_done() call from the LLD for a command that has
+ * scsi_timeout(), a .scsi_done() call from the LLD for a command that has
  * timed out do not have any effect. Hence it is safe to call
  * scsi_finish_command() from this function.
  */
@@ -316,8 +316,9 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 }
 
 /**
- * scsi_times_out - Timeout function for normal scsi commands.
+ * scsi_timeout - Timeout function for normal scsi commands.
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
+enum blk_eh_timer_return scsi_timeout(struct request *req, bool reserved)
 {
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
 	enum blk_eh_timer_return rtn = BLK_EH_DONE;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6ffc9e4258a8..8eb51ef7c077 100644
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
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 5c4786310a31..695d0c83ffe0 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -72,7 +72,8 @@ extern void scsi_exit_devinfo(void);
 
 /* scsi_error.c */
 extern void scmd_eh_abort_handler(struct work_struct *work);
-extern enum blk_eh_timer_return scsi_times_out(struct request *req);
+extern enum blk_eh_timer_return scsi_timeout(struct request *req,
+					     bool reserved);
 extern int scsi_error_handler(void *host);
 extern enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *cmd);
 extern void scsi_eh_wakeup(struct Scsi_Host *shost);
-- 
2.25.1


