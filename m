Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3042C04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 10:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dZ41zOrqaRVrpAiq81ooe5zAJlEylerp3mpcVTeJ7Ko=; b=4BPYYP+ElqiqNsn9F+A8wF5His
	HePPrPpw+jLj/fzyGZ13VY5wUsGnBY5ZDsBRGEobePe8bzMAAX0ojyjUu2NZY3Rh4jzwvAwSL/dDz
	2rKOH4JH4bOKw9hDLhO6eKs6mgl4qoJ1xiZz31XWIAx3pn/m86K0DfX1e3u6XTug62wcVn8SuaQhk
	CFvuj4jERGQlwy4TFVMnh1zlFQPPvPMczUCJyxx4F4+T56PKUgIhz/VkRbOE1HJBiC1ArxCENW5si
	5Lpc976I0UjJmWjUpED7DOepp9CV33PCRSNWh4FTnvYBUxIIxnAYQq4Coj8tOKWH3OKMrhSXC2ciC
	6+DuQVQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eTM-0000000EyeR-2HFp;
	Wed, 08 May 2024 10:24:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eSl-0000000EyDc-2MYZ
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 10:23:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D000961B74;
	Wed,  8 May 2024 10:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F1FC4AF66;
	Wed,  8 May 2024 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163830;
	bh=8q1DM8zzF3KCepEQnOu/v6Enf8g+fEnxalTHaWtYsCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XCzbvq7R7GvFmvDCwbcvIhtWtvgfxzG60Jh1K6xTM48RsphDphI/pH1AIZQ4cLcGI
	 qQsros8l4gskvhnp96zC3gneu75t8bQLuo/LwNN92EzWhwC60PykYFYzcsq4dFiXXe
	 7cigSbG4YatUzKBHpIFSUN+DK/aC+PJVTP5ipIgxIYAqczOSmIcA7+6ejJqsen4ZST
	 UUUKK0Ked03cn4z+9jcivTLtMDZDCFED1Nbdt6nUdUpOhjsZmBpSUhm1Rl7xfvO7Z8
	 fuNFDv5h/0qo7b6dIbgA0+RkMFd3QECBdD6VLlSxubjKDeduwS9LUuls+IK4ujnS4W
	 CrS4UPUvQoPYA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 16/19] nvmet-auth: allow to clear DH-HMAC-CHAP keys
Date: Wed,  8 May 2024 12:23:02 +0200
Message-Id: <20240508102305.108949-17-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508102305.108949-1-hare@kernel.org>
References: <20240508102305.108949-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_032352_131925_2A8461C5 
X-CRM114-Status: GOOD (  11.66  )
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
index 7ef9c3490c3d..7013ab62d5c6 100644
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


