Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69249C88E41
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 04:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WNhizG42jNgFw5zLdHr3DZPLKap23a4IhuZPG0ipX6E=; b=Pf/PCdY8zeou3AwvyCmTw7ZNDb
	CspIm11g1HBwqqNphJ439LZqCkY/zMbXZpZv/3Roo/KMWCf8/+Z/SV403m4P5UB8h6UV/qm08XJ4p
	zKGwOGR54JFhTmi21ttukEDNX2Flc4tilDbYKujclgjdc/2Fw9IJIRis8C985sXuZIEzeEys6AznS
	jxuJkVUm84EvhhNsWgXOo22ZAPvtU5XkWeXt+6OC3XKAyZzKlKwR9FXGNOXeEuDjkJyilOJSOnh9x
	s6F9sSCMDNWBVHNS5UnCequoiRFCwC7DKwJ2/zvMwtQQBoCOzD2MMSXa4ok9qhK21JxTUzc6/hsNz
	kxZVgqhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Wnn-0000000DPDU-0zvg;
	Thu, 10 Sep 2026 04:54:23 +0000
Received: from mail-m155101.qiye.163.com ([101.71.155.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Wnj-0000000DPAe-2rlw
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 04:54:21 +0000
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d3a5a3c9;
	Thu, 10 Sep 2026 12:54:09 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v3 1/3] fs: configfs: add helper to identify configfs paths
Date: Thu, 10 Sep 2026 12:53:58 +0800
Message-Id: <20260910045400.1201582-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910045400.1201582-1-runyu.xiao@seu.edu.cn>
References: <20260902103202.GB8095@lst.de>
 <20260910045400.1201582-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa089aa866303a1kunm413fe85d18135b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkJCVk1PSk0YShlDSRgdTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pOTE5VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bSkdwyPIcJ3stD5RnvEHmBu4J8+aXeueNw7X0bCyuiDoWWKPxbu8raIot9k1oHoO0PBVBccZ/WevE9Z9hRhvQNWHqM6SYF6Hic9+NcocCi6lkkDNa7sq2ofxusZIsS+YmiApuSuPY5gnvSnC1yiUJGjTSGVEFjx+7TCdBb+QUaE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=WNhizG42jNgFw5zLdHr3DZPLKap23a4IhuZPG0ipX6E=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_215419_917384_7828A98C 
X-CRM114-Status: UNSURE (   9.81  )
X-CRM114-Notice: Please train this message.
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

Keep the configfs filesystem type check in configfs so callers can
classify resolved paths without comparing filesystem name strings or
using filesystem-specific magic numbers.

Export the helper for configfs users that need to reject paths into the
configuration filesystem while running from a configfs callback.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 fs/configfs/mount.c      | 6 ++++++
 include/linux/configfs.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index d8cac1cbf..8abbe3afa 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -118,6 +118,12 @@ static struct file_system_type configfs_fs_type = {
 };
 MODULE_ALIAS_FS("configfs");
 
+bool configfs_path_is_configfs(const struct path *path)
+{
+	return path->dentry->d_sb->s_type == &configfs_fs_type;
+}
+EXPORT_SYMBOL_GPL(configfs_path_is_configfs);
+
 struct dentry *configfs_pin_fs(void)
 {
 	int err = simple_pin_fs(&configfs_fs_type, &configfs_mount,
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index ef65c75be..55df734da 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -34,6 +34,7 @@ struct configfs_group_operations;
 struct configfs_attribute;
 struct configfs_bin_attribute;
 struct configfs_subsystem;
+struct path;
 
 struct config_item {
 	char			*ci_name;
@@ -243,6 +244,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys);
 int configfs_register_group(struct config_group *parent_group,
 			    struct config_group *group);
 void configfs_unregister_group(struct config_group *group);
+bool configfs_path_is_configfs(const struct path *path);
 
 void configfs_remove_default_groups(struct config_group *group);
 
-- 
2.34.1

