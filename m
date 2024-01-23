Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7292DC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kQEqGMWVKXmA7nFpvf0m6sEPJ3NAO/uaeeyn8DszEFc=; b=3EqNWiVZCPrnT1CgUQoQzx+3wC
	Ql8vfca6ujgLwARfgIKYT5Hy9z+3sxOdr0hcUvkJJedhS4P/rfxg4y7GP5m14aVct06SqbhuCeX6u
	bMSa+ly0JWqU0rXYGGQiETOl9raVGseP41UdvUrvDlEyWaghg86BnOd1rvkwgLRHfgjh7XovPyxh4
	+dFM2X/aNn4xB8fxP5I6ElQCEpSqNwuPkvwj131QXy6A/WBNi/cdt+VqApgfc3B9vM+nkFLIQIMUM
	PcIUj81nT02HefDY7gmoWxqGwaEWOs1w27vFYlqU5HNf5iSp+kZnfq+IY5FGqnz5ula4DC2sRzc5S
	rFUgVwug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHcl-00Glyg-2d;
	Tue, 23 Jan 2024 14:19:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHcj-00GluI-00
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:19:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D350261C21;
	Tue, 23 Jan 2024 14:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761B9C433F1;
	Tue, 23 Jan 2024 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706019572;
	bh=T1Wi2IqSiixqgOaKONxfDGpaobOCyYqB1XrVZKVX0a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JPqc8/OyLMb3NL2YBfEBThw7UQJA+zBoFbTL5QA2HOxWdTTh0tqadU3u9INVWBKlB
	 bdM9zfqxlVB5HNH0upymTBHOYvH2AI9gxNgDFoD2GOoTqhnSoco/6BFJisX6rz6h79
	 g/Pf+x2FhYhiu3FKgPjGeeRzK0j6xSpXxqw11KhwpnS/ntcdSjLuRd8gV6madpme2l
	 CgN90BofzvzrJ/60lCceNQkkt8TilADynuOdIP05k6Mnyn+i2fqhWitHJUZwqXxkh9
	 30pyz6heWuskyTxSCMpvNJlfRXz6GaYsT4XYxNmrBiTAzCTU0EAPjr1AWoaRQlN9kU
	 MHhsJVk0usFXA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/11] nvme-keyring: restrict match length for version '1' identifiers
Date: Tue, 23 Jan 2024 15:19:04 +0100
Message-Id: <20240123141909.79061-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123141909.79061-1-hare@kernel.org>
References: <20240123141909.79061-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_061933_078592_75DD87DF 
X-CRM114-Status: GOOD (  11.85  )
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


