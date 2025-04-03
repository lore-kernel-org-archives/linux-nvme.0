Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DAAC3601F
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 07:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j0n1Yn3xof12J7AxPVd/N/p9DVfFFk4LYiLYsi1jpSA=; b=RhXDCOKdQKVt9MfYYXT3egSATS
	BbrKlXIVnL6PIsW3D/cyZ3TqJMOV3z27vtQyMaiPmzRbZv2RaLBTJE3eOywQcP0iehZVxKjdPcQNJ
	17/ITFEklt+zgM0W6IW8SbpcBNq+2hvyffdu8RbjgoBroZJP0JkPJe/pHHzu1k4+uzci46Mz/owHR
	qJCFtr7pPMu1u+WTmncxxRvT2P342e9qTabP69M79fn1qGq+aOicpxwSDTjbc1rsfNngHyg4aeuqE
	R1gyDy0D0G6yKjphD/VSyk8HBuvVTyL6RzrN7jklefZOpbTF7upFgbIfY9xS6C94zf6l5E6cbBq85
	zCceieXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0F0R-000000086rA-40PC;
	Thu, 03 Apr 2025 07:28:55 +0000
Received: from out203-205-221-205.mail.qq.com ([203.205.221.205])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0EuD-000000085lU-1j2z
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 07:22:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743664931; bh=j0n1Yn3xof12J7AxPVd/N/p9DVfFFk4LYiLYsi1jpSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rBgFL2epG/z2EvmdOrwjuQmuU4D3Q8q6NPWCqKSI+5PvLFizenWT3GdLBQ5IHDVjo
	 lrOIIHxv8j7l31IobYoJfAIsg4MlibFkku2zdmrNCeSkcIRG50vhqWur9M7UccNyum
	 cnnTd8VblyfWU6hcz7kn1bLgO5AgR1SbsLw6ZvjY=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 58993ED0; Thu, 03 Apr 2025 15:22:09 +0800
X-QQ-mid: xmsmtpt1743664929twng37n1l
Message-ID: <tencent_CB48668425E7D4B6BF13E377B7447B8C5205@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Ju7Zkxg19jQiwymA8b/D1+rGpbVhMXwqQJIzhunSWITcF7isi/kn
	 pQw21NUCkn119uoUrI5VVK2QxAabcVMoRi/tTIxt1llpDQOtvnq79kqfbayeiT9hb0S+a0zMVyo/
	 m3CT1pZ+4Ipznr6b+QkND4FxvlpDnzfMTnIVbZyDoTBmBeUzWylaE9ZazguOO4lDSmMZd2SPHgvf
	 F+yrh+b0wQxsSMq8giDAaTuqjUihxerNX6A59JA9ic5a274eTkG5ovUkbVkXqhhAVJ2w+n3DlMrC
	 4FXwiQKsYhDlm5oZUK51qtwEteFV6TAJILL0ZJGI/WaTmPfL9Eco15Fd3GF2FrH689n2c12t6SXf
	 ue0dbuO5BXXZ+OMvljyd01kG2QDYf/HLncRqMu+ZbpMU+7UJje3n3LsVLgefapa2DPvNjZW4wzVt
	 nwe09ztePNWiM68g6+6zmuTawCBvalN0orm87R29O3lUcbDKWIMKtrgwUFr6o5K/WdJKJujZr8Yp
	 14P5ZDyB04R6q0bnkNMTQ+XS1Rd4bFYA0YQoEcE/X67vNN6xaeHMDt23Vl8Zw1eTAfGqCc9smLug
	 PNIwbED4e4ubUpa6Gb2R7DjIvPn15y57v9CWVJ1FVknc1WgVKmYGeMlVpCNeTdpB8aY7/Lw3krzR
	 aoF0pNO/MAo1GKbCfc062BRFqOomOR/Iczh3yWmf01sJfXMoip1vwLRkZDKAchnrU8Po9nNgvUi5
	 cAUn3MmabtljVGUZ7EN+ZCK716UmGCt4r516/WInkkpexh/O1zjhZ1p1GFeskfCN5pkr81pxI+eO
	 Aln6slBSSSMUw5oTjyFrt7OqUB4KlCAR55jK2tTl5t4SiMIpK79zcg6M7N7YSxZ2JbC0nEPGP2js
	 TfsKaanD6B9KgQCIoPPc9hfgxIMjOLG8vrv8xCPkaSe06kMeZqgrxX/0Ly9iTPScYQfhGyRGPKmZ
	 QIr7lO5LSLYIxcO/+fo+l3IBRit8ZnuHdqcoyWz3KqMiRhkML2hjqVkw+4Ql3SxqMDEiXYpsgqEp
	 m7FwihmoAUEg7ZoLmWqOexwMQPlpk=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v4 1/3] nvme: Add warning for PST table memory allocation failure in nvme_configure_apst
Date: Thu,  3 Apr 2025 15:22:07 +0800
X-OQ-MSGID: <20250403072207.1208116-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_A9D89C90E6484E0EBFED4F67D6EF4589F506@qq.com>
References: <tencent_A9D89C90E6484E0EBFED4F67D6EF4589F506@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_002229_739657_E13878F2 
X-CRM114-Status: GOOD (  13.32  )
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

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

Currently the function fails silently on PST table memory allocation failure.
Add warning messages to improve error visibility.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2d89fac86c5..eca0d0d2c2b4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2678,8 +2678,11 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 	}
 
 	table = kzalloc(sizeof(*table), GFP_KERNEL);
-	if (!table)
+	if (!table) {
+		dev_warn(ctrl->device,
+				 "Failed to allocate pst table; not using APST\n");
 		return 0;
+	}
 
 	if (!ctrl->apst_enabled || ctrl->ps_max_latency_us == 0) {
 		/* Turn off APST. */
-- 
2.25.1


