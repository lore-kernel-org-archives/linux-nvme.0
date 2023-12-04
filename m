Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20448C10DC1
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 20:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mN//hSVNtp5XgXvPWEQi3+mH6ctBj+Vlj5DqPrOkyvU=; b=GZreLbsvDDseIUEUMU0ToT+/SJ
	iF1EBX0sNNIYZTr3jCZW91PNluesK+G6Ngs6nNvf9F63l/Xtbwr/BFaRceiBHtr3T4XhO/D6w2rfU
	rgmCF88Zn381yE73m3ytygwgNR1JC56VsQjKOXUwrl/WhAu+WrAJywAuYy44AH+CnFvgzPa7NjbYn
	OLTRHl6r2+fy5YEnr3QTN+ONIE6Ez67w+n0L4mK/+BAULodniII0Vk5ue8UTAPkIRPVDZLWgzBwWH
	fhfkQGjyGExjJcDuylWAxNKZ2oB8HjmCLAmdGzQIl+gpkqrpzqnREpr30GyrxpLBjqb5AEZwntJX1
	4gHk/NPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAFfV-005ZUi-2Z;
	Mon, 04 Dec 2023 20:35:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAFfQ-005ZRO-02
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 20:35:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8114761344;
	Mon,  4 Dec 2023 20:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B31C43397;
	Mon,  4 Dec 2023 20:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722147;
	bh=Vg2WRlecHzYl6Wy/s/Zl7StswlBpuuA/P7jhlpQlIQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWp698Y9Iyn/iV/Wqo4mheli1mqSaWTPjsdstMgGcd8ky/e5uWULnPJPRrdq8lNNx
	 fpqrTfwxKMHf1vGrykMERe5aksOfMsvlE6CWBYGH22MJzo29F6nixd2FGCjvxwvqJU
	 TlPADF04BrV0cvPqCClAeIfomzQd5VkId2YwuT+XzqOLAr66LzEmmOU9HqJ8Puf08S
	 Hrtw/lRAoEL3yOZZJrwixE/y9625Eyg+0eNYnHmHyAwktz8Hrj02Wk9Vv6Ev5xsZEv
	 8WzZts6kkIdyr4AiuaFk9VzAoah1H1stfxk5RAIA6RpJgLGl9RNCCVn0F+uwgzcQcX
	 TiUZ2oWiHmICA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 12/17] nvme-core: fix a memory leak in nvme_ns_info_from_identify()
Date: Mon,  4 Dec 2023 15:34:57 -0500
Message-ID: <20231204203514.2093855-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203514.2093855-1-sashal@kernel.org>
References: <20231204203514.2093855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.65
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_123548_382765_43B6396C 
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
index 25ddfabc58f73..0590c0b81fca9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1511,7 +1511,8 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 	if (id->ncap == 0) {
 		/* namespace not allocated or attached */
 		info->is_removed = true;
-		return -ENODEV;
+		ret = -ENODEV;
+		goto error;
 	}
 
 	info->anagrpid = id->anagrpid;
@@ -1529,8 +1530,10 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
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


