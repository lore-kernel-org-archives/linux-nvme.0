Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE40C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zYlm9WNLox2kaFNQpUZgFMheB5hPrtAfLIyn5XxB4ik=; b=qrFqrWRMh8+m6MyfDEXU5xoeWk
	JX+Tdf1irdfdGFWVCsqX4zdPjHYEXRVqERxIsDzU7znmXEF+1IYWDyMXGJBKjnFr/ptMkrpT/naZS
	3RN54BsOMP/KcLWxAnyYyovtozZrab88JAMf3P2jf+PC7Lrb+mCbnucygJudCxLNARPPtv40LyCow
	Iz0ClHxGZ9L4YvEhA/5twtRuxrxoupM0BAzG9R+G5CnA6GGgZNBqA6Om/vGhQP9qXPqe1cfFEmixE
	gWtsESy52BIzqRrQh5RtPD5y+h6uuLcr51PrkW4Z4b8Dqfzh3qnhdp911J+RW9uRoih2wOMouw1Jp
	o30Z64KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiav-0000000A7uH-16id;
	Wed, 19 Aug 2026 15:52:49 +0000
Received: from mail-m155101.qiye.163.com ([101.71.155.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiar-0000000A7sn-1QaA
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:52:48 +0000
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a95ff6de;
	Wed, 19 Aug 2026 23:52:41 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v2 1/3] fs: configfs: add helper to identify configfs paths
Date: Wed, 19 Aug 2026 23:52:26 +0800
Message-Id: <20260819155228.84938-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01ab9890a03a1kunm38a93da01445bb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQxhCVk5CSUJDTEMYGB9OGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=W6UvOtxSnCsHUR6W1AH8fkpsNrYUexXjJ9zDaDbaFzvYUxx8h1E7Wk1ZxgK9OXKvXWX2b7GswVYoHCNIQuzS5FjJ/D1FDnJQF0SutYEfQb+qvdAVE608fcMEwkSwgYuDWIP+x1kh845EOaKTShiLjtpF3w5UwWt+U14FQrjvlaE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=zYlm9WNLox2kaFNQpUZgFMheB5hPrtAfLIyn5XxB4ik=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_085245_986641_292323B9 
X-CRM114-Status: UNSURE (   9.42  )
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

Several nvmet paths need to identify configfs-backed resolved paths while
already running under configfs callbacks. Keep the classification in
configfs itself so callers can reuse the filesystem-type test instead of
open-coding string comparisons.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 fs/configfs/mount.c      | 6 ++++++
 include/linux/configfs.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 456c4a2efb53..1204421b61df 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -120,6 +120,12 @@ static struct file_system_type configfs_fs_type = {
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
index 698520b1bfdb..b3426c952835 100644
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

