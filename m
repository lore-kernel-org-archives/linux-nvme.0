Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27735C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:
	From:To:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FFeyRL+A8k/kp2c0l8I8Lzgv++i+8C1WtEjrVZnZLcA=; b=QelXDnYvXTTGZG
	TMyBRKZyIDG8yWaXdgNTnNPSVhg5eajNp2tH9Megh7oGcYUsc+c1W9NUR6VQTcrTwtjKDQ6/OK8+C
	xY94m+I19PPk4GuBIbO71bPXKvcx+57AWcixUEFiAIMdomY/rTzQmVD++C/s1qguAtNY7uQiWL16Y
	mw7xqOVbc0SjdGPIX+E8G0zFiClLfe41YJwDITDdekx1BrIpZZB5mL6q5vU+1er7Gtiuvsh2rBWuM
	DCR2+LMyJ/q6/n7QURyYT5kqY1znOhqp5zhh3LAJasNgUuJdyYCQdIz10jOutZ4xSe2tlh8lYx/cR
	Y4CUb/uexVbY3DPYLNuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyCRU-001Hyd-7c; Mon, 06 Jun 2022 13:06:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyCRS-001Hxy-Dm
	for linux-nvme@bombadil.infradead.org; Mon, 06 Jun 2022 13:06:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:Subject:Reply-To:Cc:From:To:Date:Sender:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=FFeyRL+A8k/kp2c0l8I8Lzgv++i+8C1WtEjrVZnZLcA=; b=kyio7U7o0NNh/l344K/wkQGCJe
	Ym+4lrCXtPvbSQYnopIJGvNOD/s+iW7+q9vO+YkLQy496Hw93Xq8dVUvxRgS8xpQrEguOaOX5pLor
	M6fGsR8/bVF5Zfj/rtkTp5dmGci4yI8N4b8q/lc5HrWOqu2T692se1S7l4+hTxSy6jCbB5VtQui04
	ftxUTJpk2uugkev2wyLawLOqPE6QmC1WiH30lC69JtLkbW8KSOv9IPsT7BvakQoIt+Vn6KHCuljB+
	8Whesu8pkdwLeHFKHtj/LALPMk0g0WRSTI8kTn5sHf/beLZAiBEO4TvdLmFoAx+PyzxpvWBj+LP/u
	nceFr8Eg==;
Received: from mail-4022.proton.ch ([185.70.40.22])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyCRK-005SbE-S3
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 13:06:43 +0000
Date: Mon, 06 Jun 2022 13:01:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pimaker.at;
	s=protonmail2; t=1654520495; x=1654779695;
	bh=FFeyRL+A8k/kp2c0l8I8Lzgv++i+8C1WtEjrVZnZLcA=;
	h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
	b=OjCzt61hvWR9na3uKwCabokxo3iKePkkNUqtG2y/U6bgyRRn2kfNNB8C7MvcXJuDP
	 d/rkF5Pa4EPqTT49pHjNXJ10prdbJ+dn+yz0OU44TV7Huah5tPx3JsaBpggkbBMwI1
	 yQluoViLIwVFd6EGgrFf9xiZaWKHFSZG1vPwnFx9sZwxnB9VAarH7sfytY5qcP3acg
	 CDjgr+DNmdotUKzNUE86j+mbAupAHN800X0Zl1szDNeBGjtksMy6h6Jw/1M9ZoiwQQ
	 4Ib7Ll241ZBetlmTmfIeWKWVibZaPrI2A2pBjJBHJr/+W6TfcPdjGPonosuQTZntCH
	 piVTDkouCADvg==
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
From: Stefan Reiter <stefan@pimaker.at>
Cc: Stefan Reiter <stefan@pimaker.at>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S50
Message-ID: <20220606130116.87146-1-stefan@pimaker.at>
Feedback-ID: 6415277:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_140641_922270_DCD5343F 
X-CRM114-Status: UNSURE (   7.48  )
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
Reply-To: Stefan Reiter <stefan@pimaker.at>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

ADATA XPG GAMMIX S50 drives report bogus eui64 values that appear to
be the same across drives in one system. Quirk them out so they are
not marked as "non globally unique" duplicates.

Signed-off-by: Stefan Reiter <stefan@pimaker.at>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48f4f6eb877b..f1578663cafb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3463,6 +3463,8 @@ static const struct pci_device_id nvme_id_table[] =3D=
 {
 =09=09.driver_data =3D NVME_QUIRK_BOGUS_NID, },
 =09{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 =09=09.driver_data =3D NVME_QUIRK_BOGUS_NID, },
+=09{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
+=09=09.driver_data =3D NVME_QUIRK_BOGUS_NID, },
 =09{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 =09=09.driver_data =3D NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 =09{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
--
2.36.1



