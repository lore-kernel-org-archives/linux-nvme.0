Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157AAC43334
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Jun 2022 12:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TNq/ADQUhhdDnVg0+75xr4EL0cHKTPjPXQtu5zb7BHo=; b=cDL2fS7ZdM1bnD9MlhTlEfPsRW
	UlBCZ0wanBZqtDx8NqRxcH7Eyx+nq9XTL1xu3sM4JW8b7puSkzPnz7lN8S8CdLyExuG5Ij+Gk1hP5
	qBHvUiUYTjPbHubttigHpAroi9j/C/cAuhj+OQVn07+Cahcj5j+8FfSlFrPO09+1IWg3ATeud5FvH
	+nNu6+UwoEprCCJCZSR44U94zUhm8nXU+W9L/4Sqa6iuREYRVBUh9IEDtSm3U1RXdFSJm2u+eevIU
	+XOVFsCBCdDnV5W0A0s/wx/2EWhrwANFMsSOwtPsaGHPd8gyOU0XC/HxPWI4IRuWJfF6dxQRzOFA8
	eukpKm+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o54cq-005wGF-Eh; Sat, 25 Jun 2022 12:10:56 +0000
Received: from mail2.sp2max.com.br ([138.185.4.9])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o54ck-005wDu-DU
	for linux-nvme@lists.infradead.org; Sat, 25 Jun 2022 12:10:52 +0000
Received: from fedora.. (unknown [190.245.244.131])
	(Authenticated sender: pablo@fliagreco.com.ar)
	by mail2.sp2max.com.br (Postfix) with ESMTPSA id 40ADF7B092A;
	Sat, 25 Jun 2022 09:10:35 -0300 (-03)
From: Pablo Greco <pgreco@centosproject.org>
To: 
Cc: Pablo Greco <pgreco@centosproject.org>,
	stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG SX6000LNP (AKA XPECTRIX S40G)
Date: Sat, 25 Jun 2022 09:10:11 -0300
Message-Id: <20220625121011.8103-1-pgreco@centosproject.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: 40ADF7B092A.A2A42
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
	escore=-2.91, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90, T_SCC_BODY_TEXT_LINE -0.01)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220625_051050_683250_21A46EBF 
X-CRM114-Status: UNSURE (   9.19  )
X-CRM114-Notice: Please train this message.
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

ADATA XPG SPECTRIX S40G drives report bogus eui64 values that appear to
be the same across drives in one system. Quirk them out so they are
not marked as "non globally unique" duplicates.

Before:
[    2.258919] nvme nvme1: pci function 0000:06:00.0
[    2.264898] nvme nvme2: pci function 0000:05:00.0
[    2.323235] nvme nvme1: failed to set APST feature (2)
[    2.326153] nvme nvme2: failed to set APST feature (2)
[    2.333935] nvme nvme1: allocated 64 MiB host memory buffer.
[    2.336492] nvme nvme2: allocated 64 MiB host memory buffer.
[    2.339611] nvme nvme1: 7/0/0 default/read/poll queues
[    2.341805] nvme nvme2: 7/0/0 default/read/poll queues
[    2.346114]  nvme1n1: p1
[    2.347197] nvme nvme2: globally duplicate IDs for nsid 1
After:
[    2.427715] nvme nvme1: pci function 0000:06:00.0
[    2.427771] nvme nvme2: pci function 0000:05:00.0
[    2.488154] nvme nvme2: failed to set APST feature (2)
[    2.489895] nvme nvme1: failed to set APST feature (2)
[    2.498773] nvme nvme2: allocated 64 MiB host memory buffer.
[    2.500587] nvme nvme1: allocated 64 MiB host memory buffer.
[    2.504113] nvme nvme2: 7/0/0 default/read/poll queues
[    2.507026] nvme nvme1: 7/0/0 default/read/poll queues
[    2.509467] nvme nvme2: Ignoring bogus Namespace Identifiers
[    2.512804] nvme nvme1: Ignoring bogus Namespace Identifiers
[    2.513698]  nvme1n1: p1

Signed-off-by: Pablo Greco <pgreco@centosproject.org>
Cc: <stable@vger.kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d7b24ee17285..c9ebe6072498 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3470,7 +3470,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
-		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
-- 
2.36.1


