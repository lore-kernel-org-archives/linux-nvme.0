Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AE1C3DA63
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qzx+y51deRX/UKDxJfYOnOWW2jAEjM0rUFCpREWrFdk=; b=vmRNnQJN8Vce32dgkqmR8nYN8v
	OajooZmex+uh/P/4Gkbs4WClCCq+0dR2Iem6ivnNLaWwkspZHt+meMZXr6LZxggAEQKA/U92wjHT1
	DGdF+f7h8Y5NrghJ88Ckv/FgY6T/w3FkqtMmTweCUn429BZWYKCMVFTcqm9g0Gv96AofBeb7w207+
	ZzU4IZrlba4+vFKbfCGuwSxXyUSOgbdIFsCZ7pAyEGAtuiFc3+Z+BrumkBzagDy6w1t7GwnK3G5uo
	SLlET5dxMsmcNFbO3ZxjUjdxs3VsC3iJglj5ltkDZttZ/068w8krABQlfOpNWiW4llFLTW6bJHjbO
	jXajz12A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRi-0000000HKPH-2thd;
	Thu, 18 Jul 2024 14:49:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRd-0000000HKM6-2OcR
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 14:49:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E1C4261B8E;
	Thu, 18 Jul 2024 14:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58586C4AF0F;
	Thu, 18 Jul 2024 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721314160;
	bh=wJN8MNCzL3MozmYfWG/xKnIm4dtYgghFyh/Iz708wyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPc8TNiD3+MGlpKy05DF9bY6wZ+hwT4yk0GWMbnTUhrmfb4s5MshmgJZchETmiaNx
	 Yf0nVTzKTS1WChPUCTd/h4YsVL9bJ8PfPl8J75PZu+/gTtd9yt22bi3fY7ew8vRKC6
	 sJQz8F4fPFgMCasEwpElTK59s9NgWkbbn4N4aysYyg2ze9npfYPt+tRAEPxFZZo2dR
	 D+LxJL6htv08BOuTkg4prnT3VhNccDA5gb63LVzPH49OMyCb+B4zJb9P3sjuNdfy3Q
	 5ZtTnfMOmzWQZxvPgNBYBNcMp5Xu3BLTcrHW12lqY9cQ0O+ZdADJyCsfWVWakk5fS2
	 W/f+pmAEcH1hg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/8] nvme-tcp: check for invalidated or revoked key
Date: Thu, 18 Jul 2024 16:48:53 +0200
Message-Id: <20240718144858.19074-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240718144858.19074-1-hare@kernel.org>
References: <20240718144858.19074-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_074921_762897_D4390769 
X-CRM114-Status: GOOD (  14.19  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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
index f5f545fa0103..432efcbf9e2f 100644
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


