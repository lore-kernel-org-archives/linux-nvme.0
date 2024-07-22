Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F428C49EA1
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NFcbOTta/sWGeHL3xJnS7QP4LQCPFYZhb6oJOaepyeE=; b=Zc+Dsq2ahzL63sgvepv5A9YqJq
	0GrHP79nGU+jtrGkxtZ4Rdymyq1oFE5EleQu90pOYWQUuY0gR3aUVr4ZK7ipnpyfSjn+V7trvWlqF
	X3d4DQAu9sxcMTPdBJ0LxqMVgUQZ6wJJuR6N9GLX0T5lIA6G33mISX/2/EYIcNN/CQVRTgVU9h1g8
	rW3j9qzezURCnYCq3VaIYbyFBTLzFydA808v5UjSXJwmmY4eWmfj5lwd6qJkwheZXh1Yuq+McYk4t
	tu4upnFEJ3cQSOGfQy6KdRPugTE0pOSfSffuhyBRx024NSPmxnMOP4DRyNCxAP/3V9ZVgUFjsCh7e
	wXBEgjzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkh-00000009Sic-2W0Z;
	Mon, 22 Jul 2024 12:02:51 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkb-00000009SZQ-13QW
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 12:02:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C0DF2CE0B27;
	Mon, 22 Jul 2024 12:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C700DC4AF11;
	Mon, 22 Jul 2024 12:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721649764;
	bh=ckP8spu9Y334zsY1hP3lwQ0QxDQLjumGIKD2JDX/hgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMSrBvkZme6icbQd/jY5QhsXPQjeAACU2lDJy/j7etEp2RiSPBbO208mZEsUahZq3
	 xCdTY6sbmDiUBSNgW2LBJVdvAvNHdIsTmsVuzZUFB086GfhBSeMRSty8QL5mQmd1vp
	 DR+eN5dUDHSudCYJTZMvMjGEv3lUBjee8VP9tUSZGxKzOO8il5bGC+AUi2CkmqoMsC
	 y9+xqykX9EUmGoSKRLwH1+BGkAHRxsaLyzsQ5w958xrXUlhIuCnzbnkaMjP1o2j5pD
	 DfzZaz3c7kGwO+8EA1F5X+AvIX+Nf1amAH7tSNwhQd1Oj+b62nZ9VkLoEu05raYx/O
	 Hn14c/y3ik7Og==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 8/9] nvmet-auth: allow to clear DH-HMAC-CHAP keys
Date: Mon, 22 Jul 2024 14:02:25 +0200
Message-Id: <20240722120226.88737-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722120226.88737-1-hare@kernel.org>
References: <20240722120226.88737-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_050245_498870_FC6C5094 
X-CRM114-Status: GOOD (  11.77  )
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


