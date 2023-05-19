Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE99C7EE26
	for <linux-nvme@archiver.kernel.org>; Fri, 19 May 2023 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zcltsJEizWayt7k1n4HEtYog5a3WBFJDpp0XV19+794=; b=kZu2E8fpqn4DMGnlOpm6foz0p0
	oShoOibsNjXZnE0CRI1nP/iiRSBC/LPeY+k8fMCdsjdMp5GpK6cy11AJ+jGFzkOI3Yz+fz6CuzAjI
	uNBRprv8kvC+9WwPQSkyPvIYKSN7WBshSJhyjh0tUIxVitxSOxzWO0VTUX7el55uA0cmwgsaw7X/v
	IWGOJHAX4kzDEv6MCMTkBSPHJemwVZXeBAkj347XfZqb7EOMFreTbPj4vJ99iwlsv06bl7xQtESZr
	goV/jOe2cWPfC2Kvek3F/6o/SvuF2yLID/E0Qvwg1DQURYTfUwhOcZLkcDd7ffITa6uV92Qbn/0E2
	GNQI1/jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q04MU-00Gvkp-1t;
	Fri, 19 May 2023 17:57:54 +0000
Received: from tempest.nemui.org ([106.185.149.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q04MS-00Gvjn-1Y
	for linux-nvme@lists.infradead.org;
	Fri, 19 May 2023 17:57:53 +0000
Received: by tempest.nemui.org (Postfix, from userid 1000)
	id CF8E22084270; Sat, 20 May 2023 02:57:48 +0900 (JST)
From: Tatsuki Sugiura <sugi@nemui.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	sugi@nemui.org
Subject: [PATCH] NVMe: Add MAXIO 1602 to bogus nid list.
Date: Sat, 20 May 2023 02:56:03 +0900
Message-Id: <20230519175603.169196-1-sugi@nemui.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_105752_634002_7288FC3A 
X-CRM114-Status: GOOD (  11.17  )
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

HIKSEMI FUTURE M.2 SSD uses the same dummy nguid and eui64.
I confirmed it with my two devices.

This patch marks the controller as NVME_QUIRK_BOGUS_NID.

---------------------------------------------------------
sugi@tempest:~% sudo nvme id-ctrl /dev/nvme0
NVME Identify Controller:
vid       : 0x1e4b
ssvid     : 0x1e4b
sn        : 30096022612
mn        : HS-SSD-FUTURE 2048G
fr        : SN10542
rab       : 0
ieee      : 000000
cmic      : 0
mdts      : 7
cntlid    : 0
ver       : 0x10400
rtd3r     : 0x7a120
rtd3e     : 0x1e8480
oaes      : 0x200
ctratt    : 0x2
rrls      : 0
cntrltype : 1
fguid     : 00000000-0000-0000-0000-000000000000
<snip...>
---------------------------------------------------------

---------------------------------------------------------
sugi@tempest:~% sudo nvme id-ns /dev/nvme0n1
NVME Identify Namespace 1:
<snip...>
nguid   : 00000000000000000000000000000000
eui64   : 0000000000000002
lbaf  0 : ms:0   lbads:9  rp:0 (in use)
---------------------------------------------------------

Signed-off-by: Tatsuki Sugiura <sugi@nemui.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7f25c0fe3a0b..dae0f8ed0af9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3422,6 +3422,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4B, 0x1602),   /* MAXIO MAP1602 like HIKSEMI FUTURE NVMe SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
-- 
2.40.1


