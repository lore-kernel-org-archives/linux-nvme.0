Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E54C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 20:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UL6kPCyrRdCzzTULAfUn0BEZqFmtYxPBa5sgONIA3So=; b=ImpVotxXfTml4JTWNC5QJpa4Tj
	qNJLuqTE+EplYq7CL8S74v/4HYAExll7sxuLyZMPwIkGlggD+E9YCFDqi+2htt36PyZoF032iGCoZ
	1m9wS2sQ6Uk0O2FtvJ9jObvCQ8n7cmrrKwn92iRMm55o5ge6YKUWFYsyl/s4UL6ui+Y7pXY2/LG8D
	ThtzFExnriXMkJrePxafcS9d/J1RePT0ha6SteV/JqK+FB1ZKktD8okx/LJhsgbrbOqw/yO83U/uT
	U4qBurfikmiyGDUjtRDxwe/ZLs6W9ZCyjEf5JoM37exk2PId4s9qA63oDATZoAP7H1oIYkdsItt9e
	Xo07Xf7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFili-002jG0-Eo; Thu, 03 Feb 2022 20:31:50 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFilb-002jBs-Dn
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 20:31:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 100A3B835A2;
 Thu,  3 Feb 2022 20:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40C2C340F3;
 Thu,  3 Feb 2022 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643920301;
 bh=E/9jBRbIyyEtc+13I+rJm5xa1JZLQM7ZW8OBG5cbk8w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XlYMsQFquu/XpCa93XXMAa8BJNGOcWhHcGusvAMmPorNEzTZLu12/U5Pg3eLtcWVu
 A3vKTTG+j+5a03xfexgD1vO6zrlun+IMRoAbEX0cpaK5bU76Xkt5LJdjVSzg+NIh9s
 K3HsTaxE/V6FloREdgz35WrOFqih8UxL5y48QwCEzgs4I1EsmUFRArls2h7LjIN0L5
 YuZRPY8VnAlcR2Wum3WgZh0B3/tk4S8cCZMJf8dgPMThyeZMda+QEjRPEoqim5K7+r
 JBZImMZi9SVMZ/o2GOonH4+qXDKOkQjeOlbeOs5lPS7BYMQT7D+7wtvCkfl4MlVxxr
 MppV3FQKFZ+BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wu Zheng <wu.zheng@intel.com>, Ye Jinhe <jinhe.ye@intel.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.16 43/52] nvme-pci: add the IGNORE_DEV_SUBNQN quirk
 for Intel P4500/P4600 SSDs
Date: Thu,  3 Feb 2022 15:29:37 -0500
Message-Id: <20220203202947.2304-43-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203202947.2304-1-sashal@kernel.org>
References: <20220203202947.2304-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_123143_643771_F7756DEB 
X-CRM114-Status: GOOD (  14.08  )
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

From: Wu Zheng <wu.zheng@intel.com>

[ Upstream commit 25e58af4be412d59e056da65cc1cefbd89185bd2 ]

The Intel P4500/P4600 SSDs do not report a subsystem NQN despite claiming
compliance to a standards version where reporting one is required.

Add the IGNORE_DEV_SUBNQN quirk to not fail the initialization of a
second such SSDs in a system.

Signed-off-by: Zheng Wu <wu.zheng@intel.com>
Signed-off-by: Ye Jinhe <jinhe.ye@intel.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ca2ee806d74b6..953ea3d5d4bfb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3326,7 +3326,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
-				NVME_QUIRK_DEALLOCATE_ZEROES, },
+				NVME_QUIRK_DEALLOCATE_ZEROES |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
-- 
2.34.1


