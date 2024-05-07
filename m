Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DABC19F4F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2LMWMgTaW2iOG7S1sSjtZp8tn6NcKTnxiKAcPmv0zPw=; b=L3A9RKkDhTDgJ1eMzqGqviFuv0
	8DhHNG3wt+665QEQwFb3WYD1gJTPFgtV5l0hUa8l1mfVLn/92pRg7DC3QbRJnLT4JEC6M8x0vrN3s
	W62UiYcKPWZ/rpvJOMTIhiQCo83P/SlUVovTDQDdNaBzVLUn2yEJjacv7gk+alDbS9fRyLEWpvPjd
	J4R4uPJYOVoso9gG6soke5yzzxvr/TsTzkve0JLGOGU4c1iBl94qrFkcDy3uINdVhrO2bNeVyPFuS
	i376+tBFU/dfCG13XsWH5zOSAwwdBbkppiBry4Gjdukq8Y4M4Bbbk6SWTa26ow7dKBHxT3UMtePon
	RqfOHWtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Twi-0000000DAFT-2oLT;
	Tue, 07 May 2024 23:10:04 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Twc-0000000DA8f-29Xq
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:10:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 89C23CE1742;
	Tue,  7 May 2024 23:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46B7C3277B;
	Tue,  7 May 2024 23:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123395;
	bh=PY5p4BR22hkl5nUDZo2IeOWjxL4AERGHJeNQcYeqpjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrvla/Wz6K2mCFIwrABTRGZjj02l9OoERYyMeiyq/bwy9KyPqnqNg5vmD7/SqsWNY
	 V+8JElASEIkXTEjvwtGCLZ9RpbmVRbrhU6RK7TTHMzG+K8MmYpgFIrEhwrNK9IU3C7
	 4zGiCTT3V/QvqZge6LVzt5Iv6bIt4HncQTthemMiqNOWGR8x8vaDnun+J3A2XKE9aE
	 McZlTRVxOz4yCXX5YXbGRmODqSFpzELau/78YHcfkXI/wJvCJBwvSl8t2t6tfIt0fn
	 EF8TdMnxYsuocYqqtiAwyBDP/YQbf32ASE0U54HhTAX3TwRyLpnMrQ/o2Fle6X7TPn
	 BaS6D4yRVHQag==
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
Subject: [PATCH AUTOSEL 6.8 47/52] nvmet-auth: replace pr_debug() with pr_err() to report an error.
Date: Tue,  7 May 2024 19:07:13 -0400
Message-ID: <20240507230800.392128-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_160958_869482_D22F336B 
X-CRM114-Status: UNSURE (   9.46  )
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
index 9e51c064b0728..fb518b00f71f6 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -285,9 +285,9 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
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


