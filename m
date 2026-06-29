Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3A4C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 13:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jNG1SV93bpOjYs3JkRONn7qwnOLVRgqL5IgSTl/R6IE=; b=0+KG0F7tkMY8RzWRgOjw/ZFfNp
	02yWJzd5kQ48JeD83pqaazNL3PUVW17XfZMJWUj2I3fcyglu82Sdg0XZvVzqc194f12Wxv702Rell
	vPiOuADkv/i1vw6cTbqSQ0MT1eNCb2Cnc0ijIiQQTf7Y/eMeC+fDHrnZUm+F6kVH1Us98Qa5gs4B0
	tRMoMx7MsD7tcmUac6z+UIHdU0jf829o9SQZlbBsJKbpAnYS+wnL/28EtC/uoSESfWCRgrYV2b+vu
	8pgqC/bQb6yqdK/vyvRg8Fi0wvZVqziSD2fv2Wh7uz6IvETIgxui4bFZTXZU6tScCzrLcVcZmyoSG
	FTJZeIxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBcs-0000000EeSZ-43Eb;
	Mon, 29 Jun 2026 13:02:14 +0000
Received: from smtp.missinglinkelectronics.com ([162.55.135.183])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBcq-0000000EeP6-1FpF
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 13:02:13 +0000
Received: from ubuntu-server (ppp-88-217-66-27.dynamic.mnet-online.de [88.217.66.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: david)
	by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id 56EC12025B;
	Mon, 29 Jun 2026 15:02:03 +0200 (CEST)
Date: Mon, 29 Jun 2026 15:02:01 +0200
From: David Epping <david.epping@missinglinkelectronics.com>
To: =?utf-8?B?6aG+5rO95YW1?= <guzebing@bytedance.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>,
	Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: Re: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Message-ID: <akJsyeCNp9QOD3Mp@ubuntu-server>
References: <ajlDjpjK_clMrnwx@ubuntu-server>
 <4b210910448ef2227190f426e97614787d15d32b.5465e366.d014.4145.8c6e.48ae0643e67e@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b210910448ef2227190f426e97614787d15d32b.5465e366.d014.4145.8c6e.48ae0643e67e@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_060212_494365_64DCF9E9 
X-CRM114-Status: GOOD (  25.77  )
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

On Mon, Jun 29, 2026 at 05:05:51PM +0800, 顾泽兵 wrote:
> > The system setup where this patch has been used is as follows:
> > - P2P PCIe capable CPU (currently also IOMMU disabled)
> > - patched Linux in-Kernel NVMe driver for local PCIe NVMe SSDs
> > - FPGA accelerator implementing NVMe IO queue memory and IO queue handling,
> >   exposed via PCIe BAR
> > - vfio-pcie Kernel driver plus vfio userspace FPGA driver / application
> > - The userspace application creates new NVMe IO queues at the SSD using the
> >   patched admin ioctl and points them towards the FPGA BAR. It then informs
> >   the FPGA about the SSD BAR address and IO queue ID. From then on the FPGA
> >   can access the SSD storage entirely without software interaction.
> 
> Hi David,
> 
> I would like to ask for your insight on one point about the FPGA
> queue-offload setup described in the RFC. This is not about the PRP1
> ioctl change itself; I am personally interested in FPGA/NVMe datapath
> offload and would like to better understand how your setup handled this.
> 
> For the I/O queues handled by the FPGA, how does the FPGA learn that the
> SSD has posted new CQEs?
> 
> Did your implementation disable interrupts for those CQs and let the
> FPGA poll the CQ phase tag, or did you use MSI/MSI-X with the
> corresponding NVMe MSI-X vector targeting an FPGA BAR event register
> instead of the host interrupt controller?
> 
> I also wonder how the I/O work was submitted to the FPGA in this model.
> Does the CPU still provide the FPGA with per-I/O information such as the
> data buffer address and the NVMe namespace/LBA range, while the FPGA
> then builds and submits the NVMe commands? Or is the FPGA able to derive
> most of that by itself after the initial queue setup?
> 
> Thanks,
> Guzebing
> 

Hi Guzebing,

the I/O queues managed by the FPGA are implemented as FPGA internal SRAM,
and thus the FPGA sees and performs every single queue memory access.
As you assumed, interrupts are disabled for these queues, and software
would call this polling, but for the FPGA it is instantaneous knowledge
about the access.

After initial I/O queue setup the FPGA operates completely autonomous as
far as NVMe is concerened.
There is additional Linux userspace software controlling the operation
and telling the FPGA which linear range of LBAs it is allowed to access,
but that is not a NVMe driver/protocol level knowledge or enforcement.
As such, Linux simultaneous access to the same LBAs is technically
possible, but does not make sense because of caching.

We use the FPGA to record data from external sources (FPGA attached
network interfaces, high-speed ADCs, ...) to a set of NVMe SSDs in RAID
configuration. Linux never gets to see this data (or even knows this is
happening). Only after the recording Linux may open and use the RAID
block device (we use mdraid structures). This mutually exclusive access
scheduling is managed by userspace software.

Best regards, David

