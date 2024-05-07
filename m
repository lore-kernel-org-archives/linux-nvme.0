Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91359C19F4F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/6iUXpbNehVZ+sEsrdI/HDKEc1ZelrTx4nHFR+wTQBk=; b=OeS/i1y88Hm6oXCfbZBGXEXX5o
	jqJKDoJr7jjh4F7GxQ/NGV4/EAgBt+J18aY/fTEHQ1zRcy/5a7YvPaQSNUGQwn2vs8G/K/Ny8Tmx+
	1Xqk/rhfryApDlhnAHgFTpQmQcEqxFu5pFQA/CAxM3ZlgXvsIJ1io8Eik7N8WUjhCAMR7iadVJXIj
	XMLHmUbF1P6QE6eQ5HtDXYiHPCnoOS6u1mHNq926R/ZV0w9FGcN0nwKUfWeSw5Lt/9Cfm+++TAvPf
	8LPgbQiQgefpDe9GsW2eeAG6xrPq6yLE5/mc2pJYXPDRU0m6ojytE0TcRc61su7JHIFs1ByLe0afK
	GHtD+Sgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tyl-0000000DBUf-2Wbj;
	Tue, 07 May 2024 23:12:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tyf-0000000DBQs-0EBl
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:12:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7FBA761A14;
	Tue,  7 May 2024 23:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37377C4AF63;
	Tue,  7 May 2024 23:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123524;
	bh=y1rhdDOxe21+WMY9S2759/oEbYoQ9ExkWEChZFtqQuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6PdT6oQ662fuf4LrznIYHH32plfuvnu13SpQDJqtAV5wlFyVP+qnbnAdBuLngUQW
	 ntjIuuFlFE8VZcZlSVWTjAfaR1/Gn0GawA++Zi82Jw/evD2CijxpW+jMcpeCOs4Pz6
	 mcGVXim8gIqMgwxlRHvnw2hmTmI4Vpmd+h2IWDe2i+/x1owZfK1FHsfvhx9h75le5D
	 hrof7PoccwV1LS7s3q6grn3i672wDHqK+uCx9Z2UUPHUzyyGULOZU6cSFZ3KHSuglv
	 l5y9uQWKQ2AOEZr9YF0JZKQG0kU6Gf/qrrQoRuYLzR7aD1EfxVDWH3WjfLO4QCZ3xv
	 Ljebuq04lh4oQ==
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
Subject: [PATCH AUTOSEL 6.6 38/43] nvmet-auth: return the error code to the nvmet_auth_host_hash() callers
Date: Tue,  7 May 2024 19:09:59 -0400
Message-ID: <20240507231033.393285-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_161205_393409_4729A5D4 
X-CRM114-Status: GOOD (  10.94  )
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

[ Upstream commit 46b8f9f74f6d500871985e22eb19560b21f3bc81 ]

If the nvmet_auth_host_hash() function fails, the error code should
be returned to its callers.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 4dcddcf95279b..1f7d492c4dc26 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -368,7 +368,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	kfree_sensitive(host_response);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
-	return 0;
+	return ret;
 }
 
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
-- 
2.43.0


