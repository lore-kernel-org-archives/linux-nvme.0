Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF72EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jul 2023 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4tKQ7n4PPQ0pHVlMYrxnbhxqeHpKpn3WB38GUnwxXx4=; b=eok5qtKZ0IURb2ykUVg0e8l/Qh
	ECB79tqMhUZQEniS5VAxrDPxarI9j3wRlPQfhDL+kQ/mjsDz3dL3hgLeX04nbnSaOsQSlgPN3JOTV
	S/hJc5IP9siLF6Ou7LvrvtY1wsaAcbf1j4PnFsxKjSd7KTe35ldiN2XJm9zqC22SwpQrh3a3vwbfm
	hwgvEtkqtAN6Lmsy5V5kk8rs/GKc5x1vHdwZLqyEmZB2eUG4g7fGJtkBNC4jryxJVf3hS959H89ZR
	jESYKvt2ZBlRxl5lbGpfni8SqxgaKvU4ZyX66XaD88Mq+Meo3PQMX1rUqT3gpygeTx/d3Y0y7JnPf
	R1yMlEOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHTPF-002Mpl-0B;
	Thu, 06 Jul 2023 18:08:41 +0000
Received: from us-smtp-delivery-162.mimecast.com ([170.10.133.162])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHTPC-002Moe-0K
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jul 2023 18:08:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1688666916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4tKQ7n4PPQ0pHVlMYrxnbhxqeHpKpn3WB38GUnwxXx4=;
	b=lY/HhkXZhoAbd3Tm+yj9ai9Q5oIuuF2nFIwnIo1XoD5LEZscjpIy/ZLBIBxrcaJPJFsS6Z
	CdJeHgwvNczBECWHX8WbXnxDwurbIGmethu9TCE88szdkyUnO64DkaHzDQMqQpVLiqD+Lm
	uevg6vEtHCH5N7dWEhGbyay56hJ+NKw=
Received: from g1t6213.austin.hp.com (g1t6213.austin.hp.com [15.73.96.121])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-drDjnOWVNyKBnno0OWCBag-1; Thu, 06 Jul 2023 14:06:58 -0400
X-MC-Unique: drDjnOWVNyKBnno0OWCBag-1
Received: from g1t6215.austin.hpicorp.net (g1t6215.austin.hpicorp.net [15.67.1.191])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g1t6213.austin.hp.com (Postfix) with ESMTPS id 5CE3E8C;
	Thu,  6 Jul 2023 18:06:56 +0000 (UTC)
Received: from jam-buntu.lan (unknown [15.74.50.248])
	by g1t6215.austin.hpicorp.net (Postfix) with ESMTP id 4FF55C;
	Thu,  6 Jul 2023 18:06:55 +0000 (UTC)
From: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	eniac-xw.zhang@hp.com,
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-pci: Add suspend quirk for HP mt645 thin client
Date: Thu,  6 Jul 2023 18:06:53 +0000
Message-Id: <20230706180653.761247-1-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_110838_502318_C6B3DCB1 
X-CRM114-Status: GOOD (  13.55  )
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

The HP Elite mt645 thin client exhibits resume times of over one
minute when using the normal nvme resume path. BIOS has tried to work
around this by setting the "StorageD3Enable" ACPI property, but only
if it detected the "Linux-HPI-Hybrid-Graphics" _OSI() flag. This flag
does not exist, so the BIOS workaround can't work.

Instead, just set NVME_QUIRK_SIMPLE_SUSPEND when running on an mt645.
The DMI_PRODUCT_NAME cannot be used because this string can be changed
in the field. Match against DMI_BOARD_NAME, which should be immutable.

Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/nvme/host/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 492f319ebdf3..25b59f5ce874 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2897,6 +2897,15 @@ static unsigned long check_vendor_combination_bug(st=
ruct pci_dev *pdev)
 =09=09if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 =09=09     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
 =09=09=09return NVME_QUIRK_SIMPLE_SUSPEND;
+=09} else if (dmi_match(DMI_SYS_VENDOR, "HP") &&
+=09=09   (dmi_match(DMI_BOARD_NAME, "8B0F") ||
+=09=09    dmi_match(DMI_BOARD_NAME, "8B59"))) {
+=09=09/*
+=09=09 * Force simple suspend to work around long resume latencies
+=09=09 * (1 minute or longer).
+=09=09 */
+=09=09dev_info(&pdev->dev, "simple suspend quirk for HP mt645\n");
+=09=09return NVME_QUIRK_SIMPLE_SUSPEND;
 =09}
=20
 =09return 0;
--=20
2.39.1


