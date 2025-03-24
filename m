Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25194C28B30
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 03:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y+lBWvBWsooMCNpWLo3cjcyoLUwSjuvkU6Az+IaayaI=; b=Dce6n6BKjEM4Uv0RttTlNglze0
	2dJ0LRnQ8TLPQN4I30ZRFY6FgHg3I0guH9Vi66SC82HK+X0OxBGwzDVAYNZAgr7mvQxFbIoSDuNTS
	cQKBMMm5ZHluv4gSE02txROFN+szfCdgCTqIa9hVmr807uOko0HLi7KSfmPhI8KAGEJ8bqY+oKHwt
	v+APetjJXl7Wjj02csUP3k4yYo1ZBUtXqqn7/KvO9Gk+jjvrShYyAZjWYuyqUuMhgTOLQ6F2gE/Ng
	w/zygQoYqAlmvVghg5KcLhRD6nGX2vyR6N3XbXfoxlK+Miv8Msa/m8+2zH7KP/fMj1VgtvA2jk0mg
	M5L8RW3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twYKK-000000027Yu-16YW;
	Mon, 24 Mar 2025 03:18:12 +0000
Received: from [1.203.97.246] (helo=smtp.cecloud.com)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twYKC-000000027YP-3WEa
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 03:18:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 9CEBD7C0115;
	Mon, 24 Mar 2025 11:17:57 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [111.48.58.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P1609374T281457048416624S1742786276537166_;
	Mon, 24 Mar 2025 11:17:57 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: shaopeijie@cestc.cn
X-SENDER: shaopeijie@cestc.cn
X-LOGIN-NAME: shaopeijie@cestc.cn
X-FST-TO: hch@lst.de
X-RCPT-COUNT: 8
X-LOCAL-RCPT-COUNT: 3
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 111.48.58.12
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <4867d17f220f89c11711a249c798926b>
X-System-Flag: 0
From: shaopeijie@cestc.cn
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhang.guanghui@cestc.cn,
	gechangzhong@cestc.cn,
	Peijie Shao <shaopeijie@cestc.cn>
Subject: [PATCH] nvmet: Replace sock_create with sock_create_kern
Date: Mon, 24 Mar 2025 11:17:08 +0800
Message-ID: <20250324031708.1687164-1-shaopeijie@cestc.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250323_201805_029657_DFF49B3A 
X-CRM114-Status: UNSURE (   9.31  )
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

From: Peijie Shao <shaopeijie@cestc.cn>

Replacing sock_create() with sock_create_kern()
changes the socket object's label to kernel_t,
thereby bypassing unnecessary SELinux permission
checks. It also helps to avoid copy and paste bugs.

Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
---
 drivers/nvme/target/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4f9cac8a5abe..216afacc8179 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2049,7 +2049,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (port->nport->inline_data_size < 0)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
-	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
+	ret = sock_create_kern(current->nsproxy->net_ns,
+				port->addr.ss_family, SOCK_STREAM,
 				IPPROTO_TCP, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
-- 
2.43.0




