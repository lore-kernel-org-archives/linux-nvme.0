Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72A3C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 07:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gO3oUB/va1dRPgvmeJ0Tdr4UtsAZWwze/f8ygaHXlM4=; b=SIpsCVoCeO/JcMGoUthZOIPuyI
	x9qJbYaAkuw2jxJZyWDFs76Kf2efjh/Rl/x5+CgazwjTuvAerJl92AeXN5jqzPWmQ/NEYhGcU/02s
	CJQxxejy+UBDeDVmnsX11dg2Y9gWCUHviI6djlYn/C3T+EQcUN4WbJAvt7KWcdFilMPdL8G/WHW7T
	ah7N0iQDu7iXfxJUgTawdrwvijPeArQ/8c55SAXZJVPIsN4PDmrZV6nM08MwXe3zjY/2KdwmUs3O+
	uo7dKFPAjFhjm5k4KnbJyn5rE72lvOCvGprz6VTTWSNZ+cCtZ9XGjGGoY12UVSljErlVzXoXZvbqF
	a1tWQGnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvZxn-000zZK-8P; Fri, 10 Dec 2021 07:05:03 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvZwi-000z41-I7
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 07:03:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639119836; x=1670655836;
 h=from:to:cc:subject:date:message-id;
 bh=hQX+mBwuNcTtH2DNwvr9mmlZJrlPuVNrzPX1kqv+iuY=;
 b=T/fQM750xxVQTiYsL8+oAo5sT+nddFR8dfTsDK/pisdEHUtacorfJRB6
 op4x7Kf/z7K3mUTW1S/zhQkSdQTx+6cYOhuBRP10RVlg49ZmSFcpgexqH
 OUqEFGJQ6fqROD4oRunyRBqtzxqA0LSjOFwCjtZZf6YMN1HESV4PKDjGd
 5cok1YmVXZU54c9J+SWha1pV8qYTfjXDSAPbL+tkRDdkYojmabKMwkpdO
 FaN+XUAB3mJ1SSS1mMApDaiY77zG7m3ZZk/KoCRs9LLh+JJL5Yc/lVi6J
 NE/AqNXioYU5etc8xg67GceMPWFJxf8Y4A2fZcg5Y2w/NRT2juqfUi+sw Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218979131"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; d="scan'208";a="218979131"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 23:03:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; d="scan'208";a="516647903"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.238.158.84])
 by orsmga008.jf.intel.com with ESMTP; 09 Dec 2021 23:03:52 -0800
From: Zheng Wu <wu.zheng@intel.com>
To: linux-nvme@lists.infradead.org
Cc: Wu Zheng <wu.zheng@intel.com>
Subject: [PATCH] nvme: fix possible initialization failure for P4500/P4600 SSDs
Date: Thu, 17 Jun 2021 12:05:52 -0400
Message-Id: <1623945952-18861-1-git-send-email-wu.zheng@intel.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211209_230356_650784_6B18AE7F 
X-CRM114-Status: GOOD (  12.06  )
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


