Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29363C98328
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Sep 2026 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2PHA9lRTx0uew2WK+C5V4P+aMkoUSJSDx4Loy7FcgOs=; b=Iwjca13iSdYRhzmBACi80pUCki
	eXKDGxhBJypOdUU1YG7i5pur5ulYo+1xpEu81m0UWYxXGvYJDHc7SM2urPhGqi/rjom4RdzZa6Knw
	f1HKzvabQwUVCrODldgjVs6ZdbNLG5Mwq+gqUnj20vPAAvNVA/jlqTjQ8cu87iaMqNK5BSBZ7cT8E
	QO0QuxyzycpNkyyfT2hEux0HtKwTgDRmOoqSk5nIp+G5hshzxWfX8UMj4KO8l1c3xmW4LKvNbP4Fo
	OS6vPmn0S1OtlXjTibzwMuNNvtGJLgCeJ6l3ds3PCDbESQuQGzxRJS/WKNgBa8TGTt9rZiJ2Sp8h0
	jjZ3Ws/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAObg-0000000FCAs-3SzH;
	Sat, 26 Sep 2026 09:22:08 +0000
Received: from mail-m155101.qiye.163.com ([101.71.155.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAObb-0000000FC89-2WR3
	for linux-nvme@lists.infradead.org;
	Sat, 26 Sep 2026 09:22:05 +0000
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f2ff7126;
	Sat, 26 Sep 2026 17:22:01 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
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
Subject: [PATCH v6 4/4] scsi: target: pin db_root for metadata writes
Date: Sat, 26 Sep 2026 17:21:48 +0800
Message-Id: <20260926092148.128937-5-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926092148.128937-1-runyu.xiao@seu.edu.cn>
References: <20260926092148.128937-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0dd0582d403a1kunmac953e9e17aa30
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSx1JVhpIGEtOTE1MGB9LS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YnquKONDQCpLVnGzPTqDUCfhvU33k2zrtODmrABH46QXNDUddiagOPc5EhzPrplUitGG4yYCu7yzsYuVVTBA0WhHP7pyPPZabaD1g5GJlLdK30F+vopxQcR7vbUb44mH0v9XTIdF3BQXLVNebs5BnU5uLN/cQrtistpcvckiGB8=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=2PHA9lRTx0uew2WK+C5V4P+aMkoUSJSDx4Loy7FcgOs=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260926_022203_867418_8FD8C1E2 
X-CRM114-Status: GOOD (  22.89  )
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

ALUA and persistent reservation metadata files are derived from the
configurable db_root string and opened with filp_open().  If db_root
points at configfs, a metadata update from a configfs store callback can
re-enter configfs while the callback still holds frag_sem.

A one-time pathname check can also be bypassed by retargeting a symlink.
Resolve db_root once and retain the resulting path while target devices
use it.  Use configfs_open_root() both to reject configfs roots and to
open metadata files relative to the pinned root.

Resolve a new root outside target_devices_lock and recheck the device count
before publishing it, so the path walk does not occur under that lock.

Fixes: fdddf932269a ("target: use new "dbroot" target attribute")
Link: https://lore.kernel.org/r/20260818051442.1523210-1-runyu.xiao@seu.edu.cn
Cc: stable@vger.kernel.org
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/target/target_core_alua.c     |  42 +++++-----
 drivers/target/target_core_configfs.c | 116 ++++++++++++++++++++------
 drivers/target/target_core_internal.h |   3 +
 drivers/target/target_core_pr.c       |  21 +++--
 4 files changed, 127 insertions(+), 55 deletions(-)

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index 140154d93c430..601581f2071ff 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -18,7 +18,6 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
-#include <linux/fs_struct.h>
 #include <linux/kthread.h>
 #include <scsi/scsi_proto.h>
 #include <linux/unaligned.h>
@@ -862,20 +861,23 @@ static int core_alua_write_tpg_metadata(
 	loff_t pos = 0;
 	int ret;
 
-	if (tsk_is_kthread(current)) {
-		scoped_with_init_fs()
-			file = filp_open(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
-	} else {
-		file = filp_open(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
+	if (!db_root_path.dentry) {
+		pr_err("db_root is not initialized for ALUA metadata path: %s/%s\n",
+		       db_root, path);
+		return -ENODEV;
 	}
 
+	file = configfs_open_root(&db_root_path, path,
+				  O_RDWR | O_CREAT | O_TRUNC, 0600);
 	if (IS_ERR(file)) {
-		pr_err("filp_open(%s) for ALUA metadata failed\n", path);
+		pr_err("configfs_open_root(%s/%s) for ALUA metadata failed\n",
+		       db_root, path);
 		return -ENODEV;
 	}
 	ret = kernel_write(file, md_buf, md_buf_len, &pos);
 	if (ret < 0)
-		pr_err("Error writing ALUA metadata file: %s\n", path);
+		pr_err("Error writing ALUA metadata file: %s/%s\n", db_root,
+		       path);
 	fput(file);
 	return (ret < 0) ? -EIO : 0;
 }
@@ -905,9 +907,9 @@ static int core_alua_update_tpg_primary_metadata(
 			tg_pt_gp->tg_pt_gp_alua_access_status);
 
 	rc = -ENOMEM;
-	path = kasprintf(GFP_KERNEL, "%s/alua/tpgs_%s/%s", db_root,
-			&wwn->unit_serial[0],
-			config_item_name(&tg_pt_gp->tg_pt_gp_group.cg_item));
+	path = kasprintf(GFP_KERNEL, "alua/tpgs_%s/%s",
+			 &wwn->unit_serial[0],
+			 config_item_name(&tg_pt_gp->tg_pt_gp_group.cg_item));
 	if (path) {
 		rc = core_alua_write_tpg_metadata(path, md_buf, len);
 		kfree(path);
@@ -1196,16 +1198,16 @@ static int core_alua_update_tpg_secondary_metadata(struct se_lun *lun)
 			lun->lun_tg_pt_secondary_stat);
 
 	if (se_tpg->se_tpg_tfo->tpg_get_tag != NULL) {
-		path = kasprintf(GFP_KERNEL, "%s/alua/%s/%s+%hu/lun_%llu",
-				db_root, se_tpg->se_tpg_tfo->fabric_name,
-				se_tpg->se_tpg_tfo->tpg_get_wwn(se_tpg),
-				se_tpg->se_tpg_tfo->tpg_get_tag(se_tpg),
-				lun->unpacked_lun);
+		path = kasprintf(GFP_KERNEL, "alua/%s/%s+%hu/lun_%llu",
+				 se_tpg->se_tpg_tfo->fabric_name,
+				 se_tpg->se_tpg_tfo->tpg_get_wwn(se_tpg),
+				 se_tpg->se_tpg_tfo->tpg_get_tag(se_tpg),
+				 lun->unpacked_lun);
 	} else {
-		path = kasprintf(GFP_KERNEL, "%s/alua/%s/%s/lun_%llu",
-				db_root, se_tpg->se_tpg_tfo->fabric_name,
-				se_tpg->se_tpg_tfo->tpg_get_wwn(se_tpg),
-				lun->unpacked_lun);
+		path = kasprintf(GFP_KERNEL, "alua/%s/%s/lun_%llu",
+				 se_tpg->se_tpg_tfo->fabric_name,
+				 se_tpg->se_tpg_tfo->tpg_get_wwn(se_tpg),
+				 lun->unpacked_lun);
 	}
 	if (!path) {
 		rc = -ENOMEM;
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 2b19a956007b7..db1c56835f077 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -96,7 +96,41 @@ static ssize_t target_core_item_version_show(struct config_item *item,
 CONFIGFS_ATTR_RO(target_core_item_, version);
 
 char db_root[DB_ROOT_LEN] = DB_ROOT_DEFAULT;
-static char db_root_stage[DB_ROOT_LEN];
+struct path db_root_path;
+
+static int target_validate_db_root(const char *path_str, struct path *path)
+{
+	struct file *file;
+	int ret;
+
+	ret = kern_path(path_str, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, path);
+	if (ret) {
+		pr_err("db_root: cannot open: %s\n", path_str);
+		if (ret == -ENOTDIR)
+			pr_err("db_root: not a directory: %s\n", path_str);
+		return ret;
+	}
+
+	file = configfs_open_root(path, "", O_RDONLY, 0);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		path_put(path);
+		*path = (struct path){};
+		if (ret != -EINVAL)
+			return ret;
+
+		pr_err("db_root: configfs is not a valid target database root: %s\n",
+		       path_str);
+		return -EINVAL;
+	}
+
+	path_put(path);
+	*path = file->f_path;
+	path_get(path);
+	fput(file);
+
+	return 0;
+}
 
 static ssize_t target_core_item_dbroot_show(struct config_item *item,
 					    char *page)
@@ -107,46 +141,70 @@ static ssize_t target_core_item_dbroot_show(struct config_item *item,
 static ssize_t target_core_item_dbroot_store(struct config_item *item,
 					const char *page, size_t count)
 {
+	char *db_root_stage;
 	ssize_t read_bytes;
 	ssize_t r = -EINVAL;
 	struct path path = {};
+	struct path old_path = {};
+	bool have_old_path = false;
 
 	mutex_lock(&target_devices_lock);
 	if (target_devices) {
 		pr_err("db_root: cannot be changed because it's in use\n");
-		goto unlock;
+		mutex_unlock(&target_devices_lock);
+		return r;
 	}
+	mutex_unlock(&target_devices_lock);
 
 	if (count > (DB_ROOT_LEN - 1)) {
 		pr_err("db_root: count %d exceeds DB_ROOT_LEN-1: %u\n",
 		       (int)count, DB_ROOT_LEN - 1);
-		goto unlock;
+		return r;
 	}
 
+	db_root_stage = kmalloc(DB_ROOT_LEN, GFP_KERNEL);
+	if (!db_root_stage)
+		return -ENOMEM;
+
 	read_bytes = scnprintf(db_root_stage, DB_ROOT_LEN, "%s", page);
 	if (!read_bytes)
-		goto unlock;
+		goto free_stage;
 
 	if (db_root_stage[read_bytes - 1] == '\n')
 		db_root_stage[read_bytes - 1] = '\0';
 
 	/* validate new db root before accepting it */
-	r = kern_path(db_root_stage, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
-	if (r) {
-		pr_err("db_root: cannot open: %s\n", db_root_stage);
-		if (r == -ENOTDIR)
-			pr_err("db_root: not a directory: %s\n", db_root_stage);
-		goto unlock;
+	r = target_validate_db_root(db_root_stage, &path);
+	if (r)
+		goto free_stage;
+
+	mutex_lock(&target_devices_lock);
+	if (target_devices) {
+		pr_err("db_root: cannot be changed because it's in use\n");
+		goto unlock_put;
 	}
-	path_put(&path);
 
+	have_old_path = db_root_path.dentry;
+	if (have_old_path)
+		old_path = db_root_path;
+	db_root_path = path;
+	path = (struct path){};
 	strscpy(db_root, db_root_stage);
 	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
 
 	r = read_bytes;
 
-unlock:
+unlock_put:
 	mutex_unlock(&target_devices_lock);
+	if (path.dentry)
+		path_put(&path);
+	if (have_old_path)
+		path_put(&old_path);
+	kfree(db_root_stage);
+	return r;
+
+free_stage:
+	kfree(db_root_stage);
 	return r;
 }
 
@@ -3722,21 +3780,20 @@ void target_setup_backend_cits(struct target_backend *tb)
 
 static void target_init_dbroot(void)
 {
-	struct file *fp;
+	const char *db_root_stage;
+	struct path path = {};
+	int ret;
 
-	snprintf(db_root_stage, DB_ROOT_LEN, DB_ROOT_PREFERRED);
-	fp = filp_open(db_root_stage, O_RDONLY, 0);
-	if (IS_ERR(fp)) {
-		pr_err("db_root: cannot open: %s\n", db_root_stage);
-		return;
-	}
-	if (!S_ISDIR(file_inode(fp)->i_mode)) {
-		filp_close(fp, NULL);
-		pr_err("db_root: not a valid directory: %s\n", db_root_stage);
-		return;
+	db_root_stage = DB_ROOT_PREFERRED;
+	ret = target_validate_db_root(db_root_stage, &path);
+	if (ret) {
+		db_root_stage = DB_ROOT_DEFAULT;
+		ret = target_validate_db_root(db_root_stage, &path);
+		if (ret)
+			return;
 	}
-	filp_close(fp, NULL);
 
+	db_root_path = path;
 	strscpy(db_root, db_root_stage);
 	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
 }
@@ -3797,6 +3854,10 @@ static int __init target_core_init_configfs(void)
 	/*
 	 * Register the target_core_mod subsystem with configfs.
 	 */
+	/* Resolve db_root before making the configfs attributes visible. */
+	scoped_with_kernel_creds()
+		target_init_dbroot();
+
 	ret = configfs_register_subsystem(subsys);
 	if (ret < 0) {
 		pr_err("Error %d while registering subsystem %s\n",
@@ -3821,9 +3882,6 @@ static int __init target_core_init_configfs(void)
 	if (ret < 0)
 		goto out;
 
-	scoped_with_kernel_creds()
-		target_init_dbroot();
-
 	return 0;
 
 out:
@@ -3832,6 +3890,8 @@ static int __init target_core_init_configfs(void)
 	core_dev_release_virtual_lun0();
 	rd_module_exit();
 out_global:
+	if (db_root_path.dentry)
+		path_put(&db_root_path);
 	if (default_lu_gp) {
 		core_alua_free_lu_gp(default_lu_gp);
 		default_lu_gp = NULL;
@@ -3861,6 +3921,8 @@ static void __exit target_core_exit_configfs(void)
 	core_dev_release_virtual_lun0();
 	rd_module_exit();
 	target_xcopy_release_pt();
+	if (db_root_path.dentry)
+		path_put(&db_root_path);
 	release_se_kmem_caches();
 }
 
diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
index f0886ea290345..c3e55f60cfb11 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -171,6 +171,9 @@ extern struct se_portal_group xcopy_pt_tpg;
 #define	DB_ROOT_DEFAULT		"/var/target"
 #define	DB_ROOT_PREFERRED	"/etc/target"
 
+struct path;
+
 extern char db_root[];
+extern struct path db_root_path;
 
 #endif /* TARGET_CORE_INTERNAL_H */
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 25b1bcacc0c8f..0628622d916ba 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -18,7 +18,6 @@
 #include <linux/file.h>
 #include <linux/fcntl.h>
 #include <linux/fs.h>
-#include <linux/fs_struct.h>
 #include <scsi/scsi_proto.h>
 #include <linux/unaligned.h>
 
@@ -1965,16 +1964,21 @@ static int __core_scsi3_write_aptpl_to_file(
 	int ret;
 	loff_t pos = 0;
 
-	path = kasprintf(GFP_KERNEL, "%s/pr/aptpl_%s", db_root,
-			&wwn->unit_serial[0]);
+	path = kasprintf(GFP_KERNEL, "pr/aptpl_%s", &wwn->unit_serial[0]);
 	if (!path)
 		return -ENOMEM;
 
-	scoped_with_init_fs()
-		file = filp_open(path, flags, 0600);
+	if (!db_root_path.dentry) {
+		pr_err("db_root is not initialized for APTPL metadata path: %s/%s\n",
+		       db_root, path);
+		kfree(path);
+		return -ENODEV;
+	}
+
+	file = configfs_open_root(&db_root_path, path, flags, 0600);
 	if (IS_ERR(file)) {
-		pr_err("filp_open(%s) for APTPL metadata"
-			" failed\n", path);
+		pr_err("configfs_open_root(%s/%s) for APTPL metadata failed\n",
+		       db_root, path);
 		kfree(path);
 		return PTR_ERR(file);
 	}
@@ -1984,7 +1988,8 @@ static int __core_scsi3_write_aptpl_to_file(
 	ret = kernel_write(file, buf, pr_aptpl_buf_len, &pos);
 
 	if (ret < 0)
-		pr_debug("Error writing APTPL metadata file: %s\n", path);
+		pr_debug("Error writing APTPL metadata file: %s/%s\n", db_root,
+			 path);
 	fput(file);
 	kfree(path);
 
-- 
2.34.1


