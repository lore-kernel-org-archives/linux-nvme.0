Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E42C3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NFcbOTta/sWGeHL3xJnS7QP4LQCPFYZhb6oJOaepyeE=; b=VLylPvyWPdutIXd/YG0st5YvLc
	6XYXIorC2EIjkbH8jDpb5LX2gEDf3steoNWA5BDltIJOQNDlKm6w+oXGpDI3Hdwgs5ewfC3rq1dhe
	eED6XadA/WWZwL3/AH5mjnf1l/HXxBFu9bdUs3nKj8TgoUxKp0vklyf9VpwxSUpmf1m1T+NmCDRid
	TzKowMPn3DWNZQ3cBIUO2t7Xleibv8jxf4s1HZlwCbOr5i2XPiuwbgB3YQe0Ovt3dZ+v722qQSbam
	FMZCg4k2NQ1A6Cyb/CZpUsOlRbbW4nwGgKtsZIfqMgpFhUZegmUp3OxAmh56HPSgxbVkRQ3OpVhXO
	vBhdUckw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRr-0000000HKXJ-1ZaG;
	Thu, 18 Jul 2024 14:49:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRj-0000000HKO8-40It
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 14:49:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9CD6461B8E;
	Thu, 18 Jul 2024 14:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EDCC4AF0D;
	Thu, 18 Jul 2024 14:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721314167;
	bh=ckP8spu9Y334zsY1hP3lwQ0QxDQLjumGIKD2JDX/hgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXO66lC+lJm45nV+A4Tq1dH1K0eOM3TY19zv80TZf/AxD0kpdHO2TFMHGWt+8Ny7V
	 fRofypUQfXvG2Osad5sHLCyHfgjggb86nLRlmuzeXw4Ux4zPigfnqB3KmaQVdCshPf
	 6VfThHhP094E/YJ29PUxQwf7VlOQIYn1pAujw8mjW/c0qirHY1CyNe9JMOmewo7/PC
	 yPFukuuCW56Hh1RHHWq/1n1v/5fxtAEVqDUhSoivYxkpVFM10nwFL1uEQwgw0/JQG8
	 F5FkZzR+9tniJePn+PNbnEu/t8cbtOPjM6dKrmU89QRlgQNX9F8QoB20YIBl1Lg2kE
	 SylqLefZxrsKg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/8] nvmet-auth: allow to clear DH-HMAC-CHAP keys
Date: Thu, 18 Jul 2024 16:48:57 +0200
Message-Id: <20240718144858.19074-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240718144858.19074-1-hare@kernel.org>
References: <20240718144858.19074-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_074928_064749_4FC7E738 
X-CRM114-Status: GOOD (  11.58  )
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


