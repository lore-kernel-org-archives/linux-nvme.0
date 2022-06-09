Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C75C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 08:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B2dDMHfrQBIFCsGOyc6iUSyEV9nvom4+iCQjiNqjREs=; b=JBi7VQoYjBw+5UkWe1EfqVOpOF
	N0eJAZd+hv+cesmxg3xSMO2xGTyq+jddWuu/i5B0FKBVvQHS5hK2cEy2T1elDyZgDz9PD5HV/dslP
	cOTRhGIpz4H0Ez4mFYPAhlGS3E60OqIb2WgY2we0ksz184CIQ98RkCKwTpyCLM5EVD01fEkWg7ZtG
	4e2w4gNF07swbarJevwNZcqMko7j/w8fTzvRgBBGBtrKmcHoTHasVEB3nFdZ9CCGzhZfBUfao21xf
	RQsGLwE0P/sA5BbhAR36Z3eAfk9bCNP7H9EAG98/TaS31kc0YhoEm2ctv5MxR5uGRz/lCJON5d+CZ
	Hf0Dfidw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzE0E-000TFl-Mz; Thu, 09 Jun 2022 08:58:54 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzDjY-000KNW-LL
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 08:41:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A8E89B82C86;
	Thu,  9 Jun 2022 08:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62235C3411B;
	Thu,  9 Jun 2022 08:41:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aSNkRAYF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1654764094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2dDMHfrQBIFCsGOyc6iUSyEV9nvom4+iCQjiNqjREs=;
	b=aSNkRAYF0Iq1LpZDCM7juqJ+gmJryJUgZG6y9XAnk2+DePTMoHgr+sclGaRCohaFQFweOd
	YxUrpiBtMxpl7l7zM8uElKABfGbFlATl5gyUp0IzdbHXGMjZgOMKf9No6Nun9JMLXi01cf
	4/N04tfzPxdjxT+AC6OA+vlxKu5CnBI=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2561c0a4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
	Thu, 9 Jun 2022 08:41:33 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	alan.adamson@oracle.com,
	LKML <linux-kernel@vger.kernel.org>,
	Yi Zhang <yi.zhang@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	axboe@fb.com,
	Christoph Hellwig <hch@lst.de>,
	abhijeet.rao@intel.com,
	monish.kumar.r@intel.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "nvme-pci: add quirks for Samsung X5 SSDs"
Date: Thu,  9 Jun 2022 10:40:51 +0200
Message-Id: <20220609084051.4445-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
References: <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_014140_875957_D905C5D6 
X-CRM114-Status: GOOD (  12.91  )
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

This reverts commit bc360b0b1611566e1bd47384daf49af6a1c51837.

This matches the hardware identifier of the Samsung 970 EVO Plus, a very
popular internal laptop NVMe drive, which is not the Samsung X5, an
external thunderbolt drive. In particular, this causes:

1) a 2.3 second boot time delay; and
2) disabling of deep power saving states.

So just revert this until whatever funny business can be worked out
regarding Samsung's PCI IDs.

Fixes: bc360b0b1611 ("nvme-pci: add quirks for Samsung X5 SSDs")
Cc: stable@vger.kernel.org
Cc: Monish Kumar R <monish.kumar.r@intel.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/nvme/host/pci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48f4f6eb877b..47b9e3e0ea5a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3483,10 +3483,7 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
 				NVME_QUIRK_SKIP_CID_GEN },
-	{ PCI_DEVICE(0x144d, 0xa808),   /* Samsung X5 */
-		.driver_data =  NVME_QUIRK_DELAY_BEFORE_CHK_RDY|
-				NVME_QUIRK_NO_DEEPEST_PS |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
-- 
2.35.1


