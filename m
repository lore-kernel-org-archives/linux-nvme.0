Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0DFC6379F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 11:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MvmltEXzYo03fvOnCvM0E/4Xner192ILgRZtrHDM8NU=; b=vW/gn/dTpTNLsMI0UHLzqZQOL4
	QjyzSbc8MEBIG3kspvPLQ4988IWri/bijVZQr11OdMiNfx5GwXrXgY68ic12N2CAFy1D2P21OiOuK
	NXo+PQk3EI79JWw7XnrQc64YkpZ2RgxowjocHd7y6dU8i3INXJgf0IzLq42zg7oMc/D0DoU3WDyXp
	+B5l8Br3Brl0kGo4anOn3cJ9kq9H4qjnNos6jVu1kxmxL7n18Ie9e4ixWv49bRXggedS3qhRwVs2B
	VOJvLf4J8W4DxOOfHLO2PvwGBTBdPdTX9ZwRLxvR+7o69T1lG0Ket4vB4YK3inU8HeMvoEN228bsw
	meR/Qb1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4vO-001ESq-U8; Thu, 09 Feb 2023 11:17:11 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4v0-001EEq-Tt
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 11:16:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 24C93B820FC;
	Thu,  9 Feb 2023 11:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E049AC4339B;
	Thu,  9 Feb 2023 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675941403;
	bh=PR/EohbDIxEQmBUHz8lHyT1xIeNdyOWaRKch9tCK5AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/ES8GNTsuBhMXlj9rR9obBBdK7UO0PtZObdzytf+wTG5j82DwEjD9hamV9rAkXms
	 9zU5WVSLdNPj9GN3UmpAdKWdG0xvlf2SlxBrpxvv4KRidSzPSEOnI1AZxXP48ZIfVM
	 /7lhO2pm5BccuuCWAFmV2KxuQ3i13E7wxjKfTHDlZUCPkEl/INsYXFmb+Nnbcg2twF
	 FaW2xy+VGc9TjmOd0qXYFdvWgw+GGkGy9kOM96eHRbGkJ5c3uCqmpYkWrI9pPNVCAf
	 Uvrq57b4cOjB2HmDO7q9Xvd8A8cF88yX4XgMx+7bdEZqb2aFvmpxy7xzrbl3n0iLDU
	 aRvw9QjV/+9tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 27/38] nvme: clear the request_queue pointers on failure in nvme_alloc_admin_tag_set
Date: Thu,  9 Feb 2023 06:14:46 -0500
Message-Id: <20230209111459.1891941-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209111459.1891941-1-sashal@kernel.org>
References: <20230209111459.1891941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_031647_178552_FE622C07 
X-CRM114-Status: GOOD (  13.09  )
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

[ Upstream commit fd62678ab55cb01e11a404d302cdade222bf4022 ]

If nvme_alloc_admin_tag_set() fails, the admin_q and fabrics_q pointers
are left with an invalid, non-NULL value. Other functions may then check
the pointers and dereference them, e.g. in

  nvme_probe() -> out_disable: -> nvme_dev_remove_admin().

Fix the bug by setting admin_q and fabrics_q to NULL in case of error.

Also use the set variable to free the tag_set as ctrl->admin_tagset isn't
initialized yet.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 25ade4ce8e0a7..e189ce17deb3e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4881,7 +4881,9 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 out_cleanup_admin_q:
 	blk_mq_destroy_queue(ctrl->admin_q);
 out_free_tagset:
-	blk_mq_free_tag_set(ctrl->admin_tagset);
+	blk_mq_free_tag_set(set);
+	ctrl->admin_q = NULL;
+	ctrl->fabrics_q = NULL;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_alloc_admin_tag_set);
-- 
2.39.0


