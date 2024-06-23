Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5E2C27C4F
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jun 2024 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fi6j97s9fkn49jBvn0mAa7T/Gt+jPgGsaA1IkMPo/L8=; b=S7SmVoUdeqogZePwmuQArCDfR/
	b4/1eeNcBEkoo9Q6xdJ3G7Nhi0VyNw+wsu+tnIMKuiFVIc0V9+g7SqqGJIK/MYT4OEiuByapAbJ7m
	FsJ5BsNkzaD4EF7T7ZdhaQVJXprgStGJbPlGBNrfz19YcfNpNzlzcb5+zMpH5O/bv9dNrrz0KtTUW
	/hweywwlrBk2yAZaGc92487ux9G7ChJWBhbWUDDnpAc2kWAKPcgxEdv9NIoOpust1ebKa1U+/lFCP
	plhC8EvCGfKK3xmTDkdaak8igJ6tVM/OYLjdMhc78KqM3SoOVU0anB7PkafZLqydOCokeb+tSr6ro
	pma0UHdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLNXL-0000000E5qs-2uh5;
	Sun, 23 Jun 2024 13:45:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLNXE-0000000E5lr-358d
	for linux-nvme@lists.infradead.org;
	Sun, 23 Jun 2024 13:45:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 948A2623C6;
	Sun, 23 Jun 2024 13:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8257CC4AF0E;
	Sun, 23 Jun 2024 13:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150335;
	bh=2Z3XvizxzJMSuoKNyBEDeSZ+eIoOmFz6jrU/KbpNV4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rd9Qk15laXk8eMGGFjIzlyHGnF1RaYvL+qGNKoMKMwB9E2xej3fWod35pcULeH1+R
	 qq4jpbiO9uQL7oHPtEF4y8ozn2pZEl8J1CmGn2UviTzbKF30AKJex+u2qK2lH8EuJy
	 5fj+xDbNtdLVRhpXI5Nc3EiHLruk3XZEapk9qVNWi5C1bK+BygaTdrMolU6K8H5+Vj
	 pj+1xaC05139rWb7SxISR8aoDSJagcjZryjxSJsUXYvpz/U/ch7nvUrL2BNNhnAtNU
	 7i8tFaHHaeMfURZBZ65s5x0F82XbZZ5vfGWXZ0S7KdnYVLlTkScitwSqJsziWJxdqk
	 D2AabxOYtJ7pQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/12] nvme: avoid double free special payload
Date: Sun, 23 Jun 2024 09:45:14 -0400
Message-ID: <20240623134518.809802-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134518.809802-1-sashal@kernel.org>
References: <20240623134518.809802-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.95
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240623_064537_090071_A66E6D7B 
X-CRM114-Status: UNSURE (   8.50  )
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

From: Chunguang Xu <chunguang.xu@shopee.com>

[ Upstream commit e5d574ab37f5f2e7937405613d9b1a724811e5ad ]

If a discard request needs to be retried, and that retry may fail before
a new special payload is added, a double free will result. Clear the
RQF_SPECIAL_LOAD when the request is cleaned.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 75b4dd8a55b03..1aff793a1d77e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -954,6 +954,7 @@ void nvme_cleanup_cmd(struct request *req)
 			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(bvec_virt(&req->special_vec));
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
-- 
2.43.0


