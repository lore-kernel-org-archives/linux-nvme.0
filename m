Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5429C19F4F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=125BI8n7yrZgT6ze7t5UENBr+zN65lzBa9PyanxxgFA=; b=f1QI6+zleFn55J1NNiu7PX5wTV
	vZjdIh7N2biZA6kmaLJ5R7Ue54D7Z5N5dgCVQw9apQrEbjTpTYJniTQMi1mLzyUSt+CtNFJP9wzi/
	1bIenFdLPSdg48NXlfG1N0JCfTVlRfXg9GQ6tA1d7vAubO01I4EgcBUkE+98NhJYrkGOrL0fKzHVe
	ux1i2MKP/PYLm6/spJu+abNxBvDOOaycnRXr3X3qdH2ukzl6NWo9AHCOfY48Kzv3AL3l01V6t/aQ9
	38/adFLm2sTksrjK/uPEmhk7RGqqSct7GYmSJeW4ijYyULAT/78lHYL8VAIjbFljivQKjRrUty3IX
	nuM5Z+Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4fVy-0000000FENL-3fEg;
	Wed, 08 May 2024 11:31:14 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eSq-0000000EyHD-2e0K
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 10:23:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C68FECE184D;
	Wed,  8 May 2024 10:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65F7C3277B;
	Wed,  8 May 2024 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163834;
	bh=PEAcEDkoHEFBUG5+e9ouy7044XfRurlIJmGXalmIc6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4wXNirdC+hum62V++N6xNQs32utUgN2ZZjVvIwk7Z4Oz4sD3DkPm5jyOVRGvLWHT
	 8oRVBcR4Sb3ab+MYM5v2RR0t6H/UJNL0oH9x29tYz5i/Euqg3kVDQU1zaV9nhxAJsP
	 8CQQvElj4bQGDRtR6bmBdpplkjV10VqwFxUWJCbR1dEnD3aRQVUu4c42aZraao2TWy
	 NjYJ3DmcRDtgJ4U2M5GuS41go8VwtaHD8ygq08hmOHf4bbf7+1+07m8/b2nbppHn5p
	 g7ZKdXNAyUJgStbN6OiRZbXMAtpJY/42UhiI6SGl+3wdF9wRa8c0Vij55nT/g6jSRR
	 i/pQvIU0KyUGg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 18/19] nvme-target: do not check authentication status for I/O commands twice
Date: Wed,  8 May 2024 12:23:04 +0200
Message-Id: <20240508102305.108949-19-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508102305.108949-1-hare@kernel.org>
References: <20240508102305.108949-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_032357_345476_8EF20DF7 
X-CRM114-Status: GOOD (  10.43  )
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
 drivers/nvme/target/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8860a3eb71ec..3cdea56aedcd 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -891,9 +891,6 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (nvme_is_fabrics(cmd))
 		return nvmet_parse_fabrics_io_cmd(req);
 
-	if (unlikely(!nvmet_check_auth_status(req)))
-		return NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
-
 	ret = nvmet_check_ctrl_status(req);
 	if (unlikely(ret))
 		return ret;
-- 
2.35.3


