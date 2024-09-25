Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D96C369D2
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2024 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=299aFzOby/I9m08SMVur/vbuIKzx5CWDBjqHYJWBIFY=; b=pilc4xMHNyFwtXuc0wzvZcONls
	/7MLQrvFNlPL7Gj8d6EdgskKkudns6YWoZ7qDWWMYD/9iMVHFeF20fQQ3ybFzOhE5ZdaaCtcQnJOl
	bNVvXiIoVuaXcpdEo7DKdB85XLBLZi6wVAv5QzvJzKCidWlsZMoDrODtRrT+vnO0SEEWAhamZ7qdV
	GqHbzvYajqT29qwQnOTR0gIE2RaMIm6b6ByU69QOLxUhOtCMyEEWS8Zx8a5PWx4wXG1UqhCrhzMCM
	ZnWfVqAfKZbrDOCYk4hE0leO4+Nsjw0mI8fLJ7G11oA2yPBJPNZ/0TAb+fTz5F636t52CgZraGDj5
	kzLZhU0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stQMF-00000004u44-2L7T;
	Wed, 25 Sep 2024 11:38:59 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stQLo-00000004ttt-3tjD
	for linux-nvme@lists.infradead.org;
	Wed, 25 Sep 2024 11:38:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0E3B5A43F20;
	Wed, 25 Sep 2024 11:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2662C4CEC3;
	Wed, 25 Sep 2024 11:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264311;
	bh=vK3lmOrXiq/YYa7DiGqflGevr35quYkpRFV2If/dytE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAURDJkAz1SpDsiReSpo6JR9gln/HkGpqf/F5v5Z7oSom8MoeoImFAFyWhpd6T+ok
	 D5fYgnyM1t/RCHeyVvRye8DNVr5w+9L3puseHhAW87/RrTMe+EzS8fxb8kiQ1qF/8f
	 BL4qKqjeIU38rvhv7G1iaJS2CZKOidDzspt6XVw6N55AHqGWgVD591ozxEEHARRdtw
	 eHD2DxG3AcDyjblNPlKTuk3QCD43mfNjL2O2iHW+K+IwaFs7C4mQZgmuNQiNqPagBl
	 22D65ZQTLHyk1LNBvxGIRxOCyKyryPcxPesY++SFvGyoTipR4arZOo9X7A1HV5zGVD
	 +JcMHLYT425rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 053/244] nvme-tcp: check for invalidated or revoked key
Date: Wed, 25 Sep 2024 07:24:34 -0400
Message-ID: <20240925113641.1297102-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_043833_124955_C684175A 
X-CRM114-Status: GOOD (  16.00  )
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 5bc46b49c828a6dfaab80b71ecb63fe76a1096d2 ]

key_lookup() will always return a key, even if that key is revoked
or invalidated. So check for invalid keys before continuing.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/common/keyring.c | 22 ++++++++++++++++++++++
 drivers/nvme/host/Kconfig     |  1 +
 drivers/nvme/host/fabrics.c   |  2 +-
 drivers/nvme/host/tcp.c       |  2 +-
 include/linux/nvme-keyring.h  |  6 +++++-
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 05e89307c8aa3..ed5167f942d89 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -20,6 +20,28 @@ key_serial_t nvme_keyring_id(void)
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_id);
 
+static bool nvme_tls_psk_revoked(struct key *psk)
+{
+	return test_bit(KEY_FLAG_REVOKED, &psk->flags) ||
+		test_bit(KEY_FLAG_INVALIDATED, &psk->flags);
+}
+
+struct key *nvme_tls_key_lookup(key_serial_t key_id)
+{
+	struct key *key = key_lookup(key_id);
+
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
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index a3caef75aa0a8..883aaab2d83e3 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -109,6 +109,7 @@ config NVME_HOST_AUTH
 	bool "NVMe over Fabrics In-Band Authentication in host side"
 	depends on NVME_CORE
 	select NVME_AUTH
+	select NVME_KEYRING if NVME_TCP_TLS
 	help
 	  This provides support for NVMe over Fabrics In-Band Authentication in
 	  host side.
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index f5f545fa01035..432efcbf9e2f5 100644
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
index b305873e588e6..e3d82e91151af 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1596,7 +1596,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 		goto out_complete;
 	}
 
-	tls_key = key_lookup(pskid);
+	tls_key = nvme_tls_key_lookup(pskid);
 	if (IS_ERR(tls_key)) {
 		dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
 			 qid, pskid);
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index e10333d78dbbe..19d2b256180fd 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -12,7 +12,7 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
 key_serial_t nvme_keyring_id(void);
-
+struct key *nvme_tls_key_lookup(key_serial_t key_id);
 #else
 
 static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
@@ -24,5 +24,9 @@ static inline key_serial_t nvme_keyring_id(void)
 {
 	return 0;
 }
+static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 #endif /* !CONFIG_NVME_KEYRING */
 #endif /* _NVME_KEYRING_H */
-- 
2.43.0


