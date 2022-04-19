Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1189C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 18:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LcvLgBpKIOV6Jd9H2spDW9m+7vA3gPEDi8b60dCavqE=; b=1YC4F/shXzFe4MI9DS9Jh3F4vR
	9SJ0g6tDWJB42nBQkwYsHbX3W8EaMT8tJn5FmBixfQCYeZt7vQvEZtulQm2WjaxpUiGhNqkt9fPfa
	/M7by6TpFGnEJ5/CNXhcBRNkk0xHFd0Dx4jbKJioMZM+Mhtix+LqmflfJ7jKfauudAdKMgGibvsbr
	/z4fZv/jr4iGRu4+4D3cnyr7ZguZNwNNHPoQo7hv+gcVcXTmppGf4yu/SMsdU85WylQiET+ESIGIK
	eqkyMxMOO7YdbrSCP2Qd6xHTcVsKAuupQ7Bt3tK0UNjvmWWpU5FF97cpRZURQesK5tj5rIbPOw92I
	Kt868DhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngsQ3-005aUt-RI; Tue, 19 Apr 2022 18:17:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngsMJ-005YM3-Qf
 for linux-nvme@lists.infradead.org; Tue, 19 Apr 2022 18:13:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 366AC61341;
 Tue, 19 Apr 2022 18:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E946BC385BB;
 Tue, 19 Apr 2022 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650392030;
 bh=blG1BoqgDz4cY3SBTCFsQD2tkAE2zYDC7RKtOQpGP2s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TxJFfnx4YueM6BxDJh1c2w69rTWAzu2HoLOOfpcN3jGwQQ/xSRWfnLVMk+FREIt8U
 LbZyBI32aDjIuksH8YXVfUej6uF44tRYSIbulDs9ZeycqQzzx5AEJiXauf0cnfUQuA
 mcAUKvzckoRqfaBmrZxc2sV/3DvkNovjtquufI5EvmpILus/yd1xLuryWknKKtyDfv
 2FwbggQmfC80lP+4f2Gy+YEYlz9xGaHJsauT0BIggaqnQMNL3aOQyQQDExa+jiZcI0
 3+8AqwkyTtjFU7m47VQKEnMN5rbEexNc6FMPRXD84iSJs3x5/wZHvI7iFbvZKr+pTs
 D/XYcrIGlERLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
 =?UTF-8?q?=E9=87=91=E9=9F=AC?= <me@kingtous.cn>,
 Keith Busch <kbusch@kernel.org>, Sasha Levin <sashal@kernel.org>,
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 26/27] nvme-pci: disable namespace identifiers
 for the MAXIO MAP1002/1202
Date: Tue, 19 Apr 2022 14:12:41 -0400
Message-Id: <20220419181242.485308-26-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419181242.485308-1-sashal@kernel.org>
References: <20220419181242.485308-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_111351_967448_E17A15F7 
X-CRM114-Status: GOOD (  12.71  )
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit a98a945b80f8684121d477ae68ebc01da953da1f ]

The MAXIO MAP1002/1202 controllers reports completely bogus Namespace
identifiers that even change after suspend cycles.  Disable using
the Identifiers entirely.

Reported-by: 金韬 <me@kingtous.cn>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Tested-by: 金韬 <me@kingtous.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b925a5f4afc3..61f01f5afdc1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3352,6 +3352,10 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.35.1


