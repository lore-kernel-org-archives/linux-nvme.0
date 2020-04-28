Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5027C83000
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 13:14:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6064D206A1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 13:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uweWfe5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6064D206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y0Q0iKwwb2SLU6OU9SgeylYKNrsbjZKOnhbILS8gAMA=; b=uweWfe5LYrflnj
	3DcAY05zvYGP5GEsmCUkJcwioeDU8+WmbtvnS/DT5BC2Ob87e28NYR38oYhFkjjb+5GeVAOvkGPAb
	SDjhNntRGzGVIlwwJuOrKHBGGXlQaq6QUK6y6mekh/Vox1jZQ7dDzSm4/NiTP/HtQSaZ56bXl7guX
	zxy5TOyMevYKfyyGV2Tw2UW6y9xAj3Zp7jRTEWpuGxArdjRUi64KrzPSopHcmnkIGvuFIvjtC9rBP
	IeFcHS+BHEhVqCnpxoOXL+cFX0YNLd9QymWdOQwpqzNcJmlFxrIoBrPEeLlTQvSFnYJLrIJmb19F/
	IZbsHYXUB+H5j1UBdrOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTQ3m-00057M-OM; Tue, 28 Apr 2020 13:14:02 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTQ1Y-0003I6-WF
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 13:11:52 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 28 Apr 2020 16:11:37 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 03SDBZZ6028635;
 Tue, 28 Apr 2020 16:11:37 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: maxg@mellanox.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
Subject: [PATCH 11/15] nvmet: rename nvmet_check_data_len to
 nvmet_check_transfer_len
Date: Tue, 28 Apr 2020 16:11:31 +0300
Message-Id: <20200428131135.211521-12-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200428131135.211521-1-maxg@mellanox.com>
References: <20200428131135.211521-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_061145_479895_DC84FCFC 
X-CRM114-Status: GOOD (  10.37  )
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
Cc: vladimirk@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
 idanb@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

The function doesn't check only the data length, because the transfer
length includes also the metadata length in some cases. This is
preparation for adding metadata (T10-PI) support.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/nvme/target/admin-cmd.c   | 14 +++++++-------
 drivers/nvme/target/core.c        |  6 +++---
 drivers/nvme/target/discovery.c   |  8 ++++----
 drivers/nvme/target/fabrics-cmd.c |  8 ++++----
 drivers/nvme/target/io-cmd-bdev.c |  6 +++---
 drivers/nvme/target/io-cmd-file.c |  6 +++---
 drivers/nvme/target/nvmet.h       |  2 +-
 7 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 4c79aa8..905aba8 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -295,7 +295,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, nvmet_get_log_page_len(req->cmd)))
+	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
 		return;
 
 	switch (req->cmd->get_log_page.lid) {
@@ -630,7 +630,7 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, NVME_IDENTIFY_DATA_SIZE))
+	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
 		return;
 
 	switch (req->cmd->identify.cns) {
@@ -659,7 +659,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
  */
 static void nvmet_execute_abort(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 	nvmet_set_result(req, 1);
 	nvmet_req_complete(req, 0);
@@ -748,7 +748,7 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 	u16 nsqr;
 	u16 ncqr;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	switch (cdw10 & 0xff) {
@@ -820,7 +820,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, nvmet_feat_data_len(req, cdw10)))
+	if (!nvmet_check_transfer_len(req, nvmet_feat_data_len(req, cdw10)))
 		return;
 
 	switch (cdw10 & 0xff) {
@@ -887,7 +887,7 @@ void nvmet_execute_async_event(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	mutex_lock(&ctrl->lock);
@@ -906,7 +906,7 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b685f99..50dfc60 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -936,9 +936,9 @@ void nvmet_req_uninit(struct nvmet_req *req)
 }
 EXPORT_SYMBOL_GPL(nvmet_req_uninit);
 
-bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len)
+bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len)
 {
-	if (unlikely(data_len != req->transfer_len)) {
+	if (unlikely(len != req->transfer_len)) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
 		return false;
@@ -946,7 +946,7 @@ bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len)
 
 	return true;
 }
-EXPORT_SYMBOL_GPL(nvmet_check_data_len);
+EXPORT_SYMBOL_GPL(nvmet_check_transfer_len);
 
 bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len)
 {
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 0c2274b..40cf0b6 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -171,7 +171,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	u16 status = 0;
 	void *buffer;
 
-	if (!nvmet_check_data_len(req, data_len))
+	if (!nvmet_check_transfer_len(req, data_len))
 		return;
 
 	if (req->cmd->get_log_page.lid != NVME_LOG_DISC) {
@@ -244,7 +244,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 	const char model[] = "Linux";
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, NVME_IDENTIFY_DATA_SIZE))
+	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
 		return;
 
 	if (req->cmd->identify.cns != NVME_ID_CNS_CTRL) {
@@ -298,7 +298,7 @@ static void nvmet_execute_disc_set_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 stat;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	switch (cdw10 & 0xff) {
@@ -324,7 +324,7 @@ static void nvmet_execute_disc_get_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 stat = 0;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	switch (cdw10 & 0xff) {
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index feef15c..52a6f70 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -12,7 +12,7 @@ static void nvmet_execute_prop_set(struct nvmet_req *req)
 	u64 val = le64_to_cpu(req->cmd->prop_set.value);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	if (req->cmd->prop_set.attrib & 1) {
@@ -41,7 +41,7 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 	u16 status = 0;
 	u64 val = 0;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	if (req->cmd->prop_get.attrib & 1) {
@@ -156,7 +156,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = NULL;
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, sizeof(struct nvmf_connect_data)))
+	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
 
 	d = kmalloc(sizeof(*d), GFP_KERNEL);
@@ -223,7 +223,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	u16 qid = le16_to_cpu(c->qid);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, sizeof(struct nvmf_connect_data)))
+	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
 
 	d = kmalloc(sizeof(*d), GFP_KERNEL);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 05df646d..d265cf5 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -183,7 +183,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	sector_t sector;
 	int op, i;
 
-	if (!nvmet_check_data_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
 		return;
 
 	if (!req->sg_cnt) {
@@ -244,7 +244,7 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 {
 	struct bio *bio = &req->b.inline_bio;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
@@ -336,7 +336,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	sector_t nr_sector;
 	int ret;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	sector = le64_to_cpu(write_zeroes->slba) <<
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index df6abfa..b8a2e06 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -242,7 +242,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 {
 	ssize_t nr_bvec = req->sg_cnt;
 
-	if (!nvmet_check_data_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
 		return;
 
 	if (!req->sg_cnt || !nr_bvec) {
@@ -286,7 +286,7 @@ static void nvmet_file_flush_work(struct work_struct *w)
 
 static void nvmet_file_execute_flush(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 	INIT_WORK(&req->f.work, nvmet_file_flush_work);
 	schedule_work(&req->f.work);
@@ -376,7 +376,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 
 static void nvmet_file_execute_write_zeroes(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 	INIT_WORK(&req->f.work, nvmet_file_write_zeroes_work);
 	schedule_work(&req->f.work);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 0ce9404..ceedaaf 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -387,7 +387,7 @@ static inline bool nvmet_aen_bit_disabled(struct nvmet_ctrl *ctrl, u32 bn)
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops);
 void nvmet_req_uninit(struct nvmet_req *req);
-bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len);
+bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len);
 bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
 int nvmet_req_alloc_sgl(struct nvmet_req *req);
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
