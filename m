Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E0AC28B30
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Mar 2025 06:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rEDqt2Dy+5D+0SeGFYuwuhsJ+GbwXkEzfqajM5hXOQQ=; b=AFebyeR1fMe46X52cyYN5YX3MZ
	z/umYXL+A31JQtyw3oeiKq7uqJro+SvIL1RD9h0msvBwyincrZyrbtrPvL2+GVW1BX9l6s/Yb1QBx
	dZD7NHaQVc0Y2DLGFEjkKQvPhYmxJE4EeXY6mTSQdKv1NF+BpGPopVW0Fm3VwlG3Lf5VHRSBSwoZi
	F8tss8SnI9cvYTEiyhbUGR0a/y8vqZEHGytE1dn7AF/sgS7+QTJu2ajaf6g8V/2c02s6+S8BtlmAd
	sjzpF+X1Np9GhNuVzTF5EN2Fuv6k7nWZbHYL27a/+p+hNdsgvE8yTnopZSCoL12E/7p3U2A6pNh9N
	cKSD+MDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tv9WH-0000000BJej-2exc;
	Thu, 20 Mar 2025 06:36:45 +0000
Received: from [1.203.97.246] (helo=smtp.cecloud.com)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tv9WE-0000000BJdj-0n60
	for linux-nvme@lists.infradead.org;
	Thu, 20 Mar 2025 06:36:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id A16057C0115;
	Thu, 20 Mar 2025 14:36:35 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [111.48.58.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P1609374T281456747934064S1742452594471158_;
	Thu, 20 Mar 2025 14:36:35 +0800 (CST)
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
X-UNIQUE-TAG: <ba8584b988ac8f78fbffabd1439a33d6>
X-System-Flag: 0
From: shaopeijie@cestc.cn
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhang.guanghui@cestc.cn,
	gechangzhong@cestc.cn,
	Peijie Shao <shaopeijie@cestc.cn>
Subject: [PATCH] nvme-tcp: fix selinux denied when calling sock_sendmsg
Date: Thu, 20 Mar 2025 14:35:23 +0800
Message-ID: <20250320063523.2201926-1-shaopeijie@cestc.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_233642_391313_F1530C9B 
X-CRM114-Status: GOOD (  10.18  )
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

In a SELinux enabled kernel, socket_create() initializes the
security label of the socket using the security label of the
calling process, this typically works well.

However, in a containerized environment like Kubernetes,
problem arises when a privileged container(domain spc_t)
connects to an NVMe target and mounts the NVMe as persistent
storage for unprivileged containers(domain container_t).

This is because the container_t domain cannot access
resources labeled with spc_t, resulting in socket_sendmsg
returning -EACCES.

The solution is to use socket_create_kern() instead of
socket_create(), which labels the socket context to kernel_t.
Access control will then be handled by the VFS layer rather
than the socket itself.

Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 327f3f2f5399..71f7045881eb 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1790,7 +1790,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
-	ret = sock_create(ctrl->addr.ss_family, SOCK_STREAM,
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			ctrl->addr.ss_family, SOCK_STREAM,
 			IPPROTO_TCP, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
-- 
2.43.0




