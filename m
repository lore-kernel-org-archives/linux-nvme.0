Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E45FC47DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Mar 2024 17:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+PAAKwchkC1uCmVipF2aLndw/3XTvU/+/tSsTMy5WE0=; b=LObIztkOOqvholUpDfoXVyCAl/
	wD6iW1oGcwXnrtrMucR6NoAwYeZDtcFtc3X3Y2e/3RSsgjU1+/7VSUn3GAtLalNqUMHgDpeyDv18B
	DVfbiw3qr5dIs4umXD49MXJO92L7WLK5sKIkxDuBoUM7TJY5nTNep3CXclrW6lJvI1SRa567Ij7f9
	j2r7KNGLwi5lt6o9U6TlI3Vf8o/v1YQiDzgrJKQ0rpKXR2Z0oiJSLJfvh12YXW2j82VnYD82PgpTa
	zbTokepTO30E2r2V5q/+LusxBqJ0vnex5tBHyo/+/04gI+LaBb7LLUl7b+9xS7RohpGSddBX6mFX8
	5kEDCtBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roRJd-0000000D1uf-4Bkc;
	Sun, 24 Mar 2024 17:07:26 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roRJa-0000000D1s5-3mSc
	for linux-nvme@lists.infradead.org;
	Sun, 24 Mar 2024 17:07:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 40530CE0B4C;
	Sun, 24 Mar 2024 17:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118CDC433F1;
	Sun, 24 Mar 2024 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300040;
	bh=XN56H29/t+TQV91EAOIpRPn/BfVIQUAtf2rRHgpwWT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ok39JWwpKUH9+M4m3hhq8A5yJPl9acW8HWtpVXSo5IPl2eIzJwkIgG1Gi10d/UnOa
	 tEETHayTpDn0hVWhWWucJbQaWwmFmGZqG7Tr/OYQA9xz00qEDG/LnXWwLoBt4jUnXv
	 LMeiuoyKPQc/4c6o46Bu7WnYt+li2eUfqtmEu7apRbDqq9feAQI+tRsUIb6QaoGH81
	 ONDXZHSILPydzlrPXM1JfMeqPCAMvludoKaKcjfrEZ3GnRTQx98ECSInqp4bH9WeZT
	 UpCFGBEfieYH7iLr6hZacGctZveLUWjTANj/Kf65Y7V/CgsfXnA7obzxF9MtTi9syP
	 cYmBsSjmkoGDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 7/7] nvme: clear caller pointer on identify failure
Date: Sun, 24 Mar 2024 13:07:07 -0400
Message-ID: <20240324170709.546465-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170709.546465-1-sashal@kernel.org>
References: <20240324170709.546465-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.82
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_100723_243929_E5E84F47 
X-CRM114-Status: GOOD (  12.61  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 7e80eb792bd7377a20f204943ac31c77d859be89 ]

The memory allocated for the identification is freed on failure. Set
it to NULL so the caller doesn't have a pointer to that freed address.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0c088db944706..20c79cc67ce54 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1363,8 +1363,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id = NULL;
+	}
 	return error;
 }
 
@@ -1493,6 +1495,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id = NULL;
 	}
 	return error;
 }
-- 
2.43.0


