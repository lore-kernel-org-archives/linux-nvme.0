Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F70C531D0
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 02:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Kkd0d9Ef7duSE2o9ews0NSBrFehbWhOmiPio61v7agM=; b=EPTNljxgtANaQxidb9rvZswfGQ
	j9Py7iJrgxUnepXgMpfS6rlLALb0r6y0KMSkspEMgSMCakk8mvd7WBytumpz2R1iAQrYZ1aXqTR6k
	kQXwW1wd95tu1edJm2hFjoGQysZ5sY28pwKTB833xn2bS6eBVWUYD4xEwvDDsjBfFdtGDWTIoJcLD
	dhHzhMZ4HNtqXHOIf8LiZm23TqRK1RrJo/S7Vu08bC4cl33HK8s65WkQ0SC2Tr87IsXZ478zskkb3
	9GcWYxQuCYoQOgqUD/sgf2gVOdWU7lzfaNgN4rxGu2IKoZKCpBCqA2pnA5hhOgP6ykVeUz9FdChpA
	Zs26HzrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnotq-00000000pqd-0luv;
	Sun, 26 Jul 2026 02:47:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnotp-00000000pqV-0dip
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 02:47:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CD26D60008;
	Sun, 26 Jul 2026 02:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3931F000E9;
	Sun, 26 Jul 2026 02:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785034051;
	bh=Kkd0d9Ef7duSE2o9ews0NSBrFehbWhOmiPio61v7agM=;
	h=From:To:Cc:Subject:Date;
	b=VT+541RuuVfWx9APHccWxgvF+Cli2kIy7N4t51NcHm//XC7uTEQJmRE8VvJm2R6y4
	 lTkTk4eNuv9E1q+LupCrJYO+z5V1bFsNh8LpfRz74O8SBVsfnRXELxuLqtQ4/x+eJh
	 dRPAOsJ56+Lefy+qOqeNV8/sYHbbOjkASjJVQ8FSOTDr2iMwctEYP0g4c0IqHy0H5y
	 84vfNyQSJwPifXJSE8pXgxoOU8xRphbJ6bQYGKgcIH16hZYZL7fzvvwhQnm7OUsawM
	 pJx3xopH4w0vxBpBsTb6mPjxdE1g9LYb9DLKSvoufwGNlgMFeOGib8iYe5x6oXO4ZG
	 zx/+uq9uGvdAw==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-tcp: look up host_iface in the current netns
Date: Sun, 26 Jul 2026 10:46:49 +0800
Message-ID: <c14cd4633c27abe2dec863480168691023694aee.1785033817.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
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

From: Geliang Tang <tanggeliang@kylinos.cn>

nvme_tcp_alloc_ctrl() looks opts->host_iface up in &init_net, the boot-time
netns. When called from any other netns - e.g. the selftest's ns2, where
ns2eth1 actually lives - the lookup misses and the controller setup fails
with "invalid interface passed":

 nvmet: adding nsid 1 to subsystem nqn.2014-08.org.nvmexpress.mptcpdev
 nvmet_tcp: enabling port 24660 (0.0.0.0:24099)
 # nvme discover -a 10.1.1.1 --tos=0x10 --host-iface=ns2eth1
 nvme_tcp: invalid interface passed: ns2eth1
 # failed to add controller, error invalid interface

Look the device up in current->nsproxy->net_ns instead so the check sees
the calling task's netns.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..c89d84ccce1a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2960,7 +2960,8 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_IFACE) {
-		if (!__dev_get_by_name(&init_net, opts->host_iface)) {
+		if (!__dev_get_by_name(current->nsproxy->net_ns,
+				       opts->host_iface)) {
 			pr_err("invalid interface passed: %s\n",
 			       opts->host_iface);
 			ret = -ENODEV;
-- 
2.53.0


