Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95B9C3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 06:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a81Ju24WBF7CIO3T1unR6UR/ARKlpSCnvwbebqfSTUY=; b=nWeGq1FrYo107S5XL9KZHjPP19
	F/LEYg81EJ15S+y9KC9KVJrQDwGDLU+W/cT6Fve9e69ERfZB9AE7lL+gGPhjJjJ93j3GQCJBiMN2h
	l+wsGPYy32na3ccxkqLSq+KlOb4TjBGfW+mE34WJkShugPrYBAn8vm4P03J4AOdVlRgOIkdg4TgNm
	1Ud1ErlfGB5eFKJZ7gh0rMn9ocPQ77wtLOrb3QZxIecH7ONZ6MYqzO9p5GfXwTL+gItPs9t1bcgLr
	+YB0joIs+XBoQSrvyso7EjHXodirZKmhxIG2V7OLyMu2DuVinqDhvF+LkipuB+Qy41QZDZomDz3vt
	EsBuE1UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPGqz-0080Qd-0c;
	Mon, 15 Jan 2024 06:53:49 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPGqw-0080L0-0N
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 06:53:48 +0000
X-UUID: b13c22455a7543f58122e02b9107bdfc-20240115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:de2d3315-cd84-4853-a1bb-18f2e590ddb8,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.1.35,REQID:de2d3315-cd84-4853-a1bb-18f2e590ddb8,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:5d391d7,CLOUDID:c1deda82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2401151448309NCJ8U9I,BulkQuantity:1,Recheck:0,SF:66|24|17|42|101|74|
	38|100|19|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: b13c22455a7543f58122e02b9107bdfc-20240115
X-User: mengfanhui@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
	with ESMTP id 2087022929; Mon, 15 Jan 2024 14:53:03 +0800
From: mengfanhui <mengfanhui@kylinos.cn>
To: kbusch@kernel.org,
	axboe@kernel.dk
Cc: mengfanhui@kylinos.cn,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH] nvme/auth: optimize code redundancy and provide code quality
Date: Mon, 15 Jan 2024 14:52:31 +0800
Message-Id: <20240115065231.12733-1-mengfanhui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240114_225346_569310_50C8D9F0 
X-CRM114-Status: UNSURE (   7.49  )
X-CRM114-Notice: Please train this message.
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

Improve code quality. Reduce code redundancy.

Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
---
 drivers/nvme/common/auth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index a23ab5c968b9..4f9d06afdc38 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -250,9 +250,7 @@ struct nvme_dhchap_key *nvme_auth_transform_key(
 	if (key->hash == 0) {
 		key_len = nvme_auth_key_struct_size(key->len);
 		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
-		if (!transformed_key)
-			return ERR_PTR(-ENOMEM);
-		return transformed_key;
+		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);
 	}
 	hmac_name = nvme_auth_hmac_name(key->hash);
 	if (!hmac_name) {

base-commit: c29901006179c4c87f9335771e50814ec5707239
-- 
2.25.1


