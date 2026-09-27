Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A73BC98324
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2026 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d5JnXFH+gOpA+ULZ4kh2lFWrt905jPAi3bCsy9qIaq0=; b=p9Uqec0kbdmOKwXWmTsoVAcIZV
	+9AcqKnoMZGXCpNfyO9gqrVxeZp9+WvW0z+sR+7g69jYjg0XKgTZS8W3OQdnjW380ZNhUqmcWNp9E
	a+u9fGXzSAA4C9oRiNGxiRZsN0Y+1nFnKWweBTZBSGszFLLixmwfZw9i5IH4re1dPy3FbwvAOa8Jl
	JFwIh2gg8W3d8klWJtnM4GQX5YRY9rWVCGxbRFnWXCz2eHBEzOh78y0sBCcz4bVXw9SM5YmlcgdJ5
	10WR27q0dWmsiM6IRytUAJRmZYBJdk8y4IXj9cQ0I1sNMJIm68fAOlED84Uiy+BkHRMfjxVd1/DV5
	eJXM+cbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAk7d-0000000G8Us-3inP;
	Sun, 27 Sep 2026 08:20:33 +0000
Received: from mail-m155101.qiye.163.com ([101.71.155.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAk7a-0000000G8SE-2jg5
	for linux-nvme@lists.infradead.org;
	Sun, 27 Sep 2026 08:20:32 +0000
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f3a443fa;
	Sun, 27 Sep 2026 16:20:24 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Martin K . Petersen" <mkp@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Hannes Reinecke <hare@suse.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v7 1/4] fs: configfs: add helpers for opening non-configfs paths
Date: Sun, 27 Sep 2026 16:20:08 +0800
Message-Id: <20260927082011.638723-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260927082011.638723-1-runyu.xiao@seu.edu.cn>
References: <20260927082011.638723-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0e1f377d203a1kunm12f6b69c1ac336
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGBkZVk4aHkhJQx5LSE5CGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VZHAPQrn96pCV7pTnfuY6/AdqV/6JKT6ykY8D5GikQ0gvRv5efzXtxhlT4GRiuxYrsLq00MEmqRdTZPSxCSrdOe6wO3eAusLhf1G0blildWHc31P145qDG/tIXY7uU27DRWBe7nSzsvFiiFb2RTJim0YMOPfuPAyB+ilcU5lOzk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=d5JnXFH+gOpA+ULZ4kh2lFWrt905jPAi3bCsy9qIaq0=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_012030_917578_4257001F 
X-CRM114-Status: GOOD (  15.70  )
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

Configfs store callbacks hold frag_sem while they run.  Reopening a path
that resolves to configfs from such a callback can acquire the same
non-recursive semaphore again.

Add configfs_file_open() for configured pathnames and configfs_open_root()
for paths relative to a resolved root.  Reject configfs roots before using
file_open_root() so the normal open checks remain in place.

Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 fs/configfs/mount.c      | 57 ++++++++++++++++++++++++++++++++++++++++
 include/linux/configfs.h |  5 ++++
 2 files changed, 62 insertions(+)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index d8cac1cbf3bd5..aa79be05dd5bc 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -118,6 +119,62 @@ static struct file_system_type configfs_fs_type = {
 };
 MODULE_ALIAS_FS("configfs");
 
+/**
+ * configfs_open_root - open a path below a non-configfs root
+ * @root: resolved root path
+ * @name: path relative to @root
+ * @flags: open flags
+ * @mode: mode for a newly created file
+ *
+ * Use this from configfs store callbacks with a resolved non-configfs root
+ * to avoid re-entering configfs while the callback holds its fragment
+ * semaphore.
+ *
+ * Return: opened file, or an ERR_PTR() value.  Returns -EINVAL if @root
+ * is on configfs.
+ */
+struct file *configfs_open_root(const struct path *root, const char *name,
+				int flags, umode_t mode)
+{
+	if (root->dentry->d_sb->s_type == &configfs_fs_type)
+		return ERR_PTR(-EINVAL);
+
+	return file_open_root(root, name, flags, mode);
+}
+EXPORT_SYMBOL_GPL(configfs_open_root);
+
+/**
+ * configfs_file_open - open an existing non-configfs pathname
+ * @filename: pathname to open; it must already exist
+ * @flags: open flags for the existing pathname
+ * @mode: unused; creation is not supported
+ *
+ * Resolve @filename and reject configfs paths.  Use this from configfs
+ * store callbacks for existing configured paths.  O_NOFOLLOW is honored
+ * when resolving the final path component.
+ *
+ * Return: opened file, or an ERR_PTR() value.  Returns -EINVAL if the
+ * resolved path is on configfs.
+ */
+struct file *configfs_file_open(const char *filename, int flags, umode_t mode)
+{
+	struct file *file;
+	struct path path;
+	unsigned int lookup_flags = 0;
+	int ret;
+
+	if (!(flags & O_NOFOLLOW))
+		lookup_flags = LOOKUP_FOLLOW;
+	ret = kern_path(filename, lookup_flags, &path);
+	if (ret)
+		return ERR_PTR(ret);
+
+	file = configfs_open_root(&path, "", flags, mode);
+	path_put(&path);
+	return file;
+}
+EXPORT_SYMBOL_GPL(configfs_file_open);
+
 struct dentry *configfs_pin_fs(void)
 {
 	int err = simple_pin_fs(&configfs_fs_type, &configfs_mount,
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index ef65c75beeaad..2a803bb836b4d 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -34,6 +34,8 @@ struct configfs_group_operations;
 struct configfs_attribute;
 struct configfs_bin_attribute;
 struct configfs_subsystem;
+struct file;
+struct path;
 
 struct config_item {
 	char			*ci_name;
@@ -243,6 +245,9 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys);
 int configfs_register_group(struct config_group *parent_group,
 			    struct config_group *group);
 void configfs_unregister_group(struct config_group *group);
+struct file *configfs_open_root(const struct path *root, const char *name,
+				int flags, umode_t mode);
+struct file *configfs_file_open(const char *filename, int flags, umode_t mode);
 
 void configfs_remove_default_groups(struct config_group *group);
 
-- 
2.34.1


