Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F99C53200
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 03:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hM4XW48chRTEDrGyUEYV+2sNhIKcNv/Bq6OYHO+H+vs=; b=pE6cpiO942Ka0q+vN+QqZKpLu5
	Ew6airCc8Y177WYfLmBLvtfYj+9vO0nYVV6VF9zoX/ceTewvfPF8PqeUnBDdE/UKTfMxJZW+lIV05
	ANyuC7Xa77zKDMxcCwSkGUtBIZ4r++408JcLzOZhFCWF5kj5jPcc7IT7rQVoSTkN4IiTKXbk+UBv7
	ZqcL8CKDNGK6Cqo2HZE6b+1+RAWC03pJ9JQt7/3RxLrL3w4/0TKO2864DAaPV8bzIrFPQ+V0OvKwu
	uWpIxzRG2jcybSho+N5XL4lkBi98FV6wzdkUb2OorD3CmvURBd+19WQM4MDdGLNPzOxADrhmeTZSm
	bEGEjyvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woBsU-00000001rZy-2pEd;
	Mon, 27 Jul 2026 03:19:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woBsT-00000001rZX-3cK6
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 03:19:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 51235600D8;
	Mon, 27 Jul 2026 03:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1950C1F00A3A;
	Mon, 27 Jul 2026 03:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785122381;
	bh=hM4XW48chRTEDrGyUEYV+2sNhIKcNv/Bq6OYHO+H+vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ei1qlUH9w+VNju0gQiPgUVXqvJXM4dVfuMZZjFGC8UCh3XihyKPD8tNhbSuIMfJg1
	 cGR7JXDBOryEn7EQF8u7TZrg4UA8ouIXuHfol9e82ABJexbsszRkk1wkyZB8x4QuHm
	 RxDuqZz3MWHcqoH9gOoEbAIUBwZHx4i/4Y9UGxewYDtTZEL3OS0Z4vqlsYxpTLwb/t
	 Wx0FdP5PFabE+l+Zgm4h9euabKidIphazhx1jxxCOiSS0XHEufNuoiMo103KgY9T0z
	 b8ybDDTtXrFy0kBcluuQt+7CuYEhoGxUlkNzILMbXkR5J+ZE+he10diw1laGD3ebpm
	 5lW+AwxAuTS1w==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvmet-tcp: support IPv6 traffic class
Date: Mon, 27 Jul 2026 11:19:03 +0800
Message-ID: <563c79d8a4b78c79262e236c583a0f6efb53a95d.1785122120.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785122120.git.tanggeliang@kylinos.cn>
References: <cover.1785122120.git.tanggeliang@kylinos.cn>
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

nvmet-tcp currently applies the received IPv4 TOS value when setting
up a queue socket, but does not handle the IPv6 traffic class.

Extend the queue socket setup to handle AF_INET6 sockets. Obtain the
traffic class from the IPv6 socket and apply it through IPV6_TCLASS.
Keep the existing IPv4 TOS handling unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 75a276d73be3..fcdc73dfe5b0 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -13,6 +13,7 @@
 #include <linux/nvme-keyring.h>
 #include <net/sock.h>
 #include <net/tcp.h>
+#include <net/ipv6.h>
 #include <net/tls.h>
 #include <net/tls_prot.h>
 #include <net/handshake.h>
@@ -1723,8 +1724,18 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 		sock_set_priority(sock->sk, so_priority);
 
 	/* Set socket type of service */
-	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+	if (sock->sk->sk_family == AF_INET) {
+		if (inet->rcv_tos > 0)
+			ip_sock_set_tos(sock->sk, inet->rcv_tos);
+	} else if (sock->sk->sk_family == AF_INET6) {
+		int tclass = inet6_sk(sock->sk)->tclass;
+
+		if (tclass > 0)
+			sock_common_setsockopt(sock->sk->sk_socket, SOL_IPV6,
+					       IPV6_TCLASS,
+					       KERNEL_SOCKPTR(&tclass),
+					       sizeof(tclass));
+	}
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
-- 
2.53.0


