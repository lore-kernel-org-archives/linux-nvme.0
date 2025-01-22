Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1D8C02181
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jan 2025 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y7kOmHhHI2wjjUVq2IBr5gRd0ypFpw4g9xD9eNlfqvQ=; b=sMEDEXQutdYBswzsdC9mHG2rwj
	5kbBPJc948V0lMJensB3avetiZChmSFuPrC033iUHXn8VwcDd6v0pLRb4zTvepPRjx96pfkTnMQK2
	n7aFYEh+3cefYDkZl/L+Ihk4mf5Fpq2gPia+aX+N6sRROpxOYivPZdDhj7yABq0XfXORceFxA8rqI
	61K49V0ItqFkmlIBG4Hg5GVuQTDQjflDZYSgoaW5ZiPQcWdXxsfLMaJbYp3o0tv8LCCQRtw9SRAtP
	O8n3mh9bLJDiRQBDqklK5sOQcDlmQJnca5WAK4IpVUDQyDyRxMLkn5qoMruPGAmEXchBdYbPByQkU
	ku64iwvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4N-0000000An4F-3C8G;
	Wed, 22 Jan 2025 16:59:11 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4K-0000000An1D-49mn
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jan 2025 16:59:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CAC26A4290F;
	Wed, 22 Jan 2025 16:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7D0C4CED3;
	Wed, 22 Jan 2025 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737565148;
	bh=2Nb4i161mtMI4XYiTBlo1XQ5Cp4y7aXUO5xLWlpNVZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQgG827UZuQeatBSeVjlOK30GbnM9wZ6cvLRaW4SuSeup8T3tIR9jtfjzv+2IQ4hD
	 eKqXK/ng5TtrtJpIF+3fE74r01h5xov2FFPROhtlTr/oFJlNXMlf0hQh7ZY/aq/l0j
	 fZ8wW0NVlazGxrlFsc1LH0zIo0AF0YnIKTtQDr4OjwQpULa1jOGUiU+qkKhMN2tat9
	 quss2aiKo+vnJRoU0ldyshySmKWMh6qvMt9ZgQsyys2ULyeBBvybcUEDaAkvzBYpsK
	 Rni78Bd9QnLgAAVyUm/lQAF3ZzN/5CkFOlDfH4bmuMXxixjKud0AKPdd83MN/3nUiX
	 OJ2VfZ6XYnFtQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 06/10] nvme: always include <linux/key.h>
Date: Wed, 22 Jan 2025 17:58:25 +0100
Message-Id: <20250122165829.11603-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250122165829.11603-1-hare@kernel.org>
References: <20250122165829.11603-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_085909_099093_4670A4BA 
X-CRM114-Status: GOOD (  10.95  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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
index dc5bbca58c6d..68769449d595 100644
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
index f7bbcbeb4b13..ab8971afa973 100644
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


