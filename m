Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BDCC3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TlDDpX5Rlxdsb+uOPKCdGiqUd/jvI/IKpf8EKLETTd8=; b=3mSRCKvNOOS6BLPcazzBYMxmpF
	AL1EB3qlY094gxcWgpRCtNMyOB0ud8Apj6jwYSEXJx7rLLi8gSUtgg/NHQ0rjj+4scZ/GqL/N/Gqw
	i4I/5S1ljal9gxprmu9DDssJtbsQmhGJtPtH7uqj/b6J+f21Sixfs2ibDb+W0Jp+WB9HP4ske2Evm
	BZmyIAzhRPPJ31Op/LU4y/7/OlNU/bEwCFfZXfBhq8se6RCHyai+fl7RZMxzAJq1YLHwt5sMQGxIT
	abJPjQVBdpr3OSSwJW3lxjrHyjIVUfGlWRw+q5J6bbcc/2hSpeBPQkwzAqJ+Xh0EwLzkcyDiJ2LHG
	grh62phQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRw-0000000HKbQ-0YPo;
	Thu, 18 Jul 2024 14:49:40 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRo-0000000HKTo-46Ne
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 14:49:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B7106CE1A35;
	Thu, 18 Jul 2024 14:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FB9C4AF09;
	Thu, 18 Jul 2024 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721314169;
	bh=Q8zoK18+LwzdilPBi5wEy5PBS08P2O1n25/4i1hDRb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxdegmMgtee6jpFgAPskp8ncVeW96tl9vhneArqzJ3Rbd35Lb6ygDvBJ+HqA6Ja/G
	 3vCqyAL+ntZs8r3YqMFrHgKpZZ5lI2kwMS4rXYytZ8exWdbBISLg047RVUuXYVogoY
	 DzpiiinxiOGFIGfDXKOGemsOcEKui+BK2+v1bv3ivnXJXi+/OVcT43OIv3PznuVDSk
	 6J7+3LYCD8LFj2ezVtqbWs8lZLzCrNxPvmJY6Oh/J4uuq5IEz88otG02dCW8j5UVMn
	 62JdXI54KWusGceht7mfkx1pNeNFB2qi47kYNQp8YQtXcomLByYE3l1U+p+JYj1Ze7
	 zScqEAatx5geQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 8/8] nvme-target: do not check authentication status for admin commands twice
Date: Thu, 18 Jul 2024 16:48:58 +0200
Message-Id: <20240718144858.19074-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240718144858.19074-1-hare@kernel.org>
References: <20240718144858.19074-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_074933_565673_5C9372A6 
X-CRM114-Status: GOOD (  10.25  )
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


