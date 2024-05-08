Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A96DC04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FLqzLnVc2Ewqk3/FbcGCNCYQdpLn3yX6ZfcpRLOSobs=; b=Eeh0RqSv0tLZer9tHEQJCvPzU1
	cofHJVIRCl89cIJy4MVtfC+1zhRIIkxA4Uyhmf9VGZRiJ22pXhpHh32KSntcKMnbZllForTJxUq80
	Ni5dNzW+0zt7+iJfeAmSf1mmWvtpXpN+ahbn0UkMBQuPQ37kt4DnBN1fO7l0EHdvum4V0TCygZLy8
	EqTSnsYbfzbko07CLaPulT+SyQ2tyXdl6G1/Sw3zCQAJD6qQu2OdbNntQKclGq/5+7pnPLUZQ3tTb
	8oe23GhLuyjN63Ap+MoySv/ilirEtf31h/0FsTQ5ywH5mU8rz9un7QlpiYQN1ywzAuawra6i1p4HC
	ccYg1aoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4fVy-0000000FEMv-0Ujc;
	Wed, 08 May 2024 11:31:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eSm-0000000Ey7G-3Q8i
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 10:23:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8DB02619EE;
	Wed,  8 May 2024 10:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0339AC4AF17;
	Wed,  8 May 2024 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163832;
	bh=57ZwYNGNM8DMXGYSRt05l9FvFHP+4LIk9QtjOEKxLF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tesbwylIwbcggCgCM90cvYv/Ac/szvunUz3luSxE9EtYMbXx80CUmTxGvi8mhDYC1
	 HPSXUKeMQHV1htN1GP5IAGnYpyyn9C0CX4xHvv/udE/0SYe/2pZ4v7tl7apl89Hj7t
	 gjJaHRvfWVzAqswWTz4IuRcS7R+7ufJl6Hazm6NMbQurvPfZTuDA2YiBY7IQzFdc4W
	 qq9pmVhFKfo+RRKqjLhUwR84Na3fvQs7m3xKuE50BY17OO8c5QrbmwR1xvS35t9UsI
	 fDUZEqzfeoQVkhzKyP3COK/ifsdZqjik5CMUbs2XnYq9vLQlkzbwIgeamRWekZuwMj
	 7gtyWv6tVvEaw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 17/19] nvme-target: do not check authentication status for admin commands twice
Date: Wed,  8 May 2024 12:23:03 +0200
Message-Id: <20240508102305.108949-18-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508102305.108949-1-hare@kernel.org>
References: <20240508102305.108949-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_032353_265886_58526070 
X-CRM114-Status: GOOD (  11.39  )
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
 drivers/nvme/target/admin-cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f5b7054a4a05..936194de4a52 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1005,8 +1005,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 	if (nvme_is_fabrics(cmd))
 		return nvmet_parse_fabrics_admin_cmd(req);
-	if (unlikely(!nvmet_check_auth_status(req)))
-		return NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
+
 	if (nvmet_is_disc_subsys(nvmet_req_subsys(req)))
 		return nvmet_parse_discovery_cmd(req);
 
-- 
2.35.3


