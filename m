Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F188C05027
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 16:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q520MzvMm0CftsYlyDeiimr5N0YSPDmfGjwD6PeAF08=; b=GcUcchSiCAUTzn3n2RKObEa8vH
	kjZIPQvtPMaAKS8SvbqjFRWrD8ad62tXs2Aenvjp/7IFlwspXObsP+gLpfCh8wzyUfNmJLlmOoZWZ
	xYM5zPR+e0yA5QNYSkFnV4J4qmSpuGATK2OYBuXLGxiKf4grnpiye7ailO6NssDoZqmMR4/tJhjrB
	/RKCw/veKkjI8ZstGgN9T5hgKMpTykUjTd4tmLVjo3zjnWpkXydP1nBhX0/T8qhuNV8/SO5qqIb48
	o/A99z98T0CHhqDcSPSeidGoTKe6G+csq0lgonPH044qmUnUZTxwNs24/fDkN9A1qUWM8+1yzclxn
	VGg5Oivg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPn5n-00GDlW-OS; Wed, 08 Feb 2023 16:14:43 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPn5k-00GDkM-Uu
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 16:14:42 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 9B06B1F8A6;
	Wed,  8 Feb 2023 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675872876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Q520MzvMm0CftsYlyDeiimr5N0YSPDmfGjwD6PeAF08=;
	b=nsU8DsTefccC1yZN6d6pP0SAOKu2RKqULnYtuqcDeypwAml4Yair/zDPMAIde3uVmP8/cp
	dqOmPgzC4Fl4rtpZfgLlekY4UGs9aEWyRoBDXja6sSnuRUzbMJttbltBWmORfkNFDFjXiF
	FFrVmM0LB6V0aptkMyI654iVQnjjF/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675872876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Q520MzvMm0CftsYlyDeiimr5N0YSPDmfGjwD6PeAF08=;
	b=o1HVeNiP/gmwL/b6nvCyeMKhFPN6QdD5Ju9N6av6lceRC1eU6vUlf2Fwj/2w7dHUuQfkni
	OaXisfeDK3KhAvBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 8EC3F2C141;
	Wed,  8 Feb 2023 16:14:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
	id 83A9251BD0AB; Wed,  8 Feb 2023 17:14:36 +0100 (CET)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Gustavo Freitas <freitasmgustavo@gmail.com>
Subject: [PATCH] nvme-pci: add bogus NS ID for ADATA SX6000PNP
Date: Wed,  8 Feb 2023 17:14:35 +0100
Message-Id: <20230208161435.112692-1-dwagner@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_081441_158118_70926159 
X-CRM114-Status: GOOD (  10.39  )
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

Yet another device which needs a quirk:

 nvme nvme1: globally duplicate IDs for nsid 1
 nvme nvme1: VID:DID 10ec:5763 model:ADATA SX6000PNP firmware:V9002s94

Link: http://bugzilla.opensuse.org/show_bug.cgi?id=1207827
Reported-by: Gustavo Freitas <freitasmgustavo@gmail.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c734934c407c..d0ef4b549640 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3423,6 +3423,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
 				NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x10ec, 0x5763),  /* ADATA SX6000PNP */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
-- 
2.35.3


