Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE058C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Content-Transfer-Encoding
	:Content-Type:From:Date:In-Reply-To:References:Mime-Version:Subject:Cc:
	Message-Id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bx4yk85YzTITcDGdvOKkJN17ivUTPYJLuBEy9X1mGE=; b=aT0PkwRoK8wgU5INIkiSGeEu0O
	HoVZ7mFlAqfnDZwxZ0/1LbgECJLFCdcvfYmdVZo3oePXWqtY7Mgbo9rzAHwgjqX/xxkL2cHCLBK7Z
	IUOucooyYqKLVorAywG0pxK1JBcPYXymCwROpi0ZXJhn7fp/F/2hacuyGY46k1foAEx666W8zYD4Y
	K9ePRDduKnEGNy77EaChamiOZ37I+RbsWTZjRqGNsrmKX8lPop+RWR9HGC8QcB8Zhpn/moUCWvJve
	nZ5e2kxRaZwcTlEsXm8+zLOVC9ehTwzbZ/jhhTzyOY6h0IugvCDUE4i5hGbLstS6vzlSFESfHiqSw
	gTePNYkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we7wP-0000000E6EE-2Phl;
	Mon, 29 Jun 2026 09:06:09 +0000
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we7wL-0000000E6Dp-1BSt
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 09:06:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782723956; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6bx4yk85YzTITcDGdvOKkJN17ivUTPYJLuBEy9X1mGE=;
 b=LwjtUbNU6tdUi6HLc7dnHn5FxGt8EVi+4wgTKBBjQ8GAvV1w69ljXOWirMyawrmfozSo3o
 F9w/cthQLBmyRH2JYF4bNG7KRhEMvumspuBHVaIhg5f4He/usimwgqonq8fD+t4Pu9taIY
 OZjkBKH9TOZfnUZsJIge8e0a8O5aVu7y4MHCILdKpeksVydOYE95NJOHwJ6DrPg2A8BsNg
 026ICUEY+BAYkQ0DnXaui5eZ8oyKARJTHGnogY7dOo+g5XIIehitF6r2LhnhZzGawj3Xd/
 5tjZU4oJDIzuiYJJc52y2E9j06SVutoJHejmxy0+ZkaEf9xYc7xg49QWcDauVw==
Message-Id: <4b210910448ef2227190f426e97614787d15d32b.5465e366.d014.4145.8c6e.48ae0643e67e@bytedance.com>
Cc: <linux-nvme@lists.infradead.org>, "Keith Busch" <kbusch@kernel.org>, 
	"Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, 
	"Sagi Grimberg" <sagi@grimberg.me>, "Leon Romanovsky" <leon@kernel.org>, 
	"Joachim Foerster" <joachim.foerster@missinglinkelectronics.com>
Subject: Re: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Mime-Version: 1.0
References: <ajlDjpjK_clMrnwx@ubuntu-server>
In-Reply-To: <ajlDjpjK_clMrnwx@ubuntu-server>
Date: Mon, 29 Jun 2026 17:05:51 +0800
From: =?utf-8?q?=E9=A1=BE=E6=B3=BD=E5=85=B5?= <guzebing@bytedance.com>
X-Lms-Return-Path: <lba+16a423572+d46161+lists.infradead.org+guzebing@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "David Epping" <david.epping@missinglinkelectronics.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_020605_560741_86FF72B1 
X-CRM114-Status: GOOD (  11.98  )
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

> The system setup where this patch has been used is as follows:
> - P2P PCIe capable CPU (currently also IOMMU disabled)
> - patched Linux in-Kernel NVMe driver for local PCIe NVMe SSDs
> - FPGA accelerator implementing NVMe IO queue memory and IO queue handlin=
g,
> =C2=A0 exposed via PCIe BAR
> - vfio-pcie Kernel driver plus vfio userspace FPGA driver / application
> - The userspace application creates new NVMe IO queues at the SSD using t=
he
> =C2=A0 patched admin ioctl and points them towards the FPGA BAR. It then =
informs
> =C2=A0 the FPGA about the SSD BAR address and IO queue ID. From then on t=
he FPGA
> =C2=A0 can access the SSD storage entirely without software interaction.

Hi David,

I would like to ask for your insight on one point about the FPGA
queue-offload setup described in the RFC. This is not about the PRP1
ioctl change itself; I am personally interested in FPGA/NVMe datapath
offload and would like to better understand how your setup handled this.

For the I/O queues handled by the FPGA, how does the FPGA learn that the
SSD has posted new CQEs?

Did your implementation disable interrupts for those CQs and let the
FPGA poll the CQ phase tag, or did you use MSI/MSI-X with the
corresponding NVMe MSI-X vector targeting an FPGA BAR event register
instead of the host interrupt controller?

I also wonder how the I/O work was submitted to the FPGA in this model.
Does the CPU still provide the FPGA with per-I/O information such as the
data buffer address and the NVMe namespace/LBA range, while the FPGA
then builds and submits the NVMe commands? Or is the FPGA able to derive
most of that by itself after the initial queue setup?

Thanks,
Guzebing

