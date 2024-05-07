Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3B9C10F1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LERFqxbnG8+w0aJyhdKNLdSkM06sKS7e1JIKX9Fg58c=; b=1MpbVmZ8fw/k05AtpnFNrdgUkg
	XD2HP950CN94uY/S8yxMHYIYMwbY9qJDyeYeISbwDAXPgidPbyZ5/VPBAoUAUVMyyaPqxFGBb9se+
	GX15K+vG/qaIJfYmdQEY3fycU5H5DmxDqr9nhgNnmDY2VibNB9p/GgUgQkHgxnfTpaG8QqLCVYyvo
	gAO2DUoDO3aj8ys7KnpxoRKffZPM3H2WMO4p3f+lWXyuCfIiInbsUJxUCmkgN+PA6XiGWHTolMAxv
	6y8vDsYCHizWCXa0VEhG6cu5pxMJMRJCYpVsDVSwadz92sKgcgD0YbEMO/BWNumcwLnSpDCktnz3H
	qL8ffPGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4U09-0000000DCT3-2kul;
	Tue, 07 May 2024 23:13:38 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tzt-0000000DCHx-3e1F
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:13:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2F352CE1754;
	Tue,  7 May 2024 23:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3843C2BBFC;
	Tue,  7 May 2024 23:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123599;
	bh=xKGJxFne+UyiXVYKvVnAuWWupcJYyWxk89f2UMkT1LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljKwahNs+XuoBF6GUQTLSjF/185ub19j7A3Jh2f0nOIh2x1988JxM0fdlm1MLdC6g
	 pLIxbg7tmw/kk5r0NPIKysRIEM0o3YPlN4cyHnCjBGb7EPXt/ys/hct5ZJyox43d19
	 RJTQG0OpV4O1XBlYli2AGcgPq1jcwIgzfJ1Lzu/RbvO4NJ5EdQ7pxxugp6jncyZ70N
	 JbAwZ4rdFzTmNSDkNivqiHG5koRSrHH2DLNtT5SzfTOKLpWY4LP95hZfu3bD5z85u+
	 bRMVd01a4G7bsz1NSe0vn5UYYvAzzOGdTNV3Nj2Oej2qsP8nsiw5oWQGw68EUiqQ9w
	 73LJj9lv1Z2gg==
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
Subject: [PATCH AUTOSEL 6.1 22/25] nvmet-auth: replace pr_debug() with pr_err() to report an error.
Date: Tue,  7 May 2024 19:12:09 -0400
Message-ID: <20240507231231.394219-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_161322_233420_026C9BE5 
X-CRM114-Status: UNSURE (   9.56  )
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


