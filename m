Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D67606A32D
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=G+us8Sbc;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwfrQPG6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=edOYJZi2pvk7QHfQ0FQGaT9yr6iTz17TIgeP8+QqIew=; b=G+us8SbctJHHQh
	+bzwIIWPkq81tOz0yK4DiT7cK4xdoi2cgBN8wPrCifSl9lR+8TB3f32sCv3lNe1zYKxjLiMaRLL6q
	uQAtQvY6xCi2WqWUOMPTysiWzY6ZIv4NB83LqiyVX8dx8KKDgSWcaKcA9II9Xzf3yBeQK8UEuRY8B
	4MrCYiWF3+eTFh6yS+zzzaVIW8H4EW+5mQvqSKQFbFbXETl6xDrb8LBpducVZjh4AUgfY1FRPysKY
	qumXxg+05fU5b6vZToY1ZvEVjli9rOclFiFv/s9na+1Q8ZMjrSbN642m8JVIQ8ECjekTCEGtbSmdn
	GtZFjgnWPYyV82ZY5zcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSx9-00000003Jcb-0RC6;
	Mon, 23 Nov 2026 12:15:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSx5-00000003JZO-40oP
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:15:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B2DD34583C;
	Mon, 23 Nov 2026 12:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68551F000C4;
	Mon, 23 Nov 2026 12:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436119;
	bh=edOYJZi2pvk7QHfQ0FQGaT9yr6iTz17TIgeP8+QqIew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MwfrQPG6khZsoQMO0x3LuH/Hucieb93Zcny5lZhsGd9gbPD0NChRJkd4pxL39BvJ1
	 pccrm5P2tE5QECtqGeERKrOBU9X6qYpMxi2rcsQmlt6/SBxtfpBkjKyt1ZfAuHVekt
	 agzBXDz/KxqoC/1psxJcW/GH5cErh7YBbO7c8rh7RC1eTWAs5lGjJT+pQXDe4Ug9OB
	 OAv0PGvNoAsGqMQpIxl+ihi+6yz3wUVH10P5qu+ymghsiupFspdlV3J7xfkfslLLPD
	 W1zMuXFbPvplLyxlT+LQbgEtBkPJGLIJt+Lf/iabGZpibC4R1jM8iGylAP+JWIx3hv
	 OKQ/CkFJW9rYw==
From: Hannes Reinecke <hare@kernel.org>
Date: Mon, 23 Nov 2026 13:14:53 +0100
Subject: [PATCH v5 8/9] nvme-fabrics: allow to pass in keyring by name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-dhchap-keyring-v4-v5-8-81eefb4c0724@kernel.org>
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
In-Reply-To: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795436094; l=2397;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=QIG3YycUOOma1J1ecMRHNnzCF9Qrfo4/YXZow6f9QVM=;
 b=bpLiR53mpxygQYP3CYeStm/+bdH9izRRf48oYzBz0SK4fWuRBCNaQqe6nL5UazzOMFKKOgDbL
 7So0bcYtNjhDByuvNgTaDtzPEr08Ysb6wOTGIWB8Z7fCWkjWbOhIm+7
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

The current interface of passing in keyrings by serial number is very
impractical for configuration scripts, as the serial number is not
persistent across reboots, and so any configuration files will need
to be adjusted.
This patchs allows to specify the TLS keyring by name in addition to
the serial number to simplify configuration file handling.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/fabrics.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1277749c6e2e3012b5161a7d03589a6ced300a05..5dc1e1d5fb4629b82b2bce4d37fe9ce5d17acab6 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -14,6 +14,7 @@
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
 #include <linux/nvme-keyring.h>
+#include <linux/key-type.h>
 
 static DECLARE_RWSEM(nvmf_transports_rwsem);
 static LIST_HEAD_GUARDED(nvmf_transports, nvmf_transports_rwsem);
@@ -697,7 +698,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
 #ifdef CONFIG_NVME_TCP_TLS
-	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
+	{ NVMF_OPT_KEYRING,		"keyring=%s"		},
 	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
 #endif
 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
@@ -992,17 +993,33 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			opts->tos = token;
 			break;
 		case NVMF_OPT_KEYRING:
+#ifdef CONFIG_NVME_KEYRING
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
+#else
+			pr_warn("nvme keyring is disabled\n");
+			ret = -EINVAL;
+			goto out;
+#endif
 			break;
 		case NVMF_OPT_TLS_KEY:
 			if (match_int(args, &key_id) || key_id <= 0) {

-- 
2.51.0


