Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D28C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JDC/+uAjKsg+ptb80t/tn8uTVJNA9wUkloFgmFh1yC8=; b=FvOeAJD/BGScOvtTvvjN8WVd9C
	efWeLl9kUtye8hOhGmfac2UTa3O34BnDY0R18l3zQiMIpNjKdPPwWgBx1ckL2oDrIj5B8Q3SzCFqy
	DU5UDhqqdae8M0WAGsrkV6TmesmkdF7YWeiPl7zelcSCVOPLqqZiUyhJF0bEt5N5BX5US2FT5qUlJ
	iufRMgwvsFLl7r5UAw6AVo5Z2PNJVJ84clhEqc2yqjMljP9e/F8aN7HV/E7a73FtC9Zabn7/iyz00
	pA+Cdvp7h8tf6zXyXZjFBdmtIa5KAli/FQqhFFHjZtswHsS/8zJ48B3EsF3S/t+33Z1nQUbSFilaP
	aMD4zcuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEwBI-008Fnj-Li; Fri, 22 Jul 2022 17:11:16 +0000
Received: from zoidberg.org ([88.198.6.61] helo=heapsort.de)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEwBF-008FjU-Tx
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 17:11:15 +0000
Received: from localhost (2001-4dd7-3704-0-554-bcec-9625-52cd.ipv6dyn.netcologne.de [2001:4dd7:3704:0:554:bcec:9625:52cd])
  (AUTH: PLAIN tobias, TLS: TLSv1/SSLv3,256bits,AES256-GCM-SHA384)
  by cthulhu.zoidberg.org with ESMTPSA; Fri, 22 Jul 2022 19:05:58 +0200
  id 00000000002A10A8.62DAD8F6.00000D98
Date: Fri, 22 Jul 2022 19:05:57 +0200
From: Tobias Gruetzmacher <tobias-git@23.gs>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: Crucial P2 has bogus namespace ids
Message-ID: <20220722170557.m4kah3xm3zgumnbz@23.gs>
X-Clacks-Overhead: GNU Terry Pratchett
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_101114_133923_F0A91F90 
X-CRM114-Status: UNSURE (   8.05  )
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

This adds a quirk for the Crucial P2.

Signed-off-by: Tobias Gruetzmacher <tobias-git@23.gs>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 58c72d55769a..73d9fcba3b1c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3515,6 +3515,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.36.1


