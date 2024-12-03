Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EB9E64A80
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eF5nxNlgrdBEAkkELj2TVNYNGukp2JLHOlG8pKynu1g=; b=00vxJqBEhw5qMQrm8EUTP25iaE
	lhg1vbCoIyzIGj7oNWWFbS1UVZwCSOpMdBz8GExNOpXBc0KdXZHGWrZiiZpr2uw30V2maPO1rmFWl
	NsN2forp7bQaC2QO9VguXEWX9n0aWpscOeBOmDQp3n9I1okuBcND8EXTfEcTPKQzqSxd1GZ0EFgXZ
	N1MLNPwT7fK7firSrK2MBIK9Ftd6ooEql0C+6GovCqngrZNtfvzRbe6mx2+6kZilYM938VJnYevpu
	OQT0btO+ZhhxTOr9EXBTo8VzWVtaHTf/fRYrJfKN5AVrRS8TBv2C6S3ItTqBlbLUUWExRCtcp9Fx1
	Byw2TkVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQru-00000009E94-3AWQ;
	Tue, 03 Dec 2024 11:15:02 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQgP-00000009BU0-4675
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 11:03:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F162AA40C0E;
	Tue,  3 Dec 2024 11:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FED4C4CECF;
	Tue,  3 Dec 2024 11:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733223788;
	bh=HWMQCj01jHX4+s5mWusey4esbb+DqmOUgYumbOZlkCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFyUFMI7yBR73deP3Ew55VC0dgfs1oOIeHUkNetY44JYP++Fs5FS2GRPLP/Cnn7ww
	 bObnG8aFCRx5adlAjSQ+6XRR+G+tLkl22bW3wl55TSCOOTj66XGtUhiNmNY0+kDCoD
	 ir6KLFLtB8ySgQBAmKPd8cWLhEs5XgKuhPiexUI8cX/z6bWEIODB/eDQ1oRlLaXeNE
	 KWWsPnVsQ5qoCtw9EQyWmPjW0XlGPJGdccEs3H1ZYH5Hrj5o1rRL/radX0jw05RAwU
	 1mcyHvt4uiYSfqR2rnBDiku4MizwZ2tktoHuJO+iC2mAdt3INvYU7ZVhuZ5lUWuCgn
	 byRAGuqwik7pA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 06/10] nvme: always include <linux/key.h>
Date: Tue,  3 Dec 2024 12:02:34 +0100
Message-Id: <20241203110238.128630-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241203110238.128630-1-hare@kernel.org>
References: <20241203110238.128630-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_030310_074035_E0E9C77C 
X-CRM114-Status: GOOD (  10.41  )
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

To avoid build errors when NVME_KEYRING is not set.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/keyring.c | 1 -
 drivers/nvme/host/tcp.c       | 1 -
 drivers/nvme/target/tcp.c     | 1 -
 include/linux/nvme-keyring.h  | 2 ++
 4 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 8cb253fcd586..32d16c53133b 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -5,7 +5,6 @@
 
 #include <linux/module.h>
 #include <linux/seq_file.h>
-#include <linux/key.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
 #include <linux/nvme.h>
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e416af2659f..b5e11a0f7ba8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -8,7 +8,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/key.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
 #include <net/sock.h>
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..fa59a7996efa 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -8,7 +8,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/key.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
 #include <net/sock.h>
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index f7bbcbeb4b13..ab8971afa973 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -6,6 +6,8 @@
 #ifndef _NVME_KEYRING_H
 #define _NVME_KEYRING_H
 
+#include <linux/key.h>
+
 #if IS_ENABLED(CONFIG_NVME_KEYRING)
 
 struct key *nvme_tls_psk_refresh(struct key *keyring,
-- 
2.35.3


