Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536AAC10F1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LERFqxbnG8+w0aJyhdKNLdSkM06sKS7e1JIKX9Fg58c=; b=JWidi9r5QqTHiRVZ0VuepO33Z1
	xBMG+08B7Hb1MTrMwbbNtOvHMqPjbNW8SIErSznh2svMZr1/RIgYdy4mNZGHAAxsCEemgbljN/DkE
	1/T5y57cvg4TBStv95P8qwoEsXvKTtb8nSmKmL8+sysThonGjprZvKnuHuViH7b7JuTVCha50QDZg
	mk3jKzvTkbYhFhWWmFBfOcZ16/eP5wKV821MrxXQxijLUl0b8FR3/mBxPRb8jDiayL8fTVkQpaimH
	KEHRfnZ2XOSxPB1KXI2OxAXyhg69U+XOiNNOQ95GEpMVZ6wAt0nOSuv95of3Xm5HfFYGjtiyPhEMu
	mrRTtGWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tyr-0000000DBYP-1mLE;
	Tue, 07 May 2024 23:12:17 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tyi-0000000DBSA-1pSE
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:12:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5F5E4CE1742;
	Tue,  7 May 2024 23:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED9EC4AF17;
	Tue,  7 May 2024 23:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123525;
	bh=xKGJxFne+UyiXVYKvVnAuWWupcJYyWxk89f2UMkT1LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lkpi17zbfKyeJ2xHZsVSOG49pFs+gQQqSlbCv85OrvjXrQ9uY1Q0StKAfXOL6pyvj
	 70UqcxMRamH9OTvFhxCfj6Hu0drHeRvz6Lt4Qx4XZozE9wtjT7GwWlilIDb2OCIrUl
	 fYvH9mSX8YoP+vIS1XWk3NGFKN3jF3PlQTJHdm4het1DUcQCx0tKP3eBEmtLlHCXI2
	 inmjDlTPPoKQZZNOmapR1xFA0nxLH4VAnJxAsZstlC9BUAy83po85Ys6dU87k1Ftzm
	 JBWB9p3diejr+aeOLcp60401qcikJtDULZQOSxcUWJm9IFKMh4RQH0hm9hlWx19nRX
	 TZGlZcL862LuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hare@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 39/43] nvmet-auth: replace pr_debug() with pr_err() to report an error.
Date: Tue,  7 May 2024 19:10:00 -0400
Message-ID: <20240507231033.393285-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_161208_842190_FB3C10FF 
X-CRM114-Status: UNSURE (   9.67  )
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 445f9119e70368ccc964575c2a6d3176966a9d65 ]

In nvmet_auth_host_hash(), if a mismatch is detected in the hash length
the kernel should print an error.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/auth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 1f7d492c4dc26..e900525b78665 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -284,9 +284,9 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	}
 
 	if (shash_len != crypto_shash_digestsize(shash_tfm)) {
-		pr_debug("%s: hash len mismatch (len %d digest %d)\n",
-			 __func__, shash_len,
-			 crypto_shash_digestsize(shash_tfm));
+		pr_err("%s: hash len mismatch (len %d digest %d)\n",
+			__func__, shash_len,
+			crypto_shash_digestsize(shash_tfm));
 		ret = -EINVAL;
 		goto out_free_tfm;
 	}
-- 
2.43.0


