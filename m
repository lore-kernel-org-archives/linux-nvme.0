Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE610FF60E9
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2026 08:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L5P7yq7BVs/khnm3XxF9tFrKpSkJd288K2JNJwwVvfs=; b=hjlyZYQqF61rEho/kqlDlZuThM
	uuPy9YUCCKBw0g72JCay7N+9mh366XZfGIQ+f3g1hMsXfOsf5B/xdsEZ709l7ZVIQGAvw0aU8API0
	2cFkpPZs8nS5lV1efa8GwM0k0vUnaSYGUCEGEH7g6ezvjSe5GJGgxLTBHjcQ7MCOszTcGXsh2Ogkn
	YEwHhUXRJOTlLAMjBHCFoZNwrkDFUJx06x8eWPn7tFDXFXeyWdsAZfR3dIvWCYDRTWwmOc13Lmcm1
	rApo6EuqUJyiWzFN9AMuDliM49xUcU+fGVzW2AupO9u114v0mH5gYZgBX6zGBODs/M4jIzMV/JJcn
	EhtZt3aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7UIS-0000000CZHK-2WoI;
	Tue, 31 Mar 2026 08:18:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7UIQ-0000000CZHD-29cP
	for linux-nvme@lists.infradead.org;
	Tue, 31 Mar 2026 08:17:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5238E60131;
	Tue, 31 Mar 2026 08:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE1FC19423;
	Tue, 31 Mar 2026 08:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774945077;
	bh=s6zLHwh8a097n/NPx1xb4PNBD5Q0+sFQi2geiLQl6wc=;
	h=From:To:Cc:Subject:Date:From;
	b=a/AT89E/CV0I5DHlE+G+ByCCSri2VoTRBVysr60dFs42tx3dkAmJtQa6GZkeaBryU
	 bGL/ciZBZHUHQAx5MA6gIgnF4+foStd3AX2Uzrr6xaCU/e4X8VXGt1s/5/QwvOWScX
	 OutUjFYyAT4fVQm41pIpGHGMsFJSKEjXn2D2bqGDh3FzmGBEroJZK+DLySxsnANraY
	 l3g5vQCROHBesIBq+bB6+N3Fpna2YofvTEiKziI9sIVuM0fR6RiGdMdPug9xnWppPV
	 N63svnsb7g5fpHaGGgHMZnELAu2Bf7kVfOI8owYM1H6KN1xCSu53RlQ79HzpeeFFuw
	 /UR9dTOTs2uhw==
From: Geliang Tang <geliang@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: add missing MODULE_ALIAS for fabrics transports
Date: Tue, 31 Mar 2026 16:17:31 +0800
Message-ID: <e3076c80ee2e0c4a2cae0374afb617a3365946ea.1774944415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
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

From: Geliang Tang <tanggeliang@kylinos.cn>

The generic fabrics layer uses request_module("nvme-%s", opts->transport)
to auto-load transport modules. Currently, the nvme-tcp, nvme-rdma, and
nvme-fc modules lack MODULE_ALIAS entries for these names, which prevents
the kernel from automatically finding and loading them when requested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
Hi,

Recently, I've been working on adding MPTCP support for NVMe over TCP, so
I added a new transport called "nvme-mptcp". The AI review in [1] reminded
me that I should add MODULE_ALIAS("nvme-mptcp"). Then I checked the other
transports and found that they were all missing the MODULE_ALIAS as well.
I felt it was necessary to add them, so I sent this patch.

Thanks,
-Geliang

[1]
https://sashiko.dev/#/patchset/cover.1774862875.git.tanggeliang@kylinos.cn
---
 drivers/nvme/host/fc.c   | 1 +
 drivers/nvme/host/rdma.c | 1 +
 drivers/nvme/host/tcp.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e1bb4707183c..e4f4528fe2a2 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3968,3 +3968,4 @@ module_exit(nvme_fc_exit_module);
 
 MODULE_DESCRIPTION("NVMe host FC transport driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("nvme-fc");
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 57111139e84f..1ec6e867aedb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2432,3 +2432,4 @@ module_exit(nvme_rdma_cleanup_module);
 
 MODULE_DESCRIPTION("NVMe host RDMA transport driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("nvme-rdma");
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 243dab830dc8..02c95c32b07e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3071,3 +3071,4 @@ module_exit(nvme_tcp_cleanup_module);
 
 MODULE_DESCRIPTION("NVMe host TCP transport driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("nvme-tcp");
-- 
2.51.0


