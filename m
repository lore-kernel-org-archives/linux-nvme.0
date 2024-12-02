Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5571D7832A
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+zLX1BCUdORFeq7iplcOpwUr5oLEVuThFgZ5qHJnJ8I=; b=hhVSGGOnKPYavdcnfQJyv4tFNq
	om0Hf+4bsy07qplpF0gXfpO82U52RPWW2WPg6aHZHnUjxp5hK58e4sX90bR4EOaNEdYgsdss9gHdo
	NPOPFP9h9j5n18mxnsM1flimzWzzHes9hRwk34eU5MGUZpf/9ni9jsZEtGZ1g3VnH/n1Jr+/Utw5o
	ydm+eW8cnLwy+/g8Z95yAyUkEueRxnK+C8WJ11mhL8FQLT57PuT4iGIZh/0PjbyJ3wEdddskIZTLE
	M/jOobBg9oN+4UEF7x7LMUmfDmmSquFF2CCtHQSsgv5+tgrMt1e0KjMh55U5qvds4FCacfbIyyts3
	NUQUPlbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI7Sm-00000006R8k-0zfe;
	Mon, 02 Dec 2024 14:31:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI7RQ-00000006Qi1-00xe
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 14:30:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 812755C5806;
	Mon,  2 Dec 2024 14:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C729C4CED1;
	Mon,  2 Dec 2024 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149823;
	bh=9JeXcUycqg7OBCWWoqnUUbdjnZuT/EKlo2YBlO3bWyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKlStGQYXemxJ1VKQLmiNSgH1ujc/FhIKctIv1+fPL7LL5SdDJklHHwbZF8ggqv3A
	 EudIpEvFbF+dXfJV6I+T0sybHhQBqyWkvvDsWaAwk4PNfwUPIchhQPxHyQXMskaayI
	 GGM8Dq35VVDi1hrcJ+3KX/EjC9Icm/MKz8f8sZ1El4bmG3lsdz1hlYz09z6wsDXr7B
	 /qVDF1NeqXCLCSQ6EvnaB2BI6dDFspnSJGBAsbhCmdDPCsrX1z2YlGb5Izj5VlD5GB
	 lRi/u6G4RQGZwqyZFqrD5/UjOD407qlEcb0UoBOjoEtIJAvFuwPjlO/nKvjJwsSAjM
	 bgzOfiv8ooujQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 06/10] nvme: always include <linux/key.h>
Date: Mon,  2 Dec 2024 15:29:55 +0100
Message-Id: <20241202142959.81321-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241202142959.81321-1-hare@kernel.org>
References: <20241202142959.81321-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_063024_095239_86AC96C2 
X-CRM114-Status: GOOD (  10.60  )
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

To avoid build errors when NVME_KEYRING is not set.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/keyring.c | 1 -
 drivers/nvme/host/tcp.c       | 1 -
 drivers/nvme/target/tcp.c     | 1 -
 include/linux/nvme-keyring.h  | 2 ++
 4 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 8cb253fcd586..32d16c53133b 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -5,7 +5,6 @@
 
 #include <linux/module.h>
 #include <linux/seq_file.h>
-#include <linux/key.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
 #include <linux/nvme.h>
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e416af2659f..b5e11a0f7ba8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -8,7 +8,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/key.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
 #include <net/sock.h>
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..fa59a7996efa 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -8,7 +8,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/key.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
 #include <net/sock.h>
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 351a02b1bbc3..009bee8e8090 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -6,6 +6,8 @@
 #ifndef _NVME_KEYRING_H
 #define _NVME_KEYRING_H
 
+#include <linux/key.h>
+
 #if IS_ENABLED(CONFIG_NVME_KEYRING)
 
 struct key *nvme_tls_psk_refresh(struct key *keyring,
-- 
2.35.3


