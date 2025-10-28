Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4B6CCD1BF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 12:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bYuxwrC/tuQYpEnSAxBgwa3ur/gAf64Ctl6E9/VQiyE=; b=rozPSrAu1u9dsO4MEgTznHS821
	u86vlDpq+rDiEEecQnuTWFrQRiw///YyXptNciplNrGp4dOyYASp2jfxI27dYeYPN36lEqO9xG8Th
	SC53HmTUurgHsYlEgXItzyM+8y+60fjWRMnVXeX02gTvESx73ty9Wm/3RPhiRH2/6H5cD1qKogM40
	zTyUf1crK0JZx+GQOkLRD3Bl9xiyzc4f55ohrF9IHyAL4xAtgZsdXTU9brhAm5Bt1GRAnsPx7L2EO
	TQ47t7n4opXXzfFcQ7gMgGfSETuE+6r6nvddouTqaoQO3BgYvesqHgDlsY8C6yZ6lLBZS9sm9mH85
	NOH6C8kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDjE8-0000000FyLt-2gOj;
	Tue, 28 Oct 2025 12:55:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDjE5-0000000FyKw-1ntD
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 12:55:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 60154419D0;
	Tue, 28 Oct 2025 12:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AD3C4CEE7;
	Tue, 28 Oct 2025 12:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761656100;
	bh=PbHgABvRssCMQ5NTXVe30ouhmXUYCCRKnKq46Uusqpg=;
	h=From:Date:Subject:To:Cc:From;
	b=qCJ8k5/cngvc9UOrcRoSXlI6gjl8f9KiOOfEha51nc6ejmmwwxmmfHu3/aIgeSAf5
	 tBcawuXzbqPpxJw9DjJCpJOELRRx2UWg7JpXt+RviRiiVCMwIM3f8KEXcJFtLBi+k/
	 usp7Pk86ZVcoKIYdNxNkwHddb1sl3ufQwcKuTtwLeqkjNe9RXj66VkUnZnUyniZil9
	 OVCqqvh3LtStjR/cwHDoTPSnJAk14+2zGTndSGVCJNkmDiPrYMOugJlmDU40ImVZVL
	 TnyOwN4aWge5T5jYu629BrVMnQOCSqbHVFrrduPg8vucN0p6yKLkk1vZfCwrc5iFWa
	 J5WNDRBZo+W5g==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Oct 2025 13:54:56 +0100
Subject: [PATCH] nvme: drop bogus nid quirk for multipath devices which
 passed id test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org>
X-B4-Tracking: v=1; b=H4sIAB+9AGkC/x2MQQqAIBAAvxJ7TlDBkL4SHUxXXQINpQjEvycdZ
 2CmQcVCWGGdGhR8qFJOA8Q8gY0mBWTkBoPkUgkuNTtyuOuQzEa0JzNGOLRq8d5rGNFV0NP7D7e
 99w9lek7HYAAAAA==
X-Change-ID: 20251028-bogus-id-check-aa1dec56fff8
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: John Meneghini <jmeneghi@redhat.com>, Bryan Gurney <bgurney@redhat.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_055501_502701_ADB844AC 
X-CRM114-Status: GOOD (  14.78  )
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

From: Daniel Wagner <dwagner@suse.de>

Dell Express Flash NVMe P4610 reuse the Intel device id 0x0a54. The
Intel P4500/46000 device needs NVME_QUIRK_BOBUG_NID whereas the Dell
does not. Thus clear the quirk when the id check passes.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217981
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi,

Obviously, using the correct IDs is really hard. There are at least two devices
which share a the device id and one needs the bogus id workaround the other
doesn't.

We discussed the idea to pass through configuration from the kernel command line
at ALPSS. I am not sure, how far we got with this yet. What about something like
this here?

Thanks,
Daniel

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 734ad725e6f4..881981c2a3b2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4005,6 +4005,13 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		memset(&info->ids.uuid, 0, sizeof(info->ids.uuid));
 		memset(&info->ids.eui64, 0, sizeof(info->ids.eui64));
 		ctrl->quirks |= NVME_QUIRK_BOGUS_NID;
+	} else {
+		/*
+		 * If the device is a multipath device and the id check passes,
+		 * the NVME_QUIRK_BOGUS_NID is not needed.
+		 */
+		if (ns->ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL)
+			ctrl->quirks &= ~NVME_QUIRK_BOGUS_NID;
 	}
 
 	mutex_lock(&ctrl->subsys->lock);

---
base-commit: 77a4fe6a06e265bd94d2b3cdc87fb3cde877a05b
change-id: 20251028-bogus-id-check-aa1dec56fff8

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


