Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9483DC3DA59
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 12:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gvuqq1Y40CkNlRc27HbVDJOOg8mtTS03BNLU2TiiDaE=; b=2qi0hWn70TOxMW69vYXyIxx6qU
	Lu7TELc5fdk3Kq8TAjRrvMwB0s4reYDn5Yalu72cMKCB6JM7qaM1j32hYTH7WbN/ingcvltur3ULr
	+4s2uMEslRhjDWSbT9xpqf8KfB6OEVZxhdU+rgm5iIJOf7SF05R1snT6V3hYhy5d+mSLLcBHnT+6Q
	Za1+GNRsk9cokz3ikSUyGkRSSLAJwhFK9lw6fC84TxMkMS+Z4sjR+qM6QI6pIOXjPlWbJomzExqfs
	J97Eh9LVLlAgbzSpAqAA6tUvx8WwvTJftZ3duXgURUYDMquuVBTBAz2exR8L/UDkmE5tuUpF/6ELH
	nRNNjP7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkm-00000009Smb-2xJQ;
	Mon, 22 Jul 2024 12:02:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkc-00000009SdQ-2vTP
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 12:02:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EF66060B2D;
	Mon, 22 Jul 2024 12:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85170C4AF13;
	Mon, 22 Jul 2024 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721649765;
	bh=Ct3yntYKwmCmb0uFolRW5QmEppdd4ydogYoNtk2aY0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PxvOQA+V1INph/qVUL7C51KUefA8wFY3p5zSp1J5HlJX3wgkV3T5xVpyJlW9s4Jlm
	 i+T/XYXoC5lwZ61WkIAsRePCQ+f8Rlbp99eGrCVl/e1QtNqVUIu/wEbmluFs9C1Y9Y
	 Eu24PzE9b25HnElHNfNp3AwIkCWD9TbZuArcwc2nFqcvQdk9FnxSCFCILwM7rNkzTP
	 GDQSZBoTgZnE3xEi3PpfCPWiag12h/d01qW1pOidltJRTcTjnOaS44fbUcVAw5ZiEw
	 aV0DY2hOqsqmLFvbBhbCR+rcc0V/cbeFR1UI7Mqe17rnE+v7vBTpcRSMOBVHA1/0o1
	 9hM+Q3WR1ko0g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 9/9] nvme-target: do not check authentication status for admin commands twice
Date: Mon, 22 Jul 2024 14:02:26 +0200
Message-Id: <20240722120226.88737-10-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722120226.88737-1-hare@kernel.org>
References: <20240722120226.88737-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_050246_863909_29AC26E7 
X-CRM114-Status: GOOD (  10.85  )
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

nvmet_check_ctrl_status() checks the authentication status, so
we don't need to do that prior to calling it.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f7e1156ac7ec..d64480f01f4a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1005,8 +1005,6 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 	if (nvme_is_fabrics(cmd))
 		return nvmet_parse_fabrics_admin_cmd(req);
-	if (unlikely(!nvmet_check_auth_status(req)))
-		return NVME_SC_AUTH_REQUIRED | NVME_STATUS_DNR;
 	if (nvmet_is_disc_subsys(nvmet_req_subsys(req)))
 		return nvmet_parse_discovery_cmd(req);
 
-- 
2.35.3


