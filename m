Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC328606A338
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QTCdZeDu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhORENuG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cIUjhD1eFCgzgsEhBfvcHxxzCk6Lpi063thVghEHEDI=; b=QTCdZeDuHLoSsL
	N//xhoaa6J3Dga0UMBW9a2OTYrxAwvpoHj1ZoB73i7sTdqq6if+4HzK6L6A3iws1K3R+/manixCKK
	aOKyFAXpMP258oM6Q94u/Jrs+5rWB0EjO/88PQ1UYKHdLI/pRb3ClKlYBjxIIWT3qTnpOKzuGHaNl
	TPsAUkAA1WN5yBTcqWXlNN9t9tsEx8mu0QIx9P+ilCl3DQ7a/QmtUacuprta7blhk6PkUOACz8JWs
	E8ftRsRXj8GnLGTBSnXA8nAiWIxMxlsuM3rH0HwuwFW3kMwowe++1Gc7KUkQjZZoBPmxiAbcFUYxk
	cTnG1CrGUOONrC5pHUYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaE5-0000000DUpc-0FA4;
	Thu, 26 Nov 2026 14:13:29 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaE3-0000000DUnW-2quM
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:13:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D00A43367;
	Thu, 26 Nov 2026 14:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4EA1F000EB;
	Thu, 26 Nov 2026 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702407;
	bh=cIUjhD1eFCgzgsEhBfvcHxxzCk6Lpi063thVghEHEDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jhORENuGTY26Jl2+E6P6oTBa5xhcyGEg+k84PLbn4PT+3kvp0fZ+duM3hXXKKFSgU
	 qlujBQ/DN3KxwPCKH7xFUzAxQUYbNxjRAFUFXChtKxykjt+UJUeRNWSjFVtu54v2SX
	 OzBUQMoYFQm2n9YXGMPBCXigGr/baS+NLS9yY7ZCMqLFqZwCPG73Za0DyRzf6ThW7w
	 8FU3YFKa20yAifgPug+nnY0dv13FBilNuPaPmoygXigIzvICViWl8iLFvZiKtY8RDi
	 gALyb/fxl+bKueLx6E79ub/fhlugGq63NNwdojiPYrDWV5iCZO7fWhdE15bmOdkJ67
	 FDJQB2g99sz8A==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:28 +0100
Subject: [PATCH v7 10/14] nvme-auth: allow to specify the key by key serial
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-dhchap-keyring-v4-v7-10-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=1428;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=fB5oEb7osfNq9IRI4wJ7VJEoxYdedRK+3dGaIwOdzsU=;
 b=Z6gvuKDfgCPBt658z01bDg/2bg69fua4ulgehYSv0KWapIiwlipJNPwpbKMNUAuqJ1VwidmwK
 huzVCRe7L4+Dvxa3P8hmzBHnZS9ApIEd8jrQrZS6iLAPOdAzYbT9/fN
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update nvme_auth_extract_key() to accept a key serial
number in addition to the existing input formats.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 15e72fe8868af5698809cd6634a1f1f1da11ca2d..e336c698437dcea4d7ce4c435efda0b9f26eb63d 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
  * @generated: indicate whether a key has been generated
  *
  * Extracts or generates a key from @input.
- * @input can either be a key description or raw key data; in
+ * @input can be a key serial, a key description or raw key data; in
  * the latter case a key is generated from @input and
  * @generated is set to 'true'.
  *
@@ -158,7 +158,18 @@ struct key *nvme_auth_extract_key(const char *input, size_t input_len,
 				  bool *generated)
 {
 	struct key *key;
-
+	unsigned long key_serial;
+	int err;
+
+	/* Check if @input is a key serial */
+	err = kstrtoul(input, 0, &key_serial);
+	if (!err) {
+		key = key_lookup(key_serial);
+		if (!IS_ERR(key)) {
+			*generated = false;
+			return key;
+		}
+	}
 	/* Check if @input is a key description */
 	key = nvme_dhchap_psk_lookup(input);
 	if (!IS_ERR(key)) {

-- 
2.51.0


