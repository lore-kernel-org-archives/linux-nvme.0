Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C8606A6B8
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yhSMaaeV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6ZEaits
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Fs3FqRZzbQW0RewIgCSZdDBXczxL1ml7PaOPSTLmICY=; b=yhSMaaeVh2MpbW
	4qzsxLqWoiZQwd8piPpRWH33P3h+VArCNs5e2AraMSBnN54OWR4MSjWky/sQVZmE5/aykQcIo3ZI1
	gLQgCzm08T/1+s1+mfuIU27aoiGsIWreklIqIar68ORQKBiL+SLXq2mCmAenU2aBc3cP46aKjzBEV
	FNkGouwOIPkCeIym7qOJgOffJx+MJ7lKIq7cbMoL9cXBAgR1KAgPNr/68Mk/cprbHe0XzAew5W6OT
	qoZP5PMTIrWINAfti3Gh1pikwgrc5G12hYz2vsngCaVGLJJ8rY6k5XRHpRgOnfD1dYsZnb5pGtpTr
	tDWVW+dl4hNTD7LNKRNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXYt-00000004J5T-30cq;
	Mon, 23 Nov 2026 17:10:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXYp-00000004Izw-3loX
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:10:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B03840796;
	Mon, 23 Nov 2026 17:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4BE1F00AD3;
	Mon, 23 Nov 2026 17:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795453835;
	bh=Fs3FqRZzbQW0RewIgCSZdDBXczxL1ml7PaOPSTLmICY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=B6ZEaitsb8F6ruj0sbwOJpHqUJdoG6rCPd9eSRnw+Q1/n3PPlO9b1+Nj6cwN+pPuO
	 byyIKlJZkcQIaUTNjzVUtMdU0A6XuKYQq0+iE9DtOKwQEHTAesYzdjVeGLmTpcEBEj
	 bU28Yt9iax38UNGXDtOOAP97GL2FfiefFGfuhChtYFiwk6pxY2mTRLFevUeqYCxOzq
	 UcOS2K9H7RsSZMXN56fZis4wMznBpR7aQfCpKr4GZv2+k8fN3T3xe/SQLc3hDJqq+H
	 LnA2PXuRpOtcw4f1gf6bjgb0nkTgk2FwFaqp6Z+GzurTGAE3lH+kUqs1ymjiSUEsa5
	 Ybak8gTuU3CmA==
From: Hannes Reinecke <hare@kernel.org>
Date: Mon, 23 Nov 2026 18:10:08 +0100
Subject: [PATCH v6 8/9] nvme-fabrics: allow to pass in keyring by name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-dhchap-keyring-v4-v6-8-5082a49715ab@kernel.org>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
In-Reply-To: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795453811; l=2420;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=ITKJc1nZRUkbL6beI0dJDy5VCw8yabe1G6B7/FWmKhA=;
 b=kNH+ZvatLTk1c/SMb9GRdgbdE6NknztFK3IUvfXpL55/dyQv6VaZzLoLXtCqIIzMpoxbymgZx
 Pa7nxxQCtV5COCC4laAHKl5FM7bK5uqC7rOLFZ1qlqjkSoBhPN9peBA
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
 drivers/nvme/host/fabrics.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2937e5dc9ecd22fd3eb684e2dce909b41e5a6e20..aae094bbbf0dddfa507acae5e35ba94ffdbcb245 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -14,6 +14,7 @@
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
 #include <linux/nvme-keyring.h>
+#include <linux/key-type.h>
 
 static DECLARE_RWSEM(nvmf_transports_rwsem);
 static LIST_HEAD_GUARDED(nvmf_transports, nvmf_transports_rwsem);
@@ -696,8 +697,10 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+#if IS_ENABLED(CONFIG_NVME_KEYRING)
+	{ NVMF_OPT_KEYRING,		"keyring=%s"		},
+#endif
 #ifdef CONFIG_NVME_TCP_TLS
-	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
 	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
 #endif
 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
@@ -992,17 +995,29 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			opts->tos = token;
 			break;
 		case NVMF_OPT_KEYRING:
+#if IS_ENABLED(CONFIG_NVME_KEYRING)
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
+#endif
 			break;
 		case NVMF_OPT_TLS_KEY:
 			if (match_int(args, &key_id) || key_id <= 0) {

-- 
2.51.0


