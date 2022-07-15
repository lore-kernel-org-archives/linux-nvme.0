Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F39ACCA483
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 19:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rbp/Y/4RSQ9upVQB8iDU2lcc+SWPHydaNMyD3YYmTG0=; b=sOGqGQG9zSRizyrKkBu97G6jrN
	9m7kKtTWcyUmhDI53FXhbdh+BVaiM6c0TGSL9/mwH+xFYOX0czRciqa4X+p7O2ASaoQZb7EpItbG+
	HeZwPPEbZNg68Uh7eL1tJOu73M5WOfzfcz4vBEV0AaMhzI4MygeOZLWA8ZWZUju+ugko8kIlepau+
	DWIMMJgvZm8FKgGWAf7YaMTgU8VxnkW2f3nnuQCJYNo8LCqGJ1IyGG/gp9KgSMa3gTNlsX9stiT51
	hbygzUzpLMTAAY1ACs7RoqjbibpmFo45TScONKawOzSG/gx2OWssZ8yMBKRugk0eqsNX1J/11mJEf
	B/+pEuDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCQnZ-009h4G-5G; Fri, 15 Jul 2022 19:16:25 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCQnX-009h3z-9d; Fri, 15 Jul 2022 19:16:23 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk,
	casey@schaufler-ca.com,
	paul@paul-moore.com,
	joshi.k@samsung.com,
	linux-security-module@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	a.manzanares@samsung.com,
	javier@javigon.com,
	mcgrof@kernel.org
Subject: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file op
Date: Fri, 15 Jul 2022 12:16:22 -0700
Message-Id: <20220715191622.2310436-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
add infrastructure for uring-cmd"), this extended the struct
file_operations to allow a new command which each subsystem can use
to enable command passthrough. Add an LSM specific for the command
passthrough which enables LSMs to inspect the command details.

This was discussed long ago without no clear pointer for something
conclusive, so this enables LSMs to at least reject this new file
operation.

[0] https://lkml.kernel.org/r/8adf55db-7bab-f59d-d612-ed906b948d19@schaufler-ca.com

Fixes: ee692a21e9bf ("fs,io_uring: add infrastructure for uring-cmd")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
Changes on v2:

 - Added Fixes tag as requested by Paul Moore

 - Moved the security_uring_cmd() check after checking
   for req->file->f_op->uring_cmd as suggested by Paul Moore

 include/linux/lsm_hook_defs.h | 1 +
 include/linux/lsm_hooks.h     | 3 +++
 include/linux/security.h      | 5 +++++
 io_uring/uring_cmd.c          | 5 +++++
 security/security.c           | 4 ++++
 5 files changed, 18 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index eafa1d2489fd..4e94755098f1 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -406,4 +406,5 @@ LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
 #ifdef CONFIG_IO_URING
 LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
 LSM_HOOK(int, 0, uring_sqpoll, void)
+LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 91c8146649f5..b681cfce6190 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1575,6 +1575,9 @@
  *      Check whether the current task is allowed to spawn a io_uring polling
  *      thread (IORING_SETUP_SQPOLL).
  *
+ * @uring_cmd:
+ *      Check whether the file_operations uring_cmd is allowed to run.
+ *
  */
 union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
diff --git a/include/linux/security.h b/include/linux/security.h
index 4d0baf30266e..421856919b1e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2053,6 +2053,7 @@ static inline int security_perf_event_write(struct perf_event *event)
 #ifdef CONFIG_SECURITY
 extern int security_uring_override_creds(const struct cred *new);
 extern int security_uring_sqpoll(void);
+extern int security_uring_cmd(struct io_uring_cmd *ioucmd);
 #else
 static inline int security_uring_override_creds(const struct cred *new)
 {
@@ -2062,6 +2063,10 @@ static inline int security_uring_sqpoll(void)
 {
 	return 0;
 }
+static inline int security_uring_cmd(struct io_uring_cmd *ioucmd)
+{
+	return 0;
+}
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_IO_URING */
 
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 0a421ed51e7e..bf76f487d525 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -3,6 +3,7 @@
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/io_uring.h>
+#include <linux/security.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -85,6 +86,10 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 	if (!req->file->f_op->uring_cmd)
 		return -EOPNOTSUPP;
 
+	ret = security_uring_cmd(ioucmd);
+	if (ret)
+		return ret;
+
 	if (ctx->flags & IORING_SETUP_SQE128)
 		issue_flags |= IO_URING_F_SQE128;
 	if (ctx->flags & IORING_SETUP_CQE32)
diff --git a/security/security.c b/security/security.c
index f85afb02ea1c..ad7d7229bd72 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2655,4 +2655,8 @@ int security_uring_sqpoll(void)
 {
 	return call_int_hook(uring_sqpoll, 0);
 }
+int security_uring_cmd(struct io_uring_cmd *ioucmd)
+{
+	return call_int_hook(uring_cmd, 0, ioucmd);
+}
 #endif /* CONFIG_IO_URING */
-- 
2.35.1


