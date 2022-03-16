Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A638C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n81xps7cJS1Knk/x84t2TghHdhPUfiGPD2l0OpvP3YU=; b=wNZrjH3+TWw+b/4QJirFbWmPBv
	8RyC56Za+rWL80EIVV2Fc7LVhXxlRS5chcvRIk/FbVENQqssjuBLgi78CuBRhdklUZrRq+IwFjtHg
	/2xMbXxB3zFCDCWO9KnRhZpDVdu68K51B8I6MyknXDir1Z80VRxdJOOJAmxbqvIZNJkZb0QKmUmFh
	dmpbY9i3ZmC3ZEGzkyBZ/dGcwmylFxRTVsRrcYZLcx/Bg3p0Lj3BCF0zl2YUS8Nt5pEkv80uboA0O
	l2yw5SmyObDRUl0uJVxD/WW61hY1Htb9ccnkHHPzE6xtZpnYXO8Q4rW6nFDBGXGB5GTB1FGtL4FKV
	EnTUqHXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUOSn-00C1bV-OZ; Wed, 16 Mar 2022 07:52:57 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUOSk-00C1Zs-GU
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 07:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647417174; x=1678953174;
 h=from:to:cc:subject:date:message-id;
 bh=Je2ZWX3edA1Czz6ssXci3qY6Mhod4o9JMVkDWJhNKPQ=;
 b=EZYuFuXp3F0U1xSnU38UlweeqTGOfskREDBjKSQaCGzpcrQ4yYli3Fhd
 DuwZc1UONBZk9c7ujtBr23ITLqe+eaWZrhkvXx692beIo/3CS/Tzy77pN
 lkpxPOnDtG75J5Bywv/eIOyWnA1lg/E9s68Sfm9XVcJ3kubwlZrtCGNtt
 xG0hyK3gY1YhyGLhTK+s8524vxv6Ek0hXRrGJFtwEJAV6FkJXRxvI+F2K
 oFTYcTCUwjoMKAQNylRcAkW8iqmgWN8bRur6u3+VPsfzJbVae3bc2OzEm
 EN/jSas83NEz4s7oO/qDUOtW6r4F0QWa2fUqML8nG7tx18sWsD9b9o4gi w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="317238602"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; d="scan'208";a="317238602"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 00:52:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; d="scan'208";a="690484275"
Received: from basccgtest09.gar.corp.intel.com (HELO localhost.localdomain)
 ([10.223.165.104])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 00:52:49 -0700
From: monish.kumar.r@intel.com
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: abhijeet.rao@intel.com,
	monish.kumar.r@intel.com
Subject: [PATCH] nvme-pci: Add quirk changes for Samsung X5 SSDs
Date: Wed, 16 Mar 2022 13:24:49 +0530
Message-Id: <20220316075449.18906-1-monish.kumar.r@intel.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_005254_611910_A6B251C4 
X-CRM114-Status: GOOD (  11.77  )
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

From: Monish Kumar R <monish.kumar.r@intel.com>

Add quirks to not fail the initialization and to
have quick resume latency after cold/warm reboot.

Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..c1150e01394c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3463,7 +3463,10 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
 				NVME_QUIRK_SKIP_CID_GEN },
-
+	{ PCI_DEVICE(0x144d, 0xa808),   /* Samsung X5 */
+		.driver_data =  NVME_QUIRK_DELAY_BEFORE_CHK_RDY|
+				NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
-- 
2.17.1


