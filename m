Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2E4C3DA5D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NFcbOTta/sWGeHL3xJnS7QP4LQCPFYZhb6oJOaepyeE=; b=fDyyPVoTU7ZBlGQibbhbb2WQxw
	FwUEWm/xCsGt6Ihl+eOPrC6Y8I2zMf90IzC6uOMrPI6a+/gDyg8huWM8+/9NxMfxvDOuo+MSoXhm5
	D1/CpMV/BJkGN35UAINm6uJUZMYnWU4/7QF9pSzLD6NkMUvQGFj54plSumCbIVN8LptGd50VAYRJa
	icLmwN/vCM/5uwgZS/d4+e4xlSpYoqM+ucx7qiniWScCmIYorWK7+hOQQEi5D8eSfn9jZa73/Zl6s
	5T9zULaNqpMowwbALxUgPPeMQQKDcUjxdlqilTtJzYgBswCBM5JTA0/ENSwmbpuYuv0tTwvHsE4Yw
	pu2LhHFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj9L-000000026Po-2Bf3;
	Fri, 19 Jul 2024 08:39:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj9F-000000026J7-0Nvy
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 08:39:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4AF8E61C4B;
	Fri, 19 Jul 2024 08:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C48C4AF0D;
	Fri, 19 Jul 2024 08:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378368;
	bh=ckP8spu9Y334zsY1hP3lwQ0QxDQLjumGIKD2JDX/hgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/R8KZ/5/e2FbRux1xw+1ivTSt2bmLXM0Z/5QaEnv+Tku9GazcOc5S7ALAqjAHtAh
	 jP6/XKJaVQ6Fd5on88AhmqE5tJKB46hxTaX93M+fVdIBLSfVrDNU1+8aAN6sUe211r
	 NDcgkK4Co7+zmmVENoc5LUjN5K3sErkHpeS3kNGmJzqRBmlutpEg9ZQx8xetQ8+5qW
	 0WN4d+lv5Ye4u9eC3Sl5ZdM1Dyf1ln9V+RAjVakuQKHarJzW2fpExFFZ/IDmwHkXeL
	 glTMnc4ufyFAoYxx4Bn3UFiDfQ3VWh4kXf2EPsghOoTMX4PoL7H0Ok8WUhsBT/xR/E
	 D0V1x+Vdgldfw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 8/9] nvmet-auth: allow to clear DH-HMAC-CHAP keys
Date: Fri, 19 Jul 2024 10:39:00 +0200
Message-Id: <20240719083901.35399-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240719083901.35399-1-hare@kernel.org>
References: <20240719083901.35399-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_013929_306711_85B14228 
X-CRM114-Status: GOOD (  11.81  )
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

As we can set DH-HMAC-CHAP keys, we should also be
able to unset them.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/auth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 8bc3f431c77f..7897d02c681d 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -25,6 +25,18 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	unsigned char key_hash;
 	char *dhchap_secret;
 
+	if (!strlen(secret)) {
+		if (set_ctrl) {
+			kfree(host->dhchap_ctrl_secret);
+			host->dhchap_ctrl_secret = NULL;
+			host->dhchap_ctrl_key_hash = 0;
+		} else {
+			kfree(host->dhchap_secret);
+			host->dhchap_secret = NULL;
+			host->dhchap_key_hash = 0;
+		}
+		return 0;
+	}
 	if (sscanf(secret, "DHHC-1:%hhd:%*s", &key_hash) != 1)
 		return -EINVAL;
 	if (key_hash > 3) {
-- 
2.35.3


