Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54172606A33A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UbgOE/Cm;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAn9CKVD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TFaLTkb3JIz7GQaQVuyrLV1Wx+zOtsmXJl8m0I4Yjds=; b=UbgOE/CmiJv3nC
	iOD98pUINv3y8Yyavlf5uA7p+pMk0i+f+lKZwL/1xAszjTAJAMF2JNwdBYp0SjXdSurZyA0uX5/Mt
	8PA7eySWtaLpRog3r9LXwYJW3RHrTjEHkaFRqXwOnAiiWzsjxutoTnIpNs5WCriuT4Jz8Y/VAFIb/
	Dc7lFLyKxj3aiAzDuDx1CDdsKichT+aN2kQb9nTbzu00TSZc/Wg9GeepFjwMwEpynktlFV9Pw0v8f
	uEwLqaUF8AbfeMV8026kxYTgWFoxLU8wjFuEfhaNHX6M6LyReam3PHTQkmElS8yNANd8Rt9pR+h4/
	iKK6B/0qN6iuAOhp9q4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZq-0000000Ekyz-3Lia;
	Fri, 20 Nov 2026 11:14:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZk-0000000EkqS-3beo
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:14:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5160D6294E;
	Fri, 20 Nov 2026 11:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC671F000F2;
	Fri, 20 Nov 2026 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173280;
	bh=TFaLTkb3JIz7GQaQVuyrLV1Wx+zOtsmXJl8m0I4Yjds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FAn9CKVDAfPfOVfV5KlNbHOpQRdf9ryKwCmTkQovpPuEjgwCZDhtUeWvFQnbEdyo3
	 nlabDeV0nw5uTz84yUl03ROr84QbhyWD2jQs1RzewuPHB/VsnA12ieMh1p0hng/M97
	 VgWaDM9R6HmVmiNC+IBn7PVEINLidwW+SiO0msR1CfGf/B9pdJ1ruj+7qhVG0ZE52j
	 Cmu8UdcVPdOpZWwDHIH2bRF3NhFcgbrGb5qhWcE+0anFJ/7eEZtIzfVg+qfC+nw4Sp
	 ZiiI+/osGw0uDtqrhhje6ZBG9bjHza/OO1oeEexHkjxmx1g8BPqAl9Jw6eVE4cjRie
	 XOPWNdltRvLYQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 20 Nov 2026 12:14:07 +0100
Subject: [PATCH v4 8/9] nvme-fabrics: allow to pass in keyring by name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-dhchap-keyring-v4-v4-8-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
In-Reply-To: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795173255; l=1784;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=f1C93uiJ/WUy1raIiWqFOPTRT80iE/5VXapinRQ4azg=;
 b=ANpghUVOkX3/OVC+8DmErShCCbT6qgn94Wji2tFxC4mJxTvz2DLxM/Bor9PyeKcQ9wknYdszT
 XVMfZ385NOjCIh7RoyozBZSJQkM7ZG17UUI2n2kQ8a37yYsScFksf1w
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
 drivers/nvme/host/fabrics.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index cd728768a68fc41135967cae44b1c3c5b0676dd3..71da67b543aa49b6e1a3721313d984f2e50e0ab4 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -14,6 +14,7 @@
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
 #include <linux/nvme-keyring.h>
+#include <linux/key-type.h>
 
 static DECLARE_RWSEM(nvmf_transports_rwsem);
 static LIST_HEAD_GUARDED(nvmf_transports, nvmf_transports_rwsem);
@@ -993,13 +994,23 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
2.51.0


