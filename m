Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65298C27C4F
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jun 2024 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/gk2KiYDnJiKvVRam4gxu4GC6J79ujkLJLrRvV+aDSE=; b=OUZnXD+WkA8vcM8oU6zEIHIBDK
	nyXqMWgkV7HTWOAiA93D+iAIIz70kzQ1blVCCZAJOhQb3mw15/ydJdROCRQ6E2t7Jm32nW8FuJ49o
	Vm/6cNe7lPWJKWY5uSJEwDoc1c8L5riGtd2GssSJ1rnC1fUxZ/Umdit/sCZNA5B7jhWnRx/Kvu4i9
	YfYWi/Euvmornd5vTbf3NmP/4Eb58is+wSV/gDkIfejCroZk7e7vHyMmxRmP8+aKVdaIa1ztDEFsa
	Jsi4TAqp+G5SOShCJ1zVQY0XGl8qKa28u836k5PjeEotKgLOU7gses3ZFJCMCFFHzGd4yWreN6Kax
	ewdDNOew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLNWN-0000000E5Gc-0sY9;
	Sun, 23 Jun 2024 13:44:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLNWJ-0000000E5Ck-1kKi
	for linux-nvme@lists.infradead.org;
	Sun, 23 Jun 2024 13:44:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1A037623CA;
	Sun, 23 Jun 2024 13:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068F3C4AF0C;
	Sun, 23 Jun 2024 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150276;
	bh=TfjV0MENPXTWlCS1EqhPF4BJdBl8Pbb0PXittkmlkt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QDV2zOGhrszZyaEB2RqRzs8i2laYSurqyVfANvbZWbtwAhSPmBIGk0EWXHxDp7D/K
	 RYy/5h4FSoE9jeP+m4zT/jpjanIylISDwIXnePB+Zlt7/zCsqLm0AJFgj1fjKxi6s0
	 udmvThkdopT3IPQ/HNpzNhzKzMvrx0J9dZzDfDYckYmyZHlE6rsTxJf1pBi80rgVuE
	 h30IdsQWuX3LIS29QCBVU/A5zZWcCgpn5TO5EfUAf0KK3tbO33QMgydOpAJCWoR6CQ
	 6yA/6qBxqPVA5sriMhJj+ViGA8m/NL3qQdrJ95wtuye5ryW0625IA34eyfkMT7k9Nl
	 cXSq+HSNWuhAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 18/21] nvme: avoid double free special payload
Date: Sun, 23 Jun 2024 09:43:51 -0400
Message-ID: <20240623134405.809025-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240623_064439_572765_B37E7CBD 
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
index d513fd27589df..36f30594b671f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -998,6 +998,7 @@ void nvme_cleanup_cmd(struct request *req)
 			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(bvec_virt(&req->special_vec));
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
-- 
2.43.0


