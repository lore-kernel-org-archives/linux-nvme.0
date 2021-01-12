Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406D6C4321A
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 12:59:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BC42311B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 12:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BC42311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R48/rCoESE21dk8dIqk6pka+Ebma4BZUphWP09WC810=; b=H8iSc7gtmFW0K0DS+2g67GBs8
	X0uDY0vcNRyIsBvjGD9N+R0MyCeawilnCbZLzAR5Tc8EjupjM37I6gZ/LJ60g4pRaPw0Ety5asXEl
	hXAbNavSZ5toIm7aOMZuOToO75uZtCHNRzjsaVn6HGznsPzYLq1f9ty0pAcrgcRNK2uJqQIJIGhQe
	hKg8jcwP/zYIy2br+Kp3iMfc8RhxDSA0GktEd1h/OTIPlEt/LHEh+ZQMtOyeC61LS8Az2GWCjYqOs
	XGqVm5ZvrbH0K+CxP6cqHBqMRoC/L3/8cNbbC39sZ66dEvpoc94tPm0J/cavU18aI9uDHMLk2SnlW
	ZDluEeO3A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzJG4-0001W4-H6; Tue, 12 Jan 2021 12:58:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzJEb-0000gz-2f
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 12:57:18 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD2E32311C;
 Tue, 12 Jan 2021 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610456235;
 bh=a045boHEnaS0K8/hRvOKz6pzgjbFjoxJBC37/auV5OQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=luQvROK2RZx93TiyjPw1Bpq6DG70W0BkEJhnguqxlLOrLYZQfdx3HwzWU1Xm3KL7v
 oR9aZNzE17QP93ZDyDCT8mbyw662FRzbpuweqek/1YPiD8Uq6gS2CzL49Fhtt/Tal/
 E6klJYT6sUYuiI8lzTOXdnKVdCxDBz47PWpvshtakOzXJO698Wk2g+565zO0ifWJnq
 MdoML2S9xZQ5Bk/wKaNVgsAhgi0APSGB8NeAQiZMb5S7VjxhYchNAEKZuc+clOs+pd
 vqJIZ8wBPOmg4hq6ir9bO2H/E0sYDE/E2HK8dlBT/cxYBUUVj8qwcOHsmBcsqoUFfS
 46onBxrJvHuZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 22/28] nvme-pci: mark Samsung PM1725a as
 IGNORE_DEV_SUBNQN
Date: Tue, 12 Jan 2021 07:56:38 -0500
Message-Id: <20210112125645.70739-22-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210112125645.70739-1-sashal@kernel.org>
References: <20210112125645.70739-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_075717_288069_2DDC22F5 
X-CRM114-Status: GOOD (  13.66  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Gopal Tiwari <gtiwari@redhat.com>, Sasha Levin <sashal@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Gopal Tiwari <gtiwari@redhat.com>

[ Upstream commit 7ee5c78ca3895d44e918c38332921983ed678be0 ]

A system with more than one of these SSDs will only have one usable.
Hence the kernel fails to detect nvme devices due to duplicate cntlids.

[    6.274554] nvme nvme1: Duplicate cntlid 33 with nvme0, rejecting
[    6.274566] nvme nvme1: Removing after probe failure status: -22

Adding the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk to resolves the issue.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9b1fc8633cfe1..ef93bd3ed339c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3145,7 +3145,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x144d, 0xa821),   /* Samsung PM1725 */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
-		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
+		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1d1d, 0x1f1f),	/* LighNVM qemu device */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
