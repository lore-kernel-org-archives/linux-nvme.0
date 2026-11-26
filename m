Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB92E606A321
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TqtOPi4n;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONAgsYo/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8eaMNBlC7DEchGsEEioGv4L8G7ys62634OKtlN/XSzY=; b=TqtOPi4nYGkV2p
	5J/u3+2gGsv//xCItru+rvmTyjPB8bTLkCycexF8yklNJDwXqt0pjZitBgKe7cXsTNHoSL/pNRNGo
	aUQrm1RTAYce3rzUxyJ9gBaXwtECyQPtane1r5C5HByq0Q3SmNvZaB9su8/Bp9VQKIt20ALSf6j1+
	sbnt2WX36guqL2H7WEJjHTDlwNNXwCySlWaUjkOJfJO61Ai6N2/4+KllGAyQHKOKkIHJxL7zMrson
	dRYxFQ7UtLmBqHMhaIs1KcHkG6bZ4017SLVOdKfpFybxfd1jJySRsqcM052/skipSHnEx3Q6E4zP9
	lxKZW8N/Tb9BUNAu7gIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaDc-0000000DUMu-0tkx;
	Thu, 26 Nov 2026 14:13:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaDU-0000000DUId-31Sd
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:12:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7ABE744455;
	Thu, 26 Nov 2026 14:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C378F1F000C0;
	Thu, 26 Nov 2026 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702371;
	bh=8eaMNBlC7DEchGsEEioGv4L8G7ys62634OKtlN/XSzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ONAgsYo/5Ad8ELFMX07CoYilvBPHM1KLXm3+gJQdqg6E3K6bgGcHIKTBv+/qDWE6X
	 TFHKVdcWIzctWPMDszA+dp/JZ4fRHYNuJw5iTc7WDMvgXJB8UtZ6Q7HiVIpJhbqmBo
	 aLxlPOMVacK8vXm2zQy5fdAIrCeVVloxUuSl9QldIAFMeBv2jTAUlbgfet5l2KA8+t
	 QrcdG8MqEyk9GWM84nnlDafS92EMwEEh18UXruHn47Zz5Q5sA4sjA2Cv/PaXC5brMq
	 OrOVkFkJMZMThs9xwUCKGp/mhge3TOvSGbKCI6Y+pFID+96fscq2vtzvIWtJOdIymR
	 OxS1a0+gij5yw==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:21 +0100
Subject: [PATCH v7 03/14] nvme-keyring: drop nvme_tls_psk_revoked()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-dhchap-keyring-v4-v7-3-ee438ffea527@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=1215;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=lpCSLBw0U7mNVqtzC3VcLESHuh3Qh1H5dFLs35Wdjl8=;
 b=77ik5YnX60CQBJQmLlJrlMxK83hP/pkhtA9N0yRyzUDwPeD9PV+CK+oedE3AQd1qv9Q9i2bmS
 a8U/DmRTn42AX2uG5bw/0pR1+aIAy8CGoDohq7//nKTkWJLsSW8FKAw
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

Replace with build-in function key_validate().

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/keyring.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index de8dab10fa1059d8bfc2351edd7bb68ee52207a5..373f51e1032a4d29ef945a62fd9fb3720f8a9ea8 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -22,24 +22,20 @@ key_serial_t nvme_keyring_id(void)
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_id);
 
-static bool nvme_tls_psk_revoked(struct key *psk)
-{
-	return test_bit(KEY_FLAG_REVOKED, &psk->flags) ||
-		test_bit(KEY_FLAG_INVALIDATED, &psk->flags);
-}
-
 struct key *nvme_tls_key_lookup(key_serial_t key_id)
 {
 	struct key *key = key_lookup(key_id);
+	int ret;
 
 	if (IS_ERR(key)) {
 		pr_err("key id %08x not found\n", key_id);
 		return key;
 	}
-	if (nvme_tls_psk_revoked(key)) {
-		pr_err("key id %08x revoked\n", key_id);
+	ret = key_validate(key);
+	if (ret < 0) {
+		pr_err("key id %08x invalid\n", key_id);
 		key_put(key);
-		return ERR_PTR(-EKEYREVOKED);
+		return ERR_PTR(ret);
 	}
 	return key;
 }

-- 
2.51.0


