Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B462C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Dec 2021 14:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WfEjXk5erGf6Gnhh3FDxBhPGwWhWhESRpuwhFK9hv1Y=; b=dAZzZdNecLzMBBxJqzWTrWnC2P
	Q3INXpo9CeT+08/Skwcw2RaJZezKcBtQyz8+LZyA5X0J8Dn8XllQbdwHXyZ07vfrFTrgWEkZSlOTm
	PYzc+M9vVmV+U0+tlqC8ZQoQYcwaRvBxY9HNVheX7Tt3711Ofor0h+9xXJrkQTvOgc9CPOfIoiyxk
	ps6A6QVMukwRDR96rG0JsmQZyl1kFvmG9ZZYz3TFfrnurbbHxfmUsQ6qCq+IaESuCMA/SFISNouVV
	ZMNT2H2COeSZ6d/hJ6q+urC6vqpnSEu3FRm/vjaHH1aJzA5eF1P8qGES5K7lx4C/gnkR/ZUhlHqSF
	I+LeB+bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mx8RG-00EGuo-D6; Tue, 14 Dec 2021 14:05:54 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mx8Qk-00EGfV-Iu
 for linux-nvme@lists.infradead.org; Tue, 14 Dec 2021 14:05:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639490722; x=1671026722;
 h=from:to:cc:subject:date:message-id;
 bh=eVlrWFO0jt/L8OpJy57KE03BnE/wNTzew5CZR3Vv0Sw=;
 b=YADcxlpY0K0TKa69hWQWbroVLvUqgN027NUGb/JNLxVqTIw9vazW07HA
 m+8TXt0ECxcZlFbyvWIXDbH++yN61XrGmVD1OziYxuxeGv0IVvsW/08Xj
 mjvOcYqxx5Z1hly/dNvwCnZ1nknb/ISLDutRUlcMWL2tqXKozu/jj+9Vd
 ZVdo/keLNU9zWth3lBNFTQM9+7mJOoWcXV5pqqX08TZ5HGkmOh24LN6zA
 j0YAG9a2xEXhc1uaFFWtXRsW6ufiebEK9t8wBWb52OkRun73M5jCD93vs
 Nguk6OXOPwDmGYWy7ploynQyZ4iSsqDrCgeU8xLaP9uEYHBcHq0rY72fh g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="299761028"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; d="scan'208";a="299761028"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2021 06:05:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; d="scan'208";a="505368581"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.238.158.84])
 by orsmga007.jf.intel.com with ESMTP; 14 Dec 2021 06:05:19 -0800
From: Zheng Wu <wu.zheng@intel.com>
To: linux-nvme@lists.infradead.org
Cc: Wu Zheng <wu.zheng@intel.com>,
	Ye Jinhe <jinhe.ye@intel.com>
Subject: [PATCH] nvme: fix possible initialization failure for P4500/P4600 SSDs
Date: Mon, 21 Jun 2021 19:07:01 -0400
Message-Id: <1624316821-21154-1-git-send-email-wu.zheng@intel.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211214_060522_754009_AB89607F 
X-CRM114-Status: GOOD (  12.31  )
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

Subnqn isn't supported in P4500/P4600 SSDs.
It's a fixed unavailable value in each P4500/P4600 SSD.

Multiple SSDs need to return the different subnqn when SSDs are initialization.
To P4500/P4600 SSDs, in nvme_init_subnqn, id->subnqn is not null and
it's from P4500/P4600. However, multiple P4500/P4600 SSDs return the same subnqn.
It causes the possible initialization failure.

To fix this, the flag of NVME_QUIRK_IGNORE_DEV_SUBNQN need to be added to
driver_data of P4500/P4600 for nvme_id_table.

Signed-off-by: Zheng Wu <wu.zheng@intel.com>
Signed-off-by: Ye Jinhe <jinhe.ye@intel.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ca2ee80..953ea3d 100644
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
2.7.4


