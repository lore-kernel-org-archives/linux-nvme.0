Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0897C7EE2E
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Apr 2023 14:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k23ex7RimvLu0p4j9qUercROahTdeSFRLj0ExynF2G0=; b=X95EvOlPS63BaZ7IsHCxF0JeeC
	tKG/AVtzLUCEHS6bot9OZ0IXkEJMvZCxc1lQQUvOimwHh/hxNDh0S0kwZNESaF0/MmK8TFyGjwF7c
	NGJBGHK4rw7OnvyKBrBhaDsjPeCqbyils5pMJSmGooyyw5U4gi3pN09T9Q9YJ3Z7gEP7axwpk5Pea
	l6dnER02QNU+3afdGIS+pvpTqijazetEK6wpAccsczs1+rrvGzCP0UBPNgTCjQlTMZNqvi79+ORir
	AzZSpz6LXlmcV2a5QhTegNMeooAECjSz1SQMJujPIc9YQ0N5njVA+oAROU+5WGxpq7CKM+r2JFeN4
	Ps/BPYrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pt89v-00EHqy-2V;
	Sun, 30 Apr 2023 14:36:15 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pt89q-00EHoT-39
	for linux-nvme@lists.infradead.org;
	Sun, 30 Apr 2023 14:36:12 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f19afc4fd8so8602535e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Apr 2023 07:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682865370; x=1685457370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k23ex7RimvLu0p4j9qUercROahTdeSFRLj0ExynF2G0=;
        b=iHTIX0W7ARaVWLk01XO02mycyIaL0SHzg51HTqbWlbolPcdDJi/IlcwIVQAO0aCpzB
         x4GrREwSuiv9Siq+/ZET643ynnrm5AoAMT3FnCH/+0rBPX/Aur31i3epzTGNhSjPJG7f
         8Z1U59EMbMzg95oYk4XtCtj3iolrjxP00Ykbaa3mMIZlmgIxNb6BrRtf+EmdgsHHTlYI
         PF2j2Odf5/I2enFHRNDRsi8EUVyer9U00CDHOrNONp5IaeoA/eXxSvY6KIx1/KtLuVSm
         tY4QP2QbdYxguNhKr+2we/mXwnkl3PMm3qvdQzjvTwVQkSb0oGoJruTdFNvoqPnYA+P3
         N2eA==
X-Gm-Message-State: AC+VfDw4QiR4tQ6H2bwf6+RY9gsMUQfvhws4MT6xjRla2i10AOm2BieC
	YDyZhp6KOcAsHyTf0e34bDA=
X-Google-Smtp-Source: ACHHUZ6NgjI8hY5U0kWNOftPpVXFnZaxTEqy883QrKbYdbf0y3frSWyb1AyUSwVJtyIG0msFLmmX8g==
X-Received: by 2002:a7b:c047:0:b0:3f1:7a44:317c with SMTP id u7-20020a7bc047000000b003f17a44317cmr8613355wmc.24.1682865369774;
        Sun, 30 Apr 2023 07:36:09 -0700 (PDT)
Received: from localhost (fwdproxy-cln-026.fbsv.net. [2a03:2880:31ff:1a::face:b00c])
        by smtp.gmail.com with ESMTPSA id r3-20020adfda43000000b003047ae72b14sm17707286wrl.82.2023.04.30.07.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 07:36:09 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	asml.silence@gmail.com,
	axboe@kernel.dk,
	ming.lei@redhat.com
Cc: leit@fb.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	sagi@grimberg.me,
	joshi.k@samsung.com,
	hch@lst.de,
	kbusch@kernel.org
Subject: [PATCH v3 4/4] block: ublk_drv: Add a helper instead of casting
Date: Sun, 30 Apr 2023 07:35:32 -0700
Message-Id: <20230430143532.605367-5-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230430143532.605367-1-leitao@debian.org>
References: <20230430143532.605367-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230430_073611_021917_B10A7F7F 
X-CRM114-Status: GOOD (  12.45  )
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

ublk driver is using casts to get private data from uring cmd struct.
Let's use a proper helper, as an interface that requires casts in all
callers is one asking for bugs.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/block/ublk_drv.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ec23a3c9fac8..1fa6a4d54d6d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1261,9 +1261,21 @@ static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
 	ublk_queue_cmd(ubq, req);
 }
 
+static inline struct ublksrv_ctrl_cmd *ublk_uring_ctrl_cmd(
+		struct io_uring_cmd *cmd)
+{
+	return (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
+}
+
+static inline struct ublksrv_io_cmd *ublk_uring_io_cmd(
+		struct io_uring_cmd *cmd)
+{
+	return (struct ublksrv_io_cmd *)cmd->sqe->cmd;
+}
+
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
-	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->sqe->cmd;
+	struct ublksrv_io_cmd *ub_cmd = ublk_uring_io_cmd(cmd);
 	struct ublk_device *ub = cmd->file->private_data;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
@@ -1567,7 +1579,7 @@ static struct ublk_device *ublk_get_device_from_id(int idx)
 
 static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
+	struct ublksrv_ctrl_cmd *header = ublk_uring_ctrl_cmd(cmd);
 	int ublksrv_pid = (int)header->data[0];
 	struct gendisk *disk;
 	int ret = -EINVAL;
@@ -1630,7 +1642,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 static int ublk_ctrl_get_queue_affinity(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
+	struct ublksrv_ctrl_cmd *header = ublk_uring_ctrl_cmd(cmd);
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	cpumask_var_t cpumask;
 	unsigned long queue;
@@ -1681,7 +1693,7 @@ static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
 
 static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
+	struct ublksrv_ctrl_cmd *header = ublk_uring_ctrl_cmd(cmd);
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublksrv_ctrl_dev_info info;
 	struct ublk_device *ub;
@@ -1844,7 +1856,7 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub)
 
 static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
+	struct ublksrv_ctrl_cmd *header = ublk_uring_ctrl_cmd(cmd);
 
 	pr_devel("%s: cmd_op %x, dev id %d qid %d data %llx buf %llx len %u\n",
 			__func__, cmd->cmd_op, header->dev_id, header->queue_id,
@@ -1863,7 +1875,7 @@ static int ublk_ctrl_stop_dev(struct ublk_device *ub)
 static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
+	struct ublksrv_ctrl_cmd *header = ublk_uring_ctrl_cmd(cmd);
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 
 	if (header->len < sizeof(struct ublksrv_ctrl_dev_info) || !header->addr)
@@ -1894,7 +1906,7 @@ static void ublk_ctrl_fill_params_devt(struct ublk_device *ub)
 static int ublk_ctrl_get_params(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
+	struct ublksrv_ctrl_cmd *header = ublk_uring_ctrl_cmd(cmd);
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublk_params_header ph;
 	int ret;
@@ -1925,7 +1937,7 @@ static int ublk_ctrl_get_params(struct ublk_device *ub,
 static int ublk_ctrl_set_params(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
+	struct ublksrv_ctrl_cmd *header = ublk_uring_ctrl_cmd(cmd);
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublk_params_header ph;
 	int ret = -EFAULT;
@@ -1983,7 +1995,7 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
+	struct ublksrv_ctrl_cmd *header = ublk_uring_ctrl_cmd(cmd);
 	int ret = -EINVAL;
 	int i;
 
@@ -2025,7 +2037,7 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
+	struct ublksrv_ctrl_cmd *header = ublk_uring_ctrl_cmd(cmd);
 	int ublksrv_pid = (int)header->data[0];
 	int ret = -EINVAL;
 
@@ -2092,7 +2104,7 @@ static int ublk_char_dev_permission(struct ublk_device *ub,
 static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
+	struct ublksrv_ctrl_cmd *header = ublk_uring_ctrl_cmd(cmd);
 	bool unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	char *dev_path = NULL;
@@ -2171,7 +2183,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
+	struct ublksrv_ctrl_cmd *header = ublk_uring_ctrl_cmd(cmd);
 	struct ublk_device *ub = NULL;
 	int ret = -EINVAL;
 
-- 
2.34.1


