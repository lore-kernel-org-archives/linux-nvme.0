Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB725C3DA5E
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 09:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9oZhcQV6Gxr4V80P3RXl2midlczXrYB9X2/AY+IlBJI=; b=ObZM6UlhyUG3edJEWWpOBS7/fF
	KB/CWgkfFRlPlyQkJLab+jG+QOwg2fP+0ukHdWn1EjbKw0c/OInBv0fDUzeYC0tTMtdtJ8Igmcc/I
	diGspjLqXk1lC3pPsiENFImyQZY5+hMruXZY19xbFRl36tlHRUIbz59ssdLH/prets5iTjNlsQyJA
	sP07G8tXG2hxL5yeF1vRrTseXMBlbzVYUdOrjNypWajY0dje3/UsikU4jOyOaSItM0XyvFspPJSWE
	GrGFN4LrVEo0C+VT3rlivL2bM9EgfO71821knMXGM4MUzwJGnwXxV2XzXsFgDsGrlUQ2P3lwgoS9v
	HAYYn+BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0gX-0000000DFpO-17z6;
	Wed, 17 Jul 2024 09:10:53 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0gS-0000000DFmO-3qjs
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 09:10:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 58BDBCE16C4;
	Wed, 17 Jul 2024 09:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2960FC4AF14;
	Wed, 17 Jul 2024 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721207446;
	bh=o37Uz5Oh4iloVAr7Rk6XWAz0JxgXF2PZ3BQEkbHJqyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWMGh9cVxzprlMgkGBE5PSFXZofoqrksnet3lKtAX+OlF1r4zy50KAiXKx9PnH5E8
	 TJP+K3RoL7kvoQPWYFebmRwaAKYLR9LGQWLE7L7Gf09L+s+nalQrUqVJ4OyXKH8Vzr
	 6z2C6NxrRv4CrQmDeSd9zKYrIFTDnLpa/mw0HkVx0DLM6pba8IZIJf60ZbgQIZ/R+x
	 gavTYenxCnck6TCx8l4zdXmR1qT0EW1Jws4Nx0gMP9sni4XCnQ8pvQQP+9pUFUtN1Z
	 UeWDk7M8tpYzARu4SOcVT7VsB8jM399XoNX7wu43qpl5/q7FL7NS+HuI0LESvUBJko
	 LzwbTLE+VXoJg==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 03/16] nvme-tcp: check for invalidated or revoked key
Date: Wed, 17 Jul 2024 11:10:18 +0200
Message-Id: <20240717091031.143188-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240717091031.143188-1-hare@kernel.org>
References: <20240717091031.143188-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_021049_342555_4220B6E3 
X-CRM114-Status: GOOD (  14.89  )
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

key_lookup() will always return a key, even if that key is revoked
or invalidated. So check for invalid keys before continuing.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/keyring.c | 21 +++++++++++++++++++++
 drivers/nvme/host/fabrics.c   |  2 +-
 drivers/nvme/host/tcp.c       |  2 +-
 include/linux/nvme-keyring.h  |  3 ++-
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index c60ebbdc52b8..5b886fd6c3e7 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -20,6 +20,27 @@ key_serial_t nvme_keyring_id(void)
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_id);
 
+static bool nvme_tls_psk_revoked(struct key *psk)
+{
+	return (test_bit(KEY_FLAG_REVOKED, &psk->flags) ||
+		test_bit(KEY_FLAG_INVALIDATED, &psk->flags));
+}
+
+struct key *nvme_tls_key_lookup(key_serial_t key_id)
+{
+	struct key *key = key_lookup(key_id);
+	if (IS_ERR(key)) {
+		pr_err("key id %08x not found\n", key_id);
+		return key;
+	}
+	if (nvme_tls_psk_revoked(key)) {
+		pr_err("key id %08x revoked\n", key_id);
+		return ERR_PTR(-EKEYREVOKED);
+	}
+	return key;
+}
+EXPORT_SYMBOL_GPL(nvme_tls_key_lookup);
+
 static void nvme_tls_psk_describe(const struct key *key, struct seq_file *m)
 {
 	seq_puts(m, key->description);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 44e342a46f39..c62d8890f3a8 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -665,7 +665,7 @@ static struct key *nvmf_parse_key(int key_id)
 		return ERR_PTR(-EINVAL);
 	}
 
-	key = key_lookup(key_id);
+	key = nvme_tls_key_lookup(key_id);
 	if (IS_ERR(key))
 		pr_err("key id %08x not found\n", key_id);
 	else
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 92ad5b8cc1b4..5885aa452aa1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1590,7 +1590,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 		goto out_complete;
 	}
 
-	tls_key = key_lookup(pskid);
+	tls_key = nvme_tls_key_lookup(pskid);
 	if (IS_ERR(tls_key)) {
 		dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
 			 qid, pskid);
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index e10333d78dbb..e092e3e6ffb2 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -12,7 +12,7 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
 key_serial_t nvme_keyring_id(void);
-
+struct key *nvme_tls_key_lookup(key_serial_t key_id);
 #else
 
 static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
@@ -24,5 +24,6 @@ static inline key_serial_t nvme_keyring_id(void)
 {
 	return 0;
 }
+static inline struct key *nvme_tls_key_lookup(key_serial_t key_id) { return ERR_PTR(-ENOTSUPP); }
 #endif /* !CONFIG_NVME_KEYRING */
 #endif /* _NVME_KEYRING_H */
-- 
2.35.3


