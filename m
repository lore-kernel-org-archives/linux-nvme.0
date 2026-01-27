Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D389D2F038
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O8XMHVBO0pWM+9Ygiv8nPLaHQsEYHemxcLpfdIltGwI=; b=2O9Ef9UKF2cUBK0+0nuQ3fblH1
	OFeM9I0eofbxGWMLEWg40voYaTGuIx5igadkrFEH0Lb7NQEab4hFcU3wVVnPoI3tqGHTGa6cYJHcr
	97h3WKzyG7M+byWblWjvONO7YcIW0o16hvsExk8pPweqnmHxLj4bYlrP7RRIdNHZJUPv80XEQ6VeU
	e1uUBQd8foyJ0o21WI0YVY2bOouB0wv7wFbhrmTFGxHZ++3nFo2Zpi48I/fQfQHw7d0n55Muf3zWw
	eyxH3ZkEwHGYv1qEw/XAxO7idOBH88fqprozlclBDX3ZfHXhIjrguoN4ELTJrRgpZlS3SsZVCm2Gh
	cQdPzp7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkk6g-0000000EOw9-0wco;
	Tue, 27 Jan 2026 14:31:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkk6f-0000000EOvw-0uEO
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 14:31:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 574286012B;
	Tue, 27 Jan 2026 14:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC2CC116C6;
	Tue, 27 Jan 2026 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769524308;
	bh=o0cupKma8Rf34chOdAcD9rEzjyqx7Xo1bV/h+BtfQmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xv2SdWmpSTkuxQt0e/VVCBxEC0+BPKhtND0KHBQFVMOIlAHs0eQBFv7xnnj0fzqzV
	 f9J8ADhjJgw0Ym3mI385YGmBZk7u7iNoi89ULxKNX+z+d4ja/9ZkzLfUf+do3WFd+H
	 byMuCnjL2uH5aH/8aEeZMH5m2urGZovGoO1v0lVnqUfPNH5Df8rs9UrJaAdof1EhKP
	 dwzFo3/D5Wavm2agk62S8Utu0TZSDM+75gZqLKndxFuTFR/0a6lZU2FWnv9BSU4kWH
	 6pmZ2Ufy/EYT8aMX6YtZEkxN9v+9IrzLsWqu8vz1kXze+7w5CRDdbXq65P1qHERnjl
	 9fYLrbAJFdcUQ==
Date: Tue, 27 Jan 2026 16:31:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Qinyun Tan <qinyuntan@linux.alibaba.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Guixin Liu <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Message-ID: <20260127143143.GW13967@unreal>
References: <20260127073344.2489873-1-qinyuntan@linux.alibaba.com>
 <20260127084807.GA342@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127084807.GA342@lst.de>
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

On Tue, Jan 27, 2026 at 09:48:07AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 27, 2026 at 03:33:44PM +0800, Qinyun Tan wrote:
> > The NVMe PCI driver exports the sriov_configure callback via
> > pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
> > VFs through sysfs. However, when the PF driver is unbound, the driver
> > does not disable SR-IOV, leaving VFs orphaned in the system.
> 
> That sounds dangerous.

It is not. In a real SR-IOV device, VFs are created by the hardware and
are independent of their PF. There are several use cases where an
operator unbinds the PF and reuses it to improve overall device
utilization.

We have already discussed this in the context of Rust.
https://lore.kernel.org/all/20251122185701.GZ18335@unreal/

> 
> > According to Documentation/PCI/pci-iov-howto.rst, PCI drivers that
> > support SR-IOV should call pci_disable_sriov() in their remove callback
> > to properly clean up VFs before the driver is unloaded.

I could not find that claim in Documentation/PCI/pci-iov-howto.rst.  
Can you point to the specific sentence that supports it?

> 
> Bjorn and other PCI folks: is there any reason to not do this in
> the PCI code and leave a landmine for the drivers?

It will break a lot of real users.

> 
> > Fix this by disabling SR-IOV in nvme_remove(). If VFs are not assigned
> > to a guest, disable SR-IOV. If VFs are still assigned, emit a warning
> > since forcibly disabling would disrupt the guest.
> 
> Well, I think we have to distrupt it, at least for hot unplug.  This
> sounds like we need some better handling in the core code as well.

As mentioned earlier, there are valid users of this functionality relying on
legitimate devices that operate correctly regardless of whether the PF is
bound.

> 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 58f3097888a7..4f2dc13de48b 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -3666,6 +3666,15 @@ static void nvme_remove(struct pci_dev *pdev)
> >  	nvme_stop_ctrl(&dev->ctrl);
> >  	nvme_remove_namespaces(&dev->ctrl);
> >  	nvme_dev_disable(dev, true);
> > +
> > +	if (pci_num_vf(pdev)) {
> > +		if (pci_vfs_assigned(pdev))
> > +			dev_warn(&pdev->dev,
> > +				 "WARNING: Removing PF while VFs are assigned - VFs will not be deallocated!\n");
> > +		else
> > +			pci_disable_sriov(pdev);
> > +	}
> > +
> >  	nvme_free_host_mem(dev);
> >  	nvme_dev_remove_admin(dev);
> >  	nvme_dbbuf_dma_free(dev);
> > -- 
> > 2.43.5
> ---end quoted text---
> 

