Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BD8C10DC3
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 20:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y3dQK/4SI4uKBoyoixXgNBT4eBRRVpPRrR9Ivd3efDU=; b=BkKzIhOu0bqNB/Kr9T9hCIcu0X
	0FyCnM3MmdfcuL9gc+1nuaYZDcJVmDG7N/lc4CDj9LXS5AIofodUM/w0PqLHoTzKblzosFhu/pbrg
	voM5ucqQVqO6nN+HuEs/u29FOb+EFFvEZTNC64lPoADeW1+1w3OKK4+R20Empq/nKinXsxWFGo+7N
	60KJIHIAOq0JnrR/RjLlFCreuY3drXdWKbv9jGOVhtNxQ/2iPwwu5r9m/jisySYTLtrVBzWrZLb2Z
	bbGgxiaUjtDUjFGIFstO8JsHtt6zWqCqZMFsOwgOUG0n/gcypStOBdSBqhMBNqGx4EWpF61VqTGM4
	1WRY7aZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAFdr-005Yw9-1z;
	Mon, 04 Dec 2023 20:34:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAFdo-005YvF-2e
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 20:34:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2CEDC6134A;
	Mon,  4 Dec 2023 20:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD05C433B6;
	Mon,  4 Dec 2023 20:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722048;
	bh=eTg1VInLU4qMeGqYVspdg5OJ9xCuQsygjmP3eMfpLw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SikVv5/lKGTVVs0ZQoPjUxLchz13rMa+0NbQE8AuYKGceATteFqAE1XW5JFTCOF61
	 BdGdK6Rk4PxkiOBczkwRmE5F7tDqZ187i5wD4vsvrmEhrU8zT8iOamEVdqyTWfftcT
	 ZEY8L8LCgigUqTOy4wA4bjdSxwjOU3v2uKcRbPYMCaVYNgxtZd9tZk/eIiOeQkfE3C
	 sPYiSHj/7+ad4DnEegVr01mG8s8kHgtowoBUDP+3v61bQ+lIM+iQcgSReOZy1OO+C+
	 qdh6TLO5ECW+iKOjja+y9BZiC6DbH8MDfdz5kHKakuIunN59CkQOsY7RkKkmI7ecpB
	 LT5SZxmD+3WRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 20/32] nvme-core: fix a memory leak in nvme_ns_info_from_identify()
Date: Mon,  4 Dec 2023 15:32:40 -0500
Message-ID: <20231204203317.2092321-20-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_123408_912731_4FEF8DA2 
X-CRM114-Status: GOOD (  11.35  )
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

[ Upstream commit e3139cef8257fcab1725441e2fd5fd0ccb5481b1 ]

In case of error, free the nvme_id_ns structure that was allocated
by nvme_identify_ns().

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21783aa2ee8e1..b4521deb1c716 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1479,7 +1479,8 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 	if (id->ncap == 0) {
 		/* namespace not allocated or attached */
 		info->is_removed = true;
-		return -ENODEV;
+		ret = -ENODEV;
+		goto error;
 	}
 
 	info->anagrpid = id->anagrpid;
@@ -1497,8 +1498,10 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
 			memcpy(ids->nguid, id->nguid, sizeof(ids->nguid));
 	}
+
+error:
 	kfree(id);
-	return 0;
+	return ret;
 }
 
 static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
-- 
2.42.0


