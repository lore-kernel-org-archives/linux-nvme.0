Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE993C46CD2
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kQEqGMWVKXmA7nFpvf0m6sEPJ3NAO/uaeeyn8DszEFc=; b=zYSW8YmbJt2j1mmia4lWYIhxoL
	8un56SBXA0agATAJdp2759OUzXhnDN1fA4eKAqxe9SSgc6wEMdVYDi2lXaa1kwpV3NbiCqoc6Lgb7
	s1lY6FyePKZxB3StawxRekzYVutU8KZZdc4TtAbEefTytfhvJUjjUDAhMdSHED/ppvgcU+rGqiATz
	T2B4Ww0QdRjsKnxAJA4qIwOpm0Bgv4bL8ZuXWLrwmx46wiAlxP1QMElCTFdMgFZDzm3BjBsHMMWgq
	/f+tnSHEI3RVdGklRiNUgdX8RFIN/bXrvqNMG6oQaSXZ841hR/hiw7sujOW1qhMdEgQie4pwy+dkR
	sE1ucxxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf21-00000007Fa8-0YEO;
	Sat, 27 Jan 2024 09:31:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf1u-00000007FT0-0g4K
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 09:31:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 99AD960BEB;
	Sat, 27 Jan 2024 09:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E431C43399;
	Sat, 27 Jan 2024 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706347873;
	bh=T1Wi2IqSiixqgOaKONxfDGpaobOCyYqB1XrVZKVX0a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZzNQv8HCBJUffEZ4Ekoouz397tLCowu9OCUBCgPDXyC2yD/5F1gFvvWb9AM/8vZ8
	 DuZRJkt96yf1P1JH2KMcbcvJrYHLFhY8dYkbfBmbrBOL7jlWzytimQfwyvicJv8hdu
	 PFwngtmjbp8lEPnGMu4vI0+j6PnHLwhE7JgrdqvkvoDzTAXa8nCpY/U+twVBA7a1TM
	 fegqnUnKAp1LVoghw35F4wRTuC5I7v0vpjQZucPqFYhXA/794WLR8lSXWkLXc7tq71
	 1N6Bwdi2/u/IXpU7opGuF5oUsm8eej/pXn3rCMiD4AMmOzLaMD6Ybbb91CRTjWH1pQ
	 yCTcaXb5YZinA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/13] nvme-keyring: restrict match length for version '1' identifiers
Date: Sat, 27 Jan 2024 10:30:51 +0100
Message-Id: <20240127093058.15699-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240127093058.15699-1-hare@kernel.org>
References: <20240127093058.15699-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_013114_276865_7BCF2A4F 
X-CRM114-Status: GOOD (  11.42  )
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

From: Hannes Reinecke <hare@suse.de>

TP8018 changed the TLS PSK identifiers to append a PSK hash value,
so to lookup any version '1' identifiers we need to restrict the
match length to exclude the PSK hash value (which we don't have
when looking up keys).

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/common/keyring.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index c16f9496643f..51b99b34e100 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -44,6 +44,27 @@ static bool nvme_tls_psk_match(const struct key *key,
 		return false;
 	}
 	match_id = match_data->raw_data;
+	if (memcmp(match_id, "NVMe1", 5)) {
+		char *e = (char *)match_id;
+		size_t offset = 0;
+		int n = 0;
+
+		while (*e != ' ' && offset < match_len) {
+			if (*e == ' ') {
+				n++;
+				if (n == 3)
+					break;
+			}
+			e++;
+			offset++;
+		}
+		if (n != 3) {
+			pr_debug("%s: error parsing '%s'\n",
+				 __func__, match_id);
+			return false;
+		}
+		match_len = offset;
+	}
 	pr_debug("%s: match '%s' '%s' len %zd\n",
 		 __func__, match_id, key->description, match_len);
 	return !memcmp(key->description, match_id, match_len);
-- 
2.35.3


