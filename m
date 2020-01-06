Return-Path: <SRS0=Zaot=23=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0153BC33C8C
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 13:39:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56412075A
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 13:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cx2rUlyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56412075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UiE2JCEhpxE5en4KdE4edsQzRyRcdMXu7F/cQWphmQs=; b=cx2rUlyjeyb/kR
	S7/MvNJVs39Tsjjbl+8dxfQyg4VG03gm0hkKRcrORk3Yq3sIc0O2q0VREEK7Nk7cXOqB2HH+q93o8
	a/kLVMDowdC7DsJycrb12XYJQ+6uNDJj2lxJ7JtnWS7Acpvvv/qq3GzI4BnHa6NRlx2LhHAcX/b3B
	3fDKNzR6QFxZZXdJMgAyKnECTc0lPDlPkecfxOAQL//6ADLXw/w0Of7DzRg1zG/wGygsr49AzULcN
	Y2SDbcNCcbY7axgUIgT96PLPZ7Fh5G/7B3q6HeNRjSAiujIk2tNtwvCah92s8jIQ0ktjSVj9J47Tk
	C1rSFds8R4/a5oYF93Lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ioSb4-0006ju-58; Mon, 06 Jan 2020 13:39:06 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ioSZp-0005aT-FE
 for linux-nvme@lists.infradead.org; Mon, 06 Jan 2020 13:37:54 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 6 Jan 2020 15:37:38 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 006DbaFM029740;
 Mon, 6 Jan 2020 15:37:38 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com
Subject: [PATCH 11/15] nvmet: Rename nvmet_check_data_len to
 nvmet_check_transfer_len
Date: Mon,  6 Jan 2020 15:37:32 +0200
Message-Id: <20200106133736.123038-13-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200106133736.123038-1-maxg@mellanox.com>
References: <20200106133736.123038-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200106_053749_954924_6476BD1F 
X-CRM114-Status: GOOD (  10.65  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

The function doesn't checks only the data length, because the transfer
length includes also the metadata length in some cases. This is
preparation for adding metadata (T10-PI) support.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/admin-cmd.c   | 14 +++++++-------
 drivers/nvme/target/core.c        |  6 +++---
 drivers/nvme/target/discovery.c   |  8 ++++----
 drivers/nvme/target/fabrics-cmd.c |  8 ++++----
 drivers/nvme/target/io-cmd-bdev.c |  8 ++++----
 drivers/nvme/target/io-cmd-file.c |  8 ++++----
 drivers/nvme/target/nvmet.h       |  2 +-
 7 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 56c21b50..19ae155 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -284,7 +284,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, nvmet_get_log_page_len(req->cmd)))
+	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
 		return;
 
 	switch (req->cmd->get_log_page.lid) {
@@ -597,7 +597,7 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, NVME_IDENTIFY_DATA_SIZE))
+	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
 		return;
 
 	switch (req->cmd->identify.cns) {
@@ -626,7 +626,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
  */
 static void nvmet_execute_abort(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 	nvmet_set_result(req, 1);
 	nvmet_req_complete(req, 0);
@@ -712,7 +712,7 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	switch (cdw10 & 0xff) {
@@ -778,7 +778,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	switch (cdw10 & 0xff) {
@@ -845,7 +845,7 @@ void nvmet_execute_async_event(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	mutex_lock(&ctrl->lock);
@@ -864,7 +864,7 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ab3ffc6..092c06f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -930,9 +930,9 @@ void nvmet_req_uninit(struct nvmet_req *req)
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
@@ -940,7 +940,7 @@ bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len)
 
 	return true;
 }
-EXPORT_SYMBOL_GPL(nvmet_check_data_len);
+EXPORT_SYMBOL_GPL(nvmet_check_transfer_len);
 
 int nvmet_req_alloc_sgl(struct nvmet_req *req)
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
index f729747..ee41b2b 100644
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
@@ -151,7 +151,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = NULL;
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, sizeof(struct nvmf_connect_data)))
+	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
 
 	d = kmalloc(sizeof(*d), GFP_KERNEL);
@@ -218,7 +218,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	u16 qid = le16_to_cpu(c->qid);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, sizeof(struct nvmf_connect_data)))
+	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
 
 	d = kmalloc(sizeof(*d), GFP_KERNEL);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 190cdc8..9f99b9d 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -173,7 +173,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	sector_t sector;
 	int op, i;
 
-	if (!nvmet_check_data_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
 		return;
 
 	if (!req->sg_cnt) {
@@ -234,7 +234,7 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 {
 	struct bio *bio = &req->b.inline_bio;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
@@ -302,7 +302,7 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 
 static void nvmet_bdev_execute_dsm(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, nvmet_dsm_len(req)))
+	if (!nvmet_check_transfer_len(req, nvmet_dsm_len(req)))
 		return;
 
 	switch (le32_to_cpu(req->cmd->dsm.attributes)) {
@@ -326,7 +326,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	sector_t nr_sector;
 	int ret;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	sector = le64_to_cpu(write_zeroes->slba) <<
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index e0a4859..1492f55 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -232,7 +232,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 {
 	ssize_t nr_bvec = req->sg_cnt;
 
-	if (!nvmet_check_data_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
 		return;
 
 	if (!req->sg_cnt || !nr_bvec) {
@@ -276,7 +276,7 @@ static void nvmet_file_flush_work(struct work_struct *w)
 
 static void nvmet_file_execute_flush(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 	INIT_WORK(&req->f.work, nvmet_file_flush_work);
 	schedule_work(&req->f.work);
@@ -336,7 +336,7 @@ static void nvmet_file_dsm_work(struct work_struct *w)
 
 static void nvmet_file_execute_dsm(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, nvmet_dsm_len(req)))
+	if (!nvmet_check_transfer_len(req, nvmet_dsm_len(req)))
 		return;
 	INIT_WORK(&req->f.work, nvmet_file_dsm_work);
 	schedule_work(&req->f.work);
@@ -366,7 +366,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 
 static void nvmet_file_execute_write_zeroes(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 	INIT_WORK(&req->f.work, nvmet_file_write_zeroes_work);
 	schedule_work(&req->f.work);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8e6f11f..c8b7095 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -381,7 +381,7 @@ static inline bool nvmet_aen_bit_disabled(struct nvmet_ctrl *ctrl, u32 bn)
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops);
 void nvmet_req_uninit(struct nvmet_req *req);
-bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len);
+bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
 int nvmet_req_alloc_sgl(struct nvmet_req *req);
 void nvmet_req_free_sgl(struct nvmet_req *req);
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
