Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEC4C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Message-ID:MIME-Version:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=16txTfPqBbERrFH5NjfxkCGSqTwnRoUiDEK6bk5/IGk=; b=X23C4ZCe3873ccNHh9f8iKL0p4
	00AR/T0LIS6U2WIs0QjC1ouPdKv/uMvr4PKsUWyB3X3TYI0hZOuSNh/vxy7+ScY7NvbVX1gL9xEvW
	SIEuZ+0j5ql5wLUf2TVffO/0TrkIqjpK1MFnmPya/K9+HvvWrQYsXMGGOJJeuf1jiKJuPphRXNQI7
	a9533ASVNM7Wbbg02lVyiyb08XFQ+HV7zZcDCytWSU4dvxuvZ4ovtwdLj1ZJE0ohloHRkeCskYpqe
	2G/lTJAKK4wKmPaFwSoHGruNKeWG+HON6Sx8wmZJkXVKRIKf9OurCPXtp14UMw61UjVnRDKGWSw/s
	tdH0k4FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3g7s-006FFn-RX; Tue, 21 Jun 2022 15:49:12 +0000
Received: from smtpout08.a1.net ([80.75.33.8] helo=smtpout00.a1.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3g7p-006FCn-6b
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 15:49:10 +0000
Received: from localhost (unknown [100.77.12.61])
	by smtpout00.a1.net (Postfix) with ESMTPSA id 4LS9t671S8zGrqyn;
	Tue, 21 Jun 2022 17:49:02 +0200 (CEST)
From: Leo Savernik <l.savernik@aon.at>
To: Keith Busch <kbusch@kernel.org>
Cc: <linux-nvme@lists.infradead.org>
Subject: [PATCH] Introduce NVMe quirk for multiple Micron MTFDKBA2T0TFH SSDs
Date: Tue, 21 Jun 2022 17:49:02 +0200
MIME-Version: 1.0
Message-ID: <86c55fb7-ef0f-4c3d-82cb-9d655f17baf9@aon.at>
In-Reply-To: <YrDs2sPzH4RPzhGI@kbusch-mbp.dhcp.thefacebook.com>
References: <af7628d5-2b91-4fea-a2bd-56825dbcb02f@aon.at>
 <YrDs2sPzH4RPzhGI@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Trojita/v0.7-468-gd9d6944a; Qt/5.15.3; xcb; Linux; Ubuntu 22.04 LTS
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_084909_430664_D56D54B1 
X-CRM114-Status: UNSURE (   7.56  )
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

Longterm kernel 5.15 recognises only first of three installed 2TB Micron=20
MTFDKBA2T0TFH SSDs.

lspci:
04:00.0 Non-Volatile memory controller: Micron Technology Inc Device 5407
05:00.0 Non-Volatile memory controller: Micron Technology Inc Device 5407
06:00.0 Non-Volatile memory controller: Micron Technology Inc Device 5407

dmesg:
Jun 09 03:33:08 kubuntu kernel: nvme 0000:04:00.0: platform quirk: setting=20=

simple suspend
Jun 09 03:33:08 kubuntu kernel: nvme nvme0: pci function 0000:04:00.0
Jun 09 03:33:08 kubuntu kernel: nvme 0000:06:00.0: platform quirk: setting=20=

simple suspend
Jun 09 03:33:08 kubuntu kernel: nvme nvme1: pci function 0000:06:00.0
Jun 09 03:33:08 kubuntu kernel: nvme 0000:05:00.0: platform quirk: setting=20=

simple suspend
Jun 09 03:33:08 kubuntu kernel: nvme nvme2: pci function 0000:05:00.0
...
Jun 09 03:33:08 kubuntu kernel: nvme nvme1: Duplicate cntlid 0 with nvme0,=20=

rejecting
Jun 09 03:33:08 kubuntu kernel: nvme nvme1: Removing after probe failure=20
status: -22
Jun 09 03:33:08 kubuntu kernel: nvme nvme2: Duplicate cntlid 0 with nvme0,=20=

rejecting
Jun 09 03:33:08 kubuntu kernel: nvme nvme2: Removing after probe failure=20
status: -22
...
Jun 09 03:33:08 kubuntu kernel: nvme nvme0: 16/0/0 default/read/poll queues
Jun 09 03:33:08 kubuntu kernel:  nvme0n1: p1 p2 p3
...

Effectively, only the first NVMe device is recognised. The NVMe driver=20
supports a quirks flag NVME_QUIRK_IGNORE_DEV_SUBNQN that when applied to=20
the kernel makes all Micron MTFDKBA2T0TFH devices accessible.

I've applied this patch to Ubuntu kernel 5.15.0-25 as well as latest=20
longterm 5.15.48 and have been using the three NVMe devices in an LVM array=20=

since without flaws. The patch also applies cleanly against mainline=20
5.19-rc1.

See https://bugzilla.kernel.org/show_bug.cgi?id=3D216147 for additional=20
details.

Lenovo seems to equip its Notebooks with Micron NVMe in quantity,=20
therefore, this patch would make multiple Micron MTFDKBA2T0TFH model=20
devices work out of the box.

Signed-off-by: Leo Savernik <l.savernik@aon.at>
---

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b925a5f4afc3..2e5c33f3b868 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3372,5 +3372,7 @@ static const struct pci_device_id nvme_id_table[] =3D {=
=20
NVME_QUIRK_128_BYTES_SQES |
 =09=09=09=09NVME_QUIRK_NO_DEEPEST_PS |
 =09=09=09=09NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+=09{ PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
+=09=09.driver_data =3D NVME_QUIRK_IGNORE_DEV_SUBNQN },
 =09{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 =09{ 0, }
 };


