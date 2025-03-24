Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B390C3600C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4aGhhVckKaavAIt7JjfSFCaeqv5hgZn2WTKGtcoWeU0=; b=P0V0V1z/ZCcJnmFtxn/5IRqh2K
	5AjzMuh0beA2NWnBwScGakn7oPr/1LGpNy/fk+dsu3jlImpZDZnqWMubwXB44J1wW6KrxvKjUbviv
	/hnkYic26+n8kkDwxCDOPEy0LF1E9OYV+eSuH52muWyivnXy3LK75Mtn2lBjDTVSnfSpJxGG339fX
	mMyrFSIdNzcsKj9q7KujnitVDESsyfDMzh+QmJsCD4VWr649U3WT81GlD52djMGN5YCXwuDUCEzvW
	fWFzHGZbqoUBJ/YmRph5o5i6HCXcMpU+Cz7zHKA7kf1vC/Glz+O6eOFVJVKcEN5xQyrArbLKE4TZr
	e9Zcj6ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twez0-00000002oUA-3XuH;
	Mon, 24 Mar 2025 10:24:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyO-00000002oJ3-372A
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742811840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aGhhVckKaavAIt7JjfSFCaeqv5hgZn2WTKGtcoWeU0=;
	b=W7zqgQ/CKPyqgaBLTwqF15xdb8IftUfbwVCc8M23J6qwS0Tlhg6McR9BNJG4GfR1T3+oFB
	zvQZTKz7OJ1L0ZZte7pwEkB7AremG4ydIhe9teR1NSdewXe3pOFdhYA61boq2aC3XiWmhH
	W/xobLPor95RJvaPNjWkYDh5bU4mTtQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-Ihl59tj8N6ihr5NDakOD8A-1; Mon,
 24 Mar 2025 06:23:55 -0400
X-MC-Unique: Ihl59tj8N6ihr5NDakOD8A-1
X-Mimecast-MFC-AGG-ID: Ihl59tj8N6ihr5NDakOD8A_1742811834
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2D45196DF0D;
	Mon, 24 Mar 2025 10:23:54 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12635180A801;
	Mon, 24 Mar 2025 10:23:51 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	jmeneghi@redhat.com,
	hare@suse.de,
	cleech@redhat.com
Subject: [PATCH RFC v3 11/11] nvmet: cancel implementation
Date: Mon, 24 Mar 2025 11:23:10 +0100
Message-ID: <20250324102310.658007-12-mlombard@redhat.com>
In-Reply-To: <20250324102310.658007-1-mlombard@redhat.com>
References: <20250324102310.658007-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TVRto-iR1HLNPr-oAiYZyAgbwUQcCsIdLGosvl0z2ug_1742811834
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_032400_848836_1BED658A 
X-CRM114-Status: GOOD (  15.26  )
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

From: Chris Leech <cleech@redhat.com>

Requests are canceled if the have been delayed and cancel_delayed_work
is successfull.

replace emulate_cancel_commands modparam with the delay kconfig

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/target/Makefile        |  3 ++-
 drivers/nvme/target/admin-cmd.c     |  7 +++----
 drivers/nvme/target/core.c          |  9 +++------
 drivers/nvme/target/io-cmd-cancel.c | 27 ++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h         |  2 --
 5 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index a533357e9be4..5d9848605285 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -11,7 +11,8 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 obj-$(CONFIG_NVME_TARGET_PCI_EPF)	+= nvmet-pci-epf.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o pr.o io-cmd-cancel.o
+			discovery.o io-cmd-file.o io-cmd-bdev.o pr.o
+nvmet-$(CONFIG_NVME_TARGET_DELAY_REQUESTS) += io-cmd-cancel.o
 nvmet-$(CONFIG_NVME_TARGET_DEBUGFS)	+= debugfs.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
 nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 57b90263a7cb..149c72d0b429 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -398,10 +398,9 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 	log->iocs[nvme_cmd_resv_release] =
 	log->iocs[nvme_cmd_resv_report] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
-	if (emulate_cancel_support) {
-		log->iocs[nvme_cmd_cancel] =
-			cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
-	}
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+	log->iocs[nvme_cmd_cancel] = cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+#endif
 	log->iocs[nvme_cmd_write] =
 	log->iocs[nvme_cmd_write_zeroes] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b446db3804f1..fd242af9fefb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -29,10 +29,6 @@ static DEFINE_IDA(cntlid_ida);
 struct workqueue_struct *nvmet_wq;
 EXPORT_SYMBOL_GPL(nvmet_wq);
 
-bool emulate_cancel_support;
-module_param(emulate_cancel_support, bool, 0644);
-MODULE_PARM_DESC(emulate_cancel_support, "Emulate the cancel command support. Default = false");
-
 /*
  * This read/write semaphore is used to synchronize access to configuration
  * information on a target system that will result in discovery log page
@@ -1078,12 +1074,13 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (nvmet_is_passthru_req(req))
 		return nvmet_parse_passthru_io_cmd(req);
 
-	if (emulate_cancel_support &&
-	    req->cmd->common.opcode == nvme_cmd_cancel) {
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+	if (req->cmd->common.opcode == nvme_cmd_cancel) {
 		req->execute = nvmet_execute_cancel;
 		if (req->cmd->cancel.nsid == NVME_NSID_ALL)
 			return 0;
 	}
+#endif
 
 	ret = nvmet_req_find_ns(req);
 	if (unlikely(ret))
diff --git a/drivers/nvme/target/io-cmd-cancel.c b/drivers/nvme/target/io-cmd-cancel.c
index 8f55458e646a..8d7f363c9163 100644
--- a/drivers/nvme/target/io-cmd-cancel.c
+++ b/drivers/nvme/target/io-cmd-cancel.c
@@ -14,6 +14,8 @@ void nvmet_execute_cancel(struct nvmet_req *req)
 	int ret = 0;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_sq *sq = req->sq;
+	struct nvmet_req *treq;
+	u32 canceled = 0;
 
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
@@ -45,8 +47,31 @@ void nvmet_execute_cancel(struct nvmet_req *req)
 		ret = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
+	if (!mult_cmds) {
+		treq = xa_load(&sq->outstanding_requests, cid);
+		if (treq) {
+			if (cancel_delayed_work(&treq->req_work)) {
+				pr_info("nvmet: CANCEL success: %d", cid);
+				nvmet_req_complete(treq, NVME_SC_ABORT_REQ);
+				canceled += 1;
+			} else {
+				pr_info("nvmet: CANCEL failed: %d", cid);
+			}
+		} else {
+			pr_info("nvmet: CANCEL request not found: %d", cid);
+		}
+	} else {
+		unsigned long ucid;
+		xa_for_each(&sq->outstanding_requests, ucid, treq) {
+			if (cancel_delayed_work(&treq->req_work)) {
+				nvmet_req_complete(treq, NVME_SC_ABORT_REQ);
+				canceled += 1;
+			}
+		}
+		pr_info("nvmet: CANCEL removed %d requests", canceled);
+	}
 exit:
-	nvmet_set_result(req, 0);
+	nvmet_set_result(req, canceled);
 	nvmet_req_complete(req, ret);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index fc61f28c63da..525803774183 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -40,8 +40,6 @@
 #define nvmet_for_each_enabled_ns(xa, index, entry) \
 	xa_for_each_marked(xa, index, entry, NVMET_NS_ENABLED)
 
-extern bool emulate_cancel_support;
-
 /*
  * Supported optional AENs:
  */
-- 
2.43.5


