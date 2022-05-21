Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5F8C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 21 May 2022 11:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GGHSZfZEq1wjo88eIeTRCXEpazTetVjhbU0rJFiKV7s=; b=PG7lQ4sT06/p3Q/bvEWt0co9r4
	kQ96yV8TwpzXSyttoxBW1mJoS1WuTXhwUe+M4ILocMT9SChZM+O8AqFK/XvMugtjDP1EW/yo2REYe
	m8xQb7xgcUUt6ZmmqCGDW2ZknUSDAkiWtFjNdp9tA4mdoFwpKH93CaaxGJbl9eqVFDP6uGe+Im1oU
	r8HbI3MuhM7x91E2/boyWJvsxfuXVSY5pr09nC50okGl2MuDlBMuqeV9RFcEbCVNHSL3BAFdma3SS
	5n2t5KhRoNEB5FEGKuMseTcG083vMOsER5KhbOwxJhObKJAGtsRnSyoBFRclyJpU09BaEamKRBQjU
	opPCu/Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nsN3K-00GGUN-Ge; Sat, 21 May 2022 11:13:46 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nsN1h-00GFFg-UJ
 for linux-nvme@lists.infradead.org; Sat, 21 May 2022 11:12:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GGHSZfZEq1wjo88eIeTRCXEpazTetVjhbU0rJFiKV7s=;
 b=N9WCEOVg6dcvdw3ZO1MuaH6r7vB1vDECXOWSRHdpRSCnCTMrVTOl8sp+
 e+e5vs2R6yrDg9uF9OjW62tyzRw4VLwBaxz6t0WPLmV+YkwkPKbmXckLt
 TT6T1Y/vqMai/EEw+gbzmd344UwOzUa2jAWMzjpEC3MSVGnDujXlhDgCV I=;
Authentication-Results: mail3-relais-sop.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; d="scan'208";a="14727921"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:56 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Christoph Hellwig <hch@lst.de>
Cc: kernel-janitors@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: fix typo in comment
Date: Sat, 21 May 2022 13:10:36 +0200
Message-Id: <20220521111145.81697-26-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220521_041206_303674_EEC3D62D 
X-CRM114-Status: GOOD (  12.23  )
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

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/nvme/target/passthru.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 5247c24538eb..2cebb0da38d5 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -97,7 +97,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 		id->sgls |= cpu_to_le32(1 << 20);
 
 	/*
-	 * When passsthru controller is setup using nvme-loop transport it will
+	 * When passthru controller is setup using nvme-loop transport it will
 	 * export the passthru ctrl subsysnqn (PCIe NVMe ctrl) and will fail in
 	 * the nvme/host/core.c in the nvme_init_subsystem()->nvme_active_ctrl()
 	 * code path with duplicate ctr subsynqn. In order to prevent that we


