Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24BBC27C4F
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jun 2024 13:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kv640xzH6WZZODN9nE48NJif15YtQJFJyPxMUTYLhVY=; b=RxIc3YRj+iN9Z69UV5gZxeUZ4z
	AsUNVko1MgMMnwadipUMM4ibkfYDMsypcoW0fPIN9RGs0ltWrttU0gtca+QwNhPxknR8r/eo5hCBM
	jAgwC9wMIgk6Q9to1kz0oo0+sOkRwmR/W+6TcqaAG5/VzINhr4jk9IIZu019pe3qWYFh/6TO61bOn
	O7z8CBkcwWBHIRRnwJQCVCba0/cnm9CPI99gqw6iYBuxmRYZatkrhnqloapYitBtyEQUI8MxFdK8b
	p7DD+PAdxg2ac5xteY2irPPjXjZiI3kRDrpUxNoHD0b5TLNTg4NsbjY3dC8+c+vaR5F26LHTkJpvJ
	wgl9QN3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLNWv-0000000E5Z6-1jKj;
	Sun, 23 Jun 2024 13:45:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLNWs-0000000E5Wr-0ZqN
	for linux-nvme@lists.infradead.org;
	Sun, 23 Jun 2024 13:45:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 315EE618C4;
	Sun, 23 Jun 2024 13:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E58CC2BD10;
	Sun, 23 Jun 2024 13:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150313;
	bh=jfD2PNEkrS+fDZi07jI99v1JjwCHIEfQ7QfBaONYNzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JiTTRBK17kgmf/uzmPIlwtKGQTJRpVdm9K1h3hG4hI3xD0m7clabuH3julzm5WWnI
	 jVOqM+Qzq51sRnsrjVaKi4+jUEVSV1jDIYLG7p67U8J39LNnZMsbxpNgA36ZhD4zQR
	 D9i+PwjWX/Y9YaLf5gXrBOpDIE3hu59UM3RJIdNRJN6IjCb1APnH9pvdEKej1hhYyB
	 QczxNKmzoVJwnFwiF4UnV8rWEVyaw4IBhcEE9nAOUQ6F8iAoSUNymTWUFvExPTrZxu
	 HKCvKDI5b7quhPXTzZADLLfA6vr5jRmwPFEqy6xuR+XOs1wGwikmphugXoQYmveo1Q
	 5xWQzgSXbOiXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/16] nvme: avoid double free special payload
Date: Sun, 23 Jun 2024 09:44:44 -0400
Message-ID: <20240623134448.809470-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134448.809470-1-sashal@kernel.org>
References: <20240623134448.809470-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.35
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240623_064514_388000_783192B5 
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
index 94a0916f9cb78..e969da0a681b4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -938,6 +938,7 @@ void nvme_cleanup_cmd(struct request *req)
 			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(bvec_virt(&req->special_vec));
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
-- 
2.43.0


