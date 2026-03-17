Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AE5FD8763
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XU0qoVF+lmyRC8niwqQS2/sCrOVWulkRhUX2es6FP0g=; b=uk/5gpV71LdB9aTU4v/0Xth8PO
	lRVxgiVn9tP45UL9LBy2gHDrS3rnt0rWr6j4Djccp7Cdr1DhukEuPzd3YMBwAJEbhvPqqvqT2cW/Y
	Xfmx/DT2ypZuOLi54twE2fF8y1MqDFc+eJlRmrZkKwEjM2h+sJsqUion9rg5rbNwV+C2W7yLXN2Pg
	17KNUyYH9fjbNGiMYFnRYqhY0BwPXaSuZRKKUZN5H56iucNSxomS1qBXi8WOB0yV8AZxc1zdq3JaQ
	+deIHendYvZGNn8iumQiuRGvv6xsXDVJVSItrAfc7j87K6DPgHY+gPGUmI7u79FjC6jGjTiRsvgtk
	dSbq4vIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U3B-00000006Lmw-2WCV;
	Tue, 17 Mar 2026 13:01:33 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U39-00000006Lkq-2NEp
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 13:01:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 04A7360127;
	Tue, 17 Mar 2026 13:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7C3C2BCB2;
	Tue, 17 Mar 2026 13:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773752490;
	bh=qgULD96tAIAMRhIZ393SvL3h0/wZJ/wtZN3yO11fXew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KjDeuhV4/f1OYnQpcqXi9V5LvlHsVV+tpMNuAqcRgbub920hd11nW63AeiG6+ZpA8
	 xpsO2DFz/Q3n6o/N0ZKbs+ITbg6LKKnkj5pQEARhNul25FeUfUDGW6BogSSKdS/6/q
	 IuQcEUeT7wEdY9z5FnkyFuKlHPRcpUzROAYGuCiFLSHRjxvXZ+otplfcwSmANjJJpq
	 ahlEjStkXWkz7ZStfpODEuwZX8FqtkdHlPDShLpXCE6BJVuZyPIBUjN2CLxveGK0JS
	 /gy/YW2u4u4jIcT1e/HpFsqTk/BV6VezyipC5Y4fU8X3NNKvPrAL+g4XBbDWcPhe9Y
	 wC05E08BjbyTQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 8/8] nvme-fabrics: allow to pass in keyring by name
Date: Tue, 17 Mar 2026 14:01:03 +0100
Message-ID: <20260317130103.107360-9-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317130103.107360-1-hare@kernel.org>
References: <20260317130103.107360-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 84bd2d7718db..a187acc4d3de 100644
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
2.43.0


