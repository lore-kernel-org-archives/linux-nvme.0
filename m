Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41D2CD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 08:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V5SLHhpdbZyl9tusWWV6O5Lzt31q1WSbxHxPNQ5Q3rU=; b=sA8JBm3w/tt7T6v09CV4YUEO1p
	7AH3YHZa0WqaMP6Tq5omYD//lAxFdKSPMRsxz9WBZuZLPnhAwtYlmRovqUzU5WzEfza+TakPYzjFI
	qs8+Wrvk07jF0/Jl0l1l25B9j9De7E+VX3stzOAdwW5VZRaV1KQZQKQR/KUkwAotZLiPyVJUQNQb9
	pYwxXBHrn2YlEMU59ghFi1BH0HAFXJtbZXh/R1ez34moMQ2ZrsgxLaherHKkMqpZYGMNFKn3sVcdI
	7AWx6AgFFZ2f+awAk5RdTSYb2vWqhrLOI8m3Jp6iH2UnkO23tvRJ0BlqeOgOgCiRnB+htEJvAstv9
	hCa1TnQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waUiw-00000002Adx-1TV8;
	Fri, 19 Jun 2026 08:37:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waUiu-00000002Acm-3bEd
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 08:37:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D414408AF;
	Fri, 19 Jun 2026 08:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1322B1F00A3E;
	Fri, 19 Jun 2026 08:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858232;
	bh=V5SLHhpdbZyl9tusWWV6O5Lzt31q1WSbxHxPNQ5Q3rU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MrxUvYy8IxCzqSZzdIi1KUUe30OZf+oaumibe6eaDgWB/7A/ZlpxUesjev9MkqTzn
	 j/lL0OIDXhO4xDQDi5KiVSB8eourFRrgEGjg1oHau3QPrii2OIrLKuUANORQltKuAj
	 krgFgANGB0GzYL9aWXe5VYP5MpuMv5CvjlWiym62y0YKAJoHp2rq9gzBxkAzSkJohz
	 Zh42+JTqogkyVj5jOwlsf4cyHDNNbn5cRHzxwWfZxnQjAnd1ERyjrSZe1Cb9c/PFWr
	 qHF4zd8CgKISP/9SAKRQR/DQXMZG5Xxyo1+Bdw9hRDXBf94LcY/h2NyyoxltY6WKuV
	 CP3ztzWKJ67mQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 19 Jun 2026 10:36:46 +0200
Subject: [PATCH RFC v2 06/12] fs/configfs: add superblock as attribute to
 configfs_pin_fs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-ns-v2-6-82fd7094b8dc@kernel.org>
References: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
In-Reply-To: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=3972;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=dIPCJT4QyJtDg+0wwAytETVmVOMLJhjThOdVjjY1bNM=;
 b=2LcFGGojxTBlneW2yXXNWe0fOZ2PSeJwJawbPWMrXjR1gXfPCyfmGDfJuy8aceQLi3xyOd7pS
 rX4fO60khr3Dz7ojBrvEpd/kGqCNbXb76zUg8v03rYFPZ6I/3WfIKCO
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
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

Each namspace might have its own superblock, so add it as an argument
to configfs_pin_fs() to ensure that the correct filesystem instance
will be pinned.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/dir.c        | 16 ++++++++--------
 include/linux/configfs.h |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 891238ef0088a98467d6d63a10d633a40fc19c8b..b87b92e3a248dfb091eb52727f06cc4551143f7b 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1935,7 +1935,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 		INIT_LIST_HEAD(&subsys->su_link);
 		mutex_init(&subsys->su_mutex);
 		config_group_init(&subsys->su_group);
-		err = subsys->fill_subsystem(subsys, info->ns_id);
+		err = subsys->fill_subsystem(subsys, info->net_ns);
 		if (err)
 			goto out_release;
 	}
@@ -1943,7 +1943,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	err = configfs_link_root(info, subsys, root);
 	if (err) {
 		if (subsys->clear_subsystem)
-			subsys->clear_subsystem(subsys, info->ns_id);
+			subsys->clear_subsystem(subsys, info->net_ns);
 		goto out_release;
 	}
 
@@ -1968,7 +1968,7 @@ void configfs_link_subsystems(struct super_block *sb,
 
 	if (WARN_ON(IS_ERR(parent)))
 		return;
-	if ((info->ns_id == 0) || WARN_ON(parent == info))
+	if ((info->net_ns == &init_net) || WARN_ON(parent == info))
 		return;
 	mutex_lock(&parent->subsys_mutex);
 	list_splice_init(&parent->subsys_list, &subsys_list);
@@ -1987,7 +1987,7 @@ void configfs_link_subsystems(struct super_block *sb,
 		subsys->clear_subsystem = s->clear_subsystem;
 		INIT_LIST_HEAD(&subsys->su_link);
 		mutex_init(&subsys->su_mutex);
-		err = subsys->fill_subsystem(subsys, info->ns_id);
+		err = subsys->fill_subsystem(subsys, info->net_ns);
 		if (err) {
 			kfree(subsys);
 			continue;
@@ -1995,7 +1995,7 @@ void configfs_link_subsystems(struct super_block *sb,
 		root = configfs_pin_fs(sb);
 		if (IS_ERR(root)) {
 			if (subsys->clear_subsystem)
-				subsys->clear_subsystem(subsys, info->ns_id);
+				subsys->clear_subsystem(subsys, info->net_ns);
 			kfree(subsys);
 			continue;
 		}
@@ -2003,7 +2003,7 @@ void configfs_link_subsystems(struct super_block *sb,
 		if (err) {
 			configfs_release_fs(sb);
 			if (subsys->clear_subsystem)
-				subsys->clear_subsystem(subsys, info->ns_id);
+				subsys->clear_subsystem(subsys, info->net_ns);
 			kfree(subsys);
 			continue;
 		}
@@ -2070,7 +2070,7 @@ void configfs_unlink_subsystems(struct super_block *sb,
 		if (!configfs_unlink_root(subsys))
 			continue;
 		if (subsys->clear_subsystem)
-			subsys->clear_subsystem(subsys, info->ns_id);
+			subsys->clear_subsystem(subsys, info->net_ns);
 		unlink_group(&subsys->su_group);
 		configfs_release_fs(sb);
 		kfree(subsys);
@@ -2092,7 +2092,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	mutex_lock(&info->subsys_mutex);
 	list_del_init(&subsys->su_link);
 	if (subsys->clear_subsystem)
-		subsys->clear_subsystem(subsys, info->ns_id);
+		subsys->clear_subsystem(subsys, info->net_ns);
 	unlink_group(group);
 	mutex_unlock(&info->subsys_mutex);
 	configfs_release_fs(NULL);
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index c1cdadba0a48f0abea30da5ee324807b9ac4ff8f..893ae778585fb8be60026c661cb1ef63980ff0e3 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -231,9 +231,9 @@ struct configfs_subsystem {
 	struct config_group	su_group;
 	struct mutex		su_mutex;
 	int (*fill_subsystem)(struct configfs_subsystem *subsys,
-			      u64 ns_id);
+			      struct net *net_ns);
 	void (*clear_subsystem)(struct configfs_subsystem *subsys,
-				u64 ns_id);
+				struct net *net_ns);
 };
 
 static inline struct configfs_subsystem *to_configfs_subsystem(struct config_group *group)

-- 
2.51.0


