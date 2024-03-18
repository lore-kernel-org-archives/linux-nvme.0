Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83419C54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AQ7TaXcGGNyNA/ONcT/gozYiR1Zzj6eHuRPWIlA8hsM=; b=LzaSKOvXn3fCyRvquP2s47Nxpo
	66vmK8fb/q9XYP7psMzWsS9aOs1Gy7U7nJYZNi4HX+AItl5S6oQLpMhEkQmKox8864TX0JRLqkgwM
	A1jTPYHv0ENtpPqSzwIuqixyAA/2RJ4B0GRF9k3fhjRUjv0zBUGWHlQLzBkLbe3B1gpViH1UnNFVd
	FB+4GOrxLTKgr+2smFjCZr90L7DziyJGkkcRzcg1cY0C/cXPSKo7gpszwwuOUZgsSBzf8wAFiLkST
	AcNTH96lW9RoYfD5U/XFCg5tfOBfa/m5IWB1xOnJWOZIs79lUQhgW8k23Yq8Cf31d49GQ5blt9DYQ
	YSlEnMpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEXP-00000008uqG-1Tmq;
	Mon, 18 Mar 2024 15:04:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWq-00000008uTn-2vLy
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9A0FE60BC0;
	Mon, 18 Mar 2024 15:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0DCC433A6;
	Mon, 18 Mar 2024 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774235;
	bh=83JbFh96TWNj/bzR2R1BWfj3OI8svMk+7bn0VS0Qn8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HeGHj6uUv6m1lo5Uct9PFOyrvE1Kr2kGiuMVMtuoHshdlNHDvMmOb5rq9zuKfMNvp
	 CAXBZzGeFjm1dswj+TzuRtSu1c3o/6x7E9jvTYI2nu/F+b+/ha0qMjKa/Rxz7Ft26f
	 xEL5q1WHx4qHJQ4nk6TN0nuoMpmirMyTSqKdt5AshbuCtQbudbca+vIiZP5r84Rcp7
	 W1YTQSaAYH+x3yz2zS8pyy48ldelg4ey9QLAyG1cPjnDIUl6QFQAnPBdu3hfDtmix0
	 NjdephLrliEWWA05su1jUDPBXbt0Qu9xhstvmUm5JZhKnegiXo+G/eqPTT//AqAulv
	 xWIubwSIdtXhA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/17] nvmet-auth: allow to clear DH-HMAC-CHAP keys
Date: Mon, 18 Mar 2024 16:03:13 +0100
Message-Id: <20240318150316.138501-15-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080357_649851_B6196D96 
X-CRM114-Status: GOOD (  11.40  )
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/auth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 3ddbc3880cac..7327fdd46147 100644
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


