Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A5EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 01:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fp7c8eulm8TmsZlHGYldkM4cBEfErD3DVhkHaHAmxyw=; b=i3Ix5z6US00knUYmSjvUZxXxzE
	N6thK1ysekiOtExPWYFZJZbzoxs4dRcEYTtLcMK/jhn+YXLDBDFyTpPEk/apB5otnDCkzBq7aE8Yc
	AWKP2d3FvUwDOqnD7imqZzY2YsX2JlSFGdtc0dmaWqVj6+/JxBce538pDztt749lKaraBlRzSBiDy
	sAzpDIVS7+2YB4lL+39xmNakwFsv3DGSPmhAU7MDD4dtifHZkBqQwXvapxn0oWFe3osWmO6hxv41a
	MaKMA0Tzf8UlPI4wEvjQMuxjusKOXGeKTDcBY01vYLv/tJLYJeDECulNj9RxNIcD1rMrNtQizfI4k
	UuqqIpmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncGuO-008biE-Ea; Thu, 07 Apr 2022 01:26:00 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncGjM-008WDY-Dx
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 01:14:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D537AB81E7F;
 Thu,  7 Apr 2022 01:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ABDC385A3;
 Thu,  7 Apr 2022 01:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649294073;
 bh=AgQK3J32JdPM0WF5hb3hT7jpj9cVjRmVVJoMbuUb9lk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nIyT+1BVRZVGTQUTpir5nNFwGgq9xiLqsnPsUQwEh1h0ZZOwotwwGVFPB3JDaxCq/
 ZlcnPKVnmMNjU5YS2pbewqBMHa7v3qR/Wzy7sZGxhdL3I3iYYPp0pYyph1lKedZav8
 YQaSA5HLTbVadbrdRBLPnpkenwIugB9664VCVj5LLMrM2XbQLk0/aErY6xqhrT5wC7
 7uFCfoAoyCrWx/cjMryDF+nuAFJyixlt+NVM8Y2/AhjH6HqZqsgMUMeqIAdzWlpNG1
 32EwdoAEwIOb/jvjVV3KMVcmMoD4iJgy04k7yO2IEqTYvTjMfDq1QwAX7lA03JT2Ts
 2FahKJokdM/XQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Monish Kumar R <monish.kumar.r@intel.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 08/25] nvme-pci: add quirks for Samsung X5 SSDs
Date: Wed,  6 Apr 2022 21:13:56 -0400
Message-Id: <20220407011413.114662-8-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407011413.114662-1-sashal@kernel.org>
References: <20220407011413.114662-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_181436_668629_6CF51874 
X-CRM114-Status: GOOD (  13.89  )
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

[ Upstream commit bc360b0b1611566e1bd47384daf49af6a1c51837 ]

Add quirks to not fail the initialization and to have quick resume
latency after cold/warm reboot.

Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 97afeb898b25..ba067c1a6cf6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3262,7 +3262,10 @@ static const struct pci_device_id nvme_id_table[] = {
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
2.35.1


