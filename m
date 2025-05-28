Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1FFC3ABB2
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+XIyEKJOxesue66izc5v8twAz/r+0Hd20DqqxcwPFZE=; b=mNeyLTUUdKnc5i+9CtaU3U4nPP
	9cimAQnk3Zkcg4QShTFf+S3qV/qsII4wC/RGjEGLjJ7M09NpD9ShMpmaoDEy0rHoVrtsmjoA3CWd1
	zykmnRsWVvFe6nEPftLJHTARxT2c2kRBa6nJXbnHyRyVB1DvrwxXCIvPUQ0Anm2Xt/kNitx1l7yjl
	IuEdM199Z5RAi9MBCl3C4dAoichLcc5mo1o7Ur3ZuUfUlwZwgl9xKWPOf3p1ewZUTQwwh0KdDXHYd
	vLk/TZ4TxRxPIAoEX8Wcq+tWVbM+2GePG5ATHgFlEz/avO7NSR9hE6Y4s5HUsJ8E7ryawZlHBQgph
	VMfP1ftw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHdK-0000000DN6C-2yYJ;
	Wed, 28 May 2025 14:19:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHSZ-0000000DKSg-3n8j
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 14:08:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A354E4A21D;
	Wed, 28 May 2025 14:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34293C4CEE7;
	Wed, 28 May 2025 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748441327;
	bh=O6HTm/wgEuNDzQyc/JWz9e51v7xN1Tr6uH06HIJYOZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4s+Hzt61Ty4RKTYnPs3HeOyULp7AEpaLLhzWLn34OUZkcAz9aFricaWvnfJgeM5T
	 VeklOhwWMyWjzFYPhHM9LBp5Mftf1TfjFmE8gOfC6REKup+5p0YqepxyEl5U3CTpUa
	 j6dWJV4Sy7fRjuhYqfOplO6Wl8Ij44dGojyti4zzLLh5FUKeiFqWjLZ5AH/t+UN/px
	 1hkk2g+rru49+5hZsXgUGszIZEW9FD7415FDjqIu7CRZhisC5+tguo6D0v3RMCTT0o
	 jGKAqzshOr8iTVHRyRwCbBFcy75iGijYtvQYAHXE7TO68Lhd4V0W5MY5yI4A/bgI7i
	 emPqJUa7l52AQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 8/9] nvme-fabrics: allow to pass in keyring by name
Date: Wed, 28 May 2025 16:05:16 +0200
Message-Id: <20250528140517.3284-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250528140517.3284-1-hare@kernel.org>
References: <20250528140517.3284-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_070847_967529_E7AC497C 
X-CRM114-Status: GOOD (  12.01  )
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

The JSON configuration should be system independent, so we cannot
list any key serial numbers. So this patch allows to specify the TLS keyring
by name and not only by key serial number.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/fabrics.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 6ec94c4f6075..d0f8c40cebb8 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -14,6 +14,7 @@
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
 #include <linux/nvme-keyring.h>
+#include <linux/key-type.h>
 
 static LIST_HEAD(nvmf_transports);
 static DECLARE_RWSEM(nvmf_transports_rwsem);
@@ -999,13 +1000,23 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			break;
 		case NVMF_OPT_KEYRING:
 			if (match_int(args, &key_id) || key_id <= 0) {
-				ret = -EINVAL;
-				goto out;
-			}
-			key = nvmf_parse_key(key_id);
-			if (IS_ERR(key)) {
-				ret = PTR_ERR(key);
-				goto out;
+				p = match_strdup(args);
+				if (!p) {
+					ret = -ENOMEM;
+					goto out;
+				}
+				key = request_key(&key_type_keyring, p, NULL);
+				kfree(p);
+				if (IS_ERR(key)) {
+					ret = PTR_ERR(key);
+					goto out;
+				}
+			} else {
+				key = nvmf_parse_key(key_id);
+				if (IS_ERR(key)) {
+					ret = PTR_ERR(key);
+					goto out;
+				}
 			}
 			key_put(opts->keyring);
 			opts->keyring = key;
-- 
2.35.3


