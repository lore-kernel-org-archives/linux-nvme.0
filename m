Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241A3C36008
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 06:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UEHuiy6pO7UdZnJMR3gXjANt6+eZN/hzLsojgkaoY2o=; b=2idb0jz0CMIeA7RkdvaInP8bgc
	FWGtEQ+Ilh10/RZTJfXcon02xJ2eZepFjpksmM6/JxOauTOJ8Ln7a4oOV4UxwpI0E4gchBrbOyrUe
	266V4tIfskgg08s0yMNhMj9z8QATDKVHaYyOdJQ9xIyuWrtsz5+49cGV5umcpYE5hqyu3OSksz38D
	Aic7S3tRnI78gRvWH/1uG70zPJT4gTXMBuVuP/nAA9wrKv6RejUzKG+FIL3vctWcH1aCg8870muRO
	zPbLrBid8wkwahZ9zQQ5O/H6JTKpDEbMKB3aTYLO/zlMDDVAzUvKk681N6XwHCg+D+xrFYc88qC3a
	3N3kS6XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzV1X-000000025Hd-1Sc7;
	Tue, 01 Apr 2025 06:22:59 +0000
Received: from [1.203.97.240] (helo=smtp.cecloud.com)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzUzE-00000002538-1a5Z
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 06:20:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 5B2EA900113;
	Tue,  1 Apr 2025 14:20:25 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [111.48.58.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P3907747T281458888339824S1743488424274530_;
	Tue, 01 Apr 2025 14:20:25 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: shaopeijie@cestc.cn
X-SENDER: shaopeijie@cestc.cn
X-LOGIN-NAME: shaopeijie@cestc.cn
X-FST-TO: kbusch@kernel.org
X-RCPT-COUNT: 9
X-LOCAL-RCPT-COUNT: 3
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 111.48.58.12
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <d5211473a6f7e9d5e0070690dcad5376>
X-System-Flag: 0
From: shaopeijie@cestc.cn
To: kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	hch@lst.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gechangzhong@cestc.cn,
	zhang.guanghui@cestc.cn,
	Peijie Shao <shaopeijie@cestc.cn>
Subject: [PATCH] Fix netns UAF introduced by commit 1be52169c348
Date: Tue,  1 Apr 2025 14:19:34 +0800
Message-ID: <20250401061934.2304210-1-shaopeijie@cestc.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1f55b71d-8e28-4eac-b14e-d32a7e704578@cestc.cn>
References: <1f55b71d-8e28-4eac-b14e-d32a7e704578@cestc.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_232036_566478_B2B9321B 
X-CRM114-Status: GOOD (  14.38  )
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

From: Peijie Shao <shaopeijie@cestc.cn>

The patch is for nvme-tcp host side.

commit 1be52169c348
("nvme-tcp: fix selinux denied when calling sock_sendmsg")
uses sock_create_kern instead of sock_create to solve SELinux
problem, however sock_create_kern does not take a reference of
given netns, which results in a use-after-freewhen the
non-init_net netns is destroyed before sock_release.

For example: a container not share with host's network namespace
doing a 'nvme connect', and is stopped without 'nvme disconnect'.

The patch changes parameter current->nsproxy->net_ns to init_net,
makes the socket always belongs to the host. It also naturally
avoids changing sock's netns from previous creator's netns to
init_net when sock is re-created by nvme recovery path
(workqueue is in init_net namespace).

Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
---

Hi all,
This is the v1 patch. Before this version, I tried to
get_net(current->nsproxy->net_ns) in nvme_tcp_alloc_queue() to
fix the issue, but failed to find a suitable placeto do
put_net(). Because the socket is released by fput() internally.
I think code like below:
    nvme_tcp_free_queue() {
        fput()
        put_net()
    }
can not ensure the socket was released before put_net, since
someone is still holding the file.

So I prefer using the 'init_net' net namespace.

---
 drivers/nvme/host/tcp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 26c459f0198d..1b2d3d37656d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1789,7 +1789,13 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
-	ret = sock_create_kern(current->nsproxy->net_ns,
+	/* sock_create_kern() does not take a reference to
+	 * current->nsproxy->net_ns, use init_net instead.
+	 * This also avoid changing sock's netns from previous
+	 * creator's netns to init_net when sock is re-created
+	 * by nvme recovery path.
+	 */
+	ret = sock_create_kern(&init_net,
 			ctrl->addr.ss_family, SOCK_STREAM,
 			IPPROTO_TCP, &queue->sock);
 	if (ret) {
-- 
2.43.0




