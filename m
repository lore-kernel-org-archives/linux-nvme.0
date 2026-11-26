Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CA9606A327
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=d7YVRgbm;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8LBLd+V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LYH/RuGe2aPlDUYuIjnhsmnOEU9dOO/cT5aSku50wtw=; b=d7YVRgbmIT/dOf
	ukrSt52/J/dwqg4wL/J9i1MLerGVLU2PRV5PGieP2HKSmTEXXJ9ufQIKcyKWvYkJdHE63zCv+G/gZ
	FedhKrfFgz5D6KDWDbG0muSR7p8YOLbeTdIezqCgrniUVcIqeIUG2X7FHirRRQEpXRjqfXlXL5eJd
	jmTbY8colrul2KliHu/m2rfpQoi3FpkTSaC3Lr+bmybemUYuUZlH21WfB72xUIRrQOxlyuDOA8jTH
	vE8jcaMCsYUcZPO7p0MjJZNpIARn1ivOeFVihynJxIgwb2StOzln9DUaJFboe/RozycKumwIho88D
	BHceONtv9n7v73CpOXrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaDc-0000000DUML-0GTz;
	Thu, 26 Nov 2026 14:13:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaDZ-0000000DUJD-2uTJ
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:12:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 277FE63341;
	Thu, 26 Nov 2026 14:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C101F000D1;
	Thu, 26 Nov 2026 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702376;
	bh=LYH/RuGe2aPlDUYuIjnhsmnOEU9dOO/cT5aSku50wtw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b8LBLd+VPQQFjFhqxExt51TYZ2xkGRP2MqALpxn+CcsE2bE0Pqqj7IHbI+60bathp
	 YjakAVIinpyruwjbf8AXU6zLLab9NfUkGt4Dfq173InYnq+sBhLdyjWacLSfj6ICNW
	 Md0RuoH+kxD0bLR7oKp96lTSZlxSVJKRYPAb8UX+IjXR6WWboJAn8tcGoLHcWL9IBX
	 sYeeoF8J2v+ZLk7iMfgb7Ckk92RlmpzslJwo3G6whZ6NNTON4LIQL/yd/pOPZIzVd6
	 IRTogM8nzR7/gO/mMO6Viy3RVV6Nlwwk6Y3bd5CgVo7C5EuIGIZx6gU5VmuEOnsWVL
	 +j+Ea5UdC0gkg==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:22 +0100
Subject: [PATCH v7 04/14] Documentation/security/keys: fixup function name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-dhchap-keyring-v4-v7-4-ee438ffea527@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=880;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=yIHvpiweIAuxxVqephqS1I279bBXE9X6X4rNhWIZIWw=;
 b=P9JCvPHoMBUj6S7ZxHEhzE1AXDiyS5VrkA3bvYtWeIngAo8wZLiynveeddkoMeMszxGqIE9Wu
 g3IRJ19DLkHA8O5SJXCqMhrlDbD4AikMM5f8RrmVerdMWj64F+5qi75
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

The function is called 'key_validate()', not 'validate_key()'.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 Documentation/security/keys/core.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 37ed42382f1672a5c822e7a042b077ffb84c7abd..c0f69e93e0c5f0efe0ae2e7a45a3a40391346423 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1306,7 +1306,7 @@ payload contents" for more information.
 
  *  To check the validity of a key, this function can be called::
 
-	int validate_key(struct key *key);
+	int key_validate(struct key *key);
 
     This checks that the key in question hasn't expired or and hasn't been
     revoked. Should the key be invalid, error EKEYEXPIRED or EKEYREVOKED will

-- 
2.51.0


