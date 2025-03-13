Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16264C282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 06:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VtqMEDHW9pkS1OyeAsvm35QETELxvL/COF4d9Rr8K9U=; b=enqucyfyDviplyEypgzxUldIM/
	bRqFUJsxl1TC0IbEH20fXKgcUh/gyw9kzTuxwgvZXnJvuPAypY981VhdCz2yGJPiQ2ESPO1pTFreL
	tvwgKdBvl3m3HP8nYkoR1iHup1xOHrs0JAdZhjz6bxHWMOjmP3IN7Movvr9GWCD1Jww74ILBUevsP
	CR3Nq+UO1oqfFA4mYAhmSGniohb+szwTMbuJTqZxwKGLh0E+loGq1irYVvIgRYL+ChC4mrYOK/T5h
	EP/Q4RMruVXNuu8KqJpArsl/PQJ6GvsbaBl3OoF2uuFRpPfOsnepuVQr+SwGhzo2kzSNV3G68IJwy
	/4zFc+LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tscM9-0000000AG6M-3MxV;
	Thu, 13 Mar 2025 06:47:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tscM7-0000000AG5Z-2BPP
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 06:47:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 789CD68C4E; Thu, 13 Mar 2025 07:47:43 +0100 (CET)
Date: Thu, 13 Mar 2025 07:47:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: chaitanyak@nvidia.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	joao.m.martins@oracle.com, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, kwankhede@nvidia.com,
	alex.williamson@redhat.com, mlevitsk@redhat.com
Subject: Re: [PATCH RFC 00/11] nvmet: Add NVMe target mdev/vfio driver
Message-ID: <20250313064743.GA10198@lst.de>
References: <20250313052222.178524-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052222.178524-1-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_234747_699085_28118BFB 
X-CRM114-Status: GOOD (  28.53  )
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

On Thu, Mar 13, 2025 at 12:18:01AM -0500, Mike Christie wrote:
> 
> If we agree on a new virtual NVMe driver being ok, why mdev vs vhost?
> =====================================================================
> The problem with a vhost nvme is:
> 
> 2.1. If we do a fully vhost nvmet solution, it will require new guest
> drivers that present NVMe interfaces to userspace then perform the
> vhost spec on the backend like how vhost-scsi does.
>
> I don't want to implement a windows or even a linux nvme vhost
> driver. I don't think anyone wants the extra headache.

As in a nvme-virtio spec?  Note that I suspect you could use the
vhost infrastructure for something that isn't virtio, but it would
be a fair amount of work.

> 2.2. We can do a hybrid approach where in the guest it looks like we
> are a normal old local NVMe drive and use the guest's native NVMe driver.
> However in QEMU we would have a vhost nvme module that instead of using
> vhost virtqueues handles virtual PCI memory accesses as well as a vhost
> nvme kernel or user driver to process IO.
> 
> So not as much extra code as option 1 since we don't have to worry about
> the guest but still extra QEMU code.

And it does sound rather inefficient to me.

> Why not a new blk driver or why not vdpa blk?
> =============================================
> Applications want standardized interfaces for things like persistent
> reservations. They have to support them with SCSI and NVMe already
> and don't want to have to support a new virtio block interface.
> 
> Also the nvmet-mdev-pci driver in this patchset can perform was well
> as SPDK vhost blk so that doesn't have the perf advantage like it
> used to.

Maybe I'm too old school, but I find vdpa a complete pain in the neck
to deal with in any way..

> 1. Should the driver integrate with pci-epf (the drivers work very
> differently but could share some code)?

If we can easily share code we should in a library.  But we should
not force sharing code where it just make things more complicated.

> 2. Should it try to fit into the existing configfs interface or implement
> it's own like how pci-epf did? I did an attempt for this but it feels
> wrong.

pci-epf needs to integrate with the pci endpoint configfs interface
exposed by that subsystem.  So the way it works wasn't really a choice
but a requirement to interact with the underlying abstraction.


