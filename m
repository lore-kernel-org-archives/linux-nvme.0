Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A769BC3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Dec 2022 14:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:Subject:To:From:Date:MIME-Version:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=di7XCJixGjYdsK76Q312prhxoAFN/R5OgeqZejYiwfk=; b=C5iH5eYn2zfKbqPUxaYZPYhNhm
	0OMS0455PhsmXDlX8aANDh3umZbHB7cynIvoBpAxT364u1CIbL3pmvYO9iCIwWOeWXFC5yYodN4il
	ihSRx1nOBUNM0y2Qb+8kPvJOgsOv8pskKLuhMG/1yH3aFwjzJt8eb8+ZZ3WlLRRur9zYfR0+u/RV7
	pFydJEPUjyILZ/ZIC0UQWAG1qIg0md96/wcAUwFqDFDptiXNFq9tbAtLquR83iFbnx5efxKVO0jkF
	JkI//Gdy5JvdhhfZarnwHBWwdmERPJxj24mSEsB6L8hsjtYEiKmJ728zqQZ2juaQPsVELLfjDHJux
	W96SXuSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9oGv-004bjs-1Q; Mon, 26 Dec 2022 14:16:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9oGp-004bhv-Ih
	for linux-nvme@bombadil.infradead.org; Mon, 26 Dec 2022 14:16:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=di7XCJixGjYdsK76Q312prhxoAFN/R5OgeqZejYiwfk=; b=dMWjXFLALqW8C+VGs+/pfAvRWa
	MbLXe/iSeW4xRi4Au2mqdZzN9RiXz4hj4ZNGP+8EaFyTaUaWMYND9Mh1VTTUs4GcW9ujYMwEZlsH1
	rWZQDwdXuH06F9XTuIlJYuV9e3TAet6XqGkVq7NpBLVSOsWUMI5+JVndU1GTvsEHxnEcw/yof3BK0
	Ga9iil2u7suzV4NOmhvXcaPsbdrfVBP1EBCU7WUVvXQERLKVOF//uj9vl3+9nDRpw/wE4TJogZ791
	/jqrQ6tTt8N1mTgZ7m3IE1PgQLg5Kn/Hj1GmMb4xI0ZaGjFScf73hI2YuN/WEugdHiEfSmwQoiAHH
	S/X8U7sA==;
Received: from mx1.riseup.net ([198.252.153.129])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9oGs-006hz0-SI
	for linux-nvme@lists.infradead.org; Mon, 26 Dec 2022 14:16:11 +0000
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.riseup.net", Issuer "R3" (not verified))
	by mx1.riseup.net (Postfix) with ESMTPS id 4Ngfvc3JR6zDqpf;
	Mon, 26 Dec 2022 14:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1672064140; bh=hg4Dv/qh6/jmFMa0tnsvXEMznhhdCbJ5eOyYbMXelmI=;
	h=Date:From:To:Subject:From;
	b=fA79kUnXvZ8YsmFFqIFTgcgxWFoN5lMKNOxuncVHKSdzDQqLJHMFi0GWXNRDhZ5Q2
	 dwqg3rFOKcLWbo2jtQkuwmFjf7yFwstXRRGn9/ytnyFCWUuZehInSMFXcL/Se8aEio
	 qWomlb4Akpi6JqKAMU2L/5N8OAS5O8S9UruexefQ=
X-Riseup-User-ID: F9433DF1D40DDC5B19D7C6B6F2D25ED52E5011F014B7CCC0D024CABA2C74333D
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews1.riseup.net (Postfix) with ESMTPSA id 4Ngfvb6Jqjz5vSS;
	Mon, 26 Dec 2022 14:15:39 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 26 Dec 2022 14:15:39 +0000
From: user090909 <fuckgithub@riseup.net>
To: busch@kernel.org, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Subject: [PATCH] Add quirk for ADATA SX6000PNP
Message-ID: <ed916236ae7f2823aeccc8a85230abe5@riseup.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221226_141607_585258_58EEF131 
X-CRM114-Status: UNSURE (   8.75  )
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

From 65e5a06268a4510f2858cbd182dbc60caf7003ff Mon Sep 17 00:00:00 2001
From: user090909 <fuckgithub@riseup.net>
Date: Mon, 26 Dec 2022 17:12:54 +0300
Subject: [PATCH] Add quirk for ADATA SX6000PNP

Signed-off-by: user090909 <fuckgithub@riseup.net>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f0f8027644bb..ca48d0b229e8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3415,6 +3415,9 @@ static const struct pci_device_id nvme_id_table[]
= {
 	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
 				NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x10ec, 0x5763),   /* ADATA SX6000PNP */
+                .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
+                                NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
-- 
2.39.0


