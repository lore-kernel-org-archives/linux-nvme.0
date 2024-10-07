Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A823CFB43F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h1FawApM2aIB6E2XvXUi8asmntH9qHiDargot46LGxc=; b=p+TL56zoG9PLw5AmxUyxnseXuS
	D3W7dDMyjP37hy5cAPQOdTmetbeCUVVP/LaVc4EmT4c4VOlFJqqdiLNdTsm8bBP4vjn8ev0fN+SmP
	8YIV9Z0SV5Fr2LeeJhtiar18P/MFsKU3iD4paX2w+jqqXpneatOz35ShlvtHZDsuOOmLjXJ9AAQH3
	EgUV7PHFmvRH4QJugQONxFnUYnUjHFEafXp9c6DlJEi3LulZiPbsZIIoTMvQz1l6bGLXLW/pK8qTQ
	i/pYxArdCoEcYmU8tx4emkX1d128UMAC6PE3LmW6MxMTgfR8CHTEjjhl8SMTGYdtd6zJwqL8NSFLC
	Lt+CPVbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkZB-00000001zEt-2dGO;
	Mon, 07 Oct 2024 10:02:13 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkYo-00000001z9a-1ucD
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 10:01:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0BE1CA41908;
	Mon,  7 Oct 2024 10:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A242C4CECD;
	Mon,  7 Oct 2024 10:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728295309;
	bh=x8d8wJoguX/+F7YAY7HX5yxtr1+LJREtq/Yg21zHnNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VO44/BGqQR6ttn9mH18qSprQtMamUqqF3Sc/EkaHBAmJ5guoKtybIIb/X8X1ggW1w
	 lIoid6fba32lVkcLe/RWuQbDGpkTxFpSe9Al+7qqcNmo7dMSQW7FM8/2Nj6D6FmfPC
	 ax79WvYpIRAy0zNwOdTZRNcybfMcZX09hQbkc0DCmTASK7U9o4dOTK1uGvww2MEQwl
	 VFl2Jl08cbf8Si3QSJVIB+Z3t0Hz+2rifvIj9OZQEnQSAHGOKKHG8SLxMyQy08sKTB
	 cHQSLid7ScJ/K1Gl3Lhf9sUGv9TJJzfRlISUU7jTAOoGfwXBxhuQEXVndw3ptBIsXw
	 rXdv3OZHBr3lQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/3] nvme-multipath: cannot disconnect controller on stuck partition scan
Date: Mon,  7 Oct 2024 12:01:33 +0200
Message-Id: <20241007100134.21104-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241007100134.21104-1-hare@kernel.org>
References: <20241007100134.21104-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_030150_672573_4F53D466 
X-CRM114-Status: GOOD (  12.82  )
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

When a namespace state is changed during partition scan triggered via
nvme_scan_ns->nvme_mpath_set_live()->device_add_disk()
I/O might be returned with a path error, causing it to be retried on
other paths. But if this happens to be the last path the process will
be stuck.
Trying to disconnect this controller will call

nvme_unquiesce_io_queues()
flush_work(&ctrl_scan_work)

where the first should abort/retry all I/O pending during
scan such that the following 'flush_work' can succeeed.
However, we explicitly do _not_ ignore paths from deleted controllers
in nvme_mpath_is_disabled(), so that I/O on these devices
will be _retried_, not aborted, and the scanning process
continues to be stuck. So the process to disconnect the
controller will be stuck in flush_work(), and that controller
and all namespaces become unusable until the system is rebooted.

Fixes: ecca390e8056 ("nvme: fix deadlock in disconnect during scan_work and/or ana_work")

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 61f8ae199288..f03ef983a75f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -239,6 +239,13 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
 
+	/*
+	 * Skip deleted controllers for I/O from partition scan
+	 */
+	if (state == NVME_CTRL_DELETING &&
+	    mutex_is_locked(&ns->ctrl->scan_lock))
+		return true;
+
 	/*
 	 * We don't treat NVME_CTRL_DELETING as a disabled path as I/O should
 	 * still be able to complete assuming that the controller is connected.
-- 
2.35.3


