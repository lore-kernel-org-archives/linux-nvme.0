Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3971099B39
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 19:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4aoVhI0CsO46f8dbo03MmRC8t73EHNYBUbbgAr57haM=; b=3FPMuiHjuOz+AHdHGvWjmWYBUa
	GUdvAB6moku38f4TcT2vWvpkbR2zufBSoqQhUaTicEYtZKZ0PoZUqtIPu7YSJIBd0kVf1QBqq0CH7
	ASAgI8XFN3xt/HXvgNTrXaFMrx7ZPVrurRfUN+musjYjIlz28VK6IoZE5mlqi7+4G1zqcbW7mgiPv
	+iipMASUtk7dt/dvL1KoIWdIpZ5QviseElKSoX4pXTww+7/odWrLwzFrRnOIs/Gpa0jwpC18L7u5G
	JgWP0uQYwJlaXZyVPNjwozxACKDmDwdYYcVkvlwV1sfnAMpTEBmY205EV1VqzR3iBeuKDSFVzibaf
	xQXsGdQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3fWs-0000000DS7s-3mx3;
	Fri, 20 Mar 2026 19:29:06 +0000
Received: from bali.collaboradmins.com ([148.251.105.195])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3fWq-0000000DS7N-1CMC
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 19:29:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1774034940;
	bh=WjjO/AfJ5NydP1+z0seh9U3XwapW7iumh1O/dmiPh/M=;
	h=From:To:Cc:Subject:Date:From;
	b=Eo0WZutwhbj8RrQneBTjFbKE4ScC5gJXoD4726/niPp97J90/+rNhIWqT9V34tbZ4
	 SUEqklYVowmTkrQmR1WO4Q2DUyYl8W5n5aaoWV937rCqWNbKSCcGoIgMahG0a88aRP
	 oQ0GSwkG+Qa+0xCyf1iGSi0U3KzXLGiPI6S5XCg3dCIfaOXxS7OgXb9LB7G6JnEs3G
	 0Jszp0WkicMlHr46V3Z9gkNzsJItA82O3tF5F4MD9cb6JT4PLr7M3ezxUeplKyLO4v
	 r1kokNgvgXAH2XZvSmBBNIQGDjzJVsQd6JLap7oP7shMUz7RuByRJi8dSlkIS7zsNg
	 IIHUOJz8HsSTg==
Received: from localhost.localdomain (unknown [84.18.237.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbeckett)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B64B17E04DC;
	Fri, 20 Mar 2026 20:29:00 +0100 (CET)
From: Bob Beckett <bob.beckett@collabora.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: kernel@collabora.com,
	Robert Beckett <bob.beckett@collabora.com>,
	stable@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvme: respect NVME_QUIRK_DISABLE_WRITE_ZEROES when wzsl is set
Date: Fri, 20 Mar 2026 19:22:08 +0000
Message-ID: <20260320192217.365936-1-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_122904_500317_208846FF 
X-CRM114-Status: GOOD (  12.54  )
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

From: Robert Beckett <bob.beckett@collabora.com>

The NVM Command Set Identify Controller data may report a non-zero
Write Zeroes Size Limit (wzsl). When present, nvme_init_non_mdts_limits()
unconditionally overrides max_zeroes_sectors from wzsl, even if
NVME_QUIRK_DISABLE_WRITE_ZEROES previously set it to zero.

This effectively re-enables write zeroes for devices that need it
disabled, defeating the quirk. Several Kingston OM* drives rely on
this quirk to avoid firmware issues with write zeroes commands.

Check for the quirk before applying the wzsl override.

Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")
Cc: stable@vger.kernel.org
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Assisted-by: claude-opus-4-6-v1
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 766e9cc4ffca..ce25c8a4e84b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3388,7 +3388,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 
 	ctrl->dmrl = id->dmrl;
 	ctrl->dmrsl = le32_to_cpu(id->dmrsl);
-	if (id->wzsl)
+	if (id->wzsl && !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
 
 free_data:
-- 
2.48.1


