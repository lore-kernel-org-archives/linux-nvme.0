Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC837C7EE22
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MBnj2lFa+PB4bOPosEwzuAw3ZW4WfbS6upUcJq1uNTI=; b=BkWmIKmHcau3pcPDtTZ3OpKA7W
	mRLXrDZr+149rmq9qJMv/MiO0407jkuvi1ez62D4o/pGXhMiEOFP+ptK2IrFEcxL6KkIFK5ynNxS7
	hGiucI/v4TaK1WIC5w5Y2yCQR8RfShGOSncZDeNTrG7ZYmYNpR4i8n5cugVNBQR6Udd+KFnULsXaA
	CO6WRzHSsuiVuzl8s3ezk4yeq0EWWxhZzBjJHRECGdiVCZh0GVCiWITQOGzrL/tB0loYu+yVMvitc
	CRGTbmyzsKlQOj4dep0790Nujzpc8dv/1/+8UKqVwmhOwIwpH79zvLuHvE2gEc7sjwGQio00V+DUL
	kiK7ssJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyXlr-002Bib-22;
	Mon, 15 May 2023 12:57:47 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyXlm-002Bgu-0E
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 12:57:43 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso18740001a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 15 May 2023 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684155459; x=1686747459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBnj2lFa+PB4bOPosEwzuAw3ZW4WfbS6upUcJq1uNTI=;
        b=JsNN5O2Ztvssh2QEpi9nbfl/t9Sn3wkwVm3DmD2Z12g9RFC+Hkr7AQPTrknfPKL7RI
         iAvvhEIyzfD/UWYOlTyVzaeVZLlnBJxLtGwqN73pfKqDlVVXZPebFEoxd1ddUpDInV3q
         CXFhjKNEhDRcwisQ3p8TZyZGk1QnfW1RRaxqi7kolzEqR2yvKd4uvh5YgjoE30hJTPch
         Dd+qUMrHnWHEZS9fpjt5gO4JUrJHms5G6tQpzUVEgmmMPrH8hE1liHC8NZ0lFL1Agu/n
         thH7plw9sbTROyM2NnHspOU9UKqYmGRv1uRroxP1GCtTsaMv5xsBhv+g7QbyfWdD4ux1
         7bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155459; x=1686747459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBnj2lFa+PB4bOPosEwzuAw3ZW4WfbS6upUcJq1uNTI=;
        b=GJilMubPk6u9eFr5aGP8tlMw+0PWog99RJkdmAF/oF+L+JCCHyHkw8IG0S2jQ77P/h
         3gO9HlaUx1raS7N4lnDudakMF/eFX9BEemxIOv5z8Ndzkvsy6j93SkC2gSkk7eeG6rap
         e8qeqAAZJ/Qja0OCTaspcgcKLMAeeRwKcbwnUKG1M63y+bZD94m2O7GGcIjfu5MDN9zi
         Pg+XH+gFfIlkGJCpLHeHKWFOMhORYeHcjkxJj7khyvxNMnZZ6+S7v+PVEmOs3U5uC7YS
         rvTKcl0dvCybkyzhhA3dLpqb60R/JCaObPqs3ps/964+LvF0qTkVXhdWEjzN/D1LlqOa
         XKVw==
X-Gm-Message-State: AC+VfDyJTIiU/vhKoeZC+v7O8Ig1ARzSYl5Zfuhe5iiylepODTp8Snix
	koYTrDcgV827TuuoFRBSOCFC1L4N18Q=
X-Google-Smtp-Source: ACHHUZ4Tu3v8GwHhl2ppjKrwpi6gObiB3V9WdWreNVleJpQ6F0XBMVo3hvhxBZLu7ZUQ++IdKXq2gw==
X-Received: by 2002:a17:907:c26:b0:966:238a:c93 with SMTP id ga38-20020a1709070c2600b00966238a0c93mr30248914ejc.68.1684155458787;
        Mon, 15 May 2023 05:57:38 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::2:6366])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090672cd00b0096ace7ae086sm4003685ejl.174.2023.05.15.05.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:57:38 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org,
	axboe@kernel.dk
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	joshi.k@samsung.com,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-next 1/2] io_uring/cmd: add cmd lazy tw wake helper
Date: Mon, 15 May 2023 13:54:42 +0100
Message-Id: <5b9f6716006df7e817f18bd555aee2f8f9c8b0c3.1684154817.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1684154817.git.asml.silence@gmail.com>
References: <cover.1684154817.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_055742_112120_E1DE55D7 
X-CRM114-Status: GOOD (  11.21  )
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

We want to use IOU_F_TWQ_LAZY_WAKE in commands. First, introduce a new
cmd tw helper accepting TWQ flags, and then add
io_uring_cmd_do_in_task_laz() that will pass IOU_F_TWQ_LAZY_WAKE and
imply the "lazy" semantics, i.e. it posts no more than 1 CQE and
delaying execution of this tw should not prevent forward progress.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_uring.h | 18 ++++++++++++++++--
 io_uring/uring_cmd.c     | 16 ++++++++++++----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 7fe31b2cd02f..bb9c666bd584 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -46,13 +46,23 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter, void *ioucmd);
 void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2,
 			unsigned issue_flags);
-void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
-			void (*task_work_cb)(struct io_uring_cmd *, unsigned));
 struct sock *io_uring_get_socket(struct file *file);
 void __io_uring_cancel(bool cancel_all);
 void __io_uring_free(struct task_struct *tsk);
 void io_uring_unreg_ringfd(void);
 const char *io_uring_get_opcode(u8 opcode);
+void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
+			    void (*task_work_cb)(struct io_uring_cmd *, unsigned),
+			    unsigned flags);
+/* users should follow semantics of IOU_F_TWQ_LAZY_WAKE */
+void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
+			void (*task_work_cb)(struct io_uring_cmd *, unsigned));
+
+static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
+			void (*task_work_cb)(struct io_uring_cmd *, unsigned))
+{
+	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
+}
 
 static inline void io_uring_files_cancel(void)
 {
@@ -85,6 +95,10 @@ static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			void (*task_work_cb)(struct io_uring_cmd *, unsigned))
 {
 }
+static inline void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
+			void (*task_work_cb)(struct io_uring_cmd *, unsigned))
+{
+}
 static inline struct sock *io_uring_get_socket(struct file *file)
 {
 	return NULL;
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 5e32db48696d..476c7877ce58 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -20,16 +20,24 @@ static void io_uring_cmd_work(struct io_kiocb *req, struct io_tw_state *ts)
 	ioucmd->task_work_cb(ioucmd, issue_flags);
 }
 
-void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
-			void (*task_work_cb)(struct io_uring_cmd *, unsigned))
+void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
+			void (*task_work_cb)(struct io_uring_cmd *, unsigned),
+			unsigned flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
 
 	ioucmd->task_work_cb = task_work_cb;
 	req->io_task_work.func = io_uring_cmd_work;
-	io_req_task_work_add(req);
+	__io_req_task_work_add(req, flags);
+}
+EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
+
+void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
+			void (*task_work_cb)(struct io_uring_cmd *, unsigned))
+{
+	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, IOU_F_TWQ_LAZY_WAKE);
 }
-EXPORT_SYMBOL_GPL(io_uring_cmd_complete_in_task);
+EXPORT_SYMBOL_GPL(io_uring_cmd_do_in_task_lazy);
 
 static inline void io_req_set_cqe32_extra(struct io_kiocb *req,
 					  u64 extra1, u64 extra2)
-- 
2.40.0


