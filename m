Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C8BEE6B66
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Feb 2026 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=96aollkETvDVXnUV9kSMqGX2W7vtD+meiG9If4gm7cA=; b=WcZIvwkTAkmHFG
	wh9bKAxQautOwaWWTg4UiIfIQBOE9M0ASiLYrO5po3cW7llZ6Fi3ERfagyGPNuXPBiPe031z2Wn4O
	kARxt9vXZU8aEWrogKMXmWvTeBiBMxVg5JK1f/KcT3goczlPU10AwhmHFT+54MoOICUCqe048CtJD
	xh2UiJe8Vh/MPKotdujbV9VG3MfkSlvUtXjBwGZqQOa2QnqQU6BQZ2ttHXXoVyXLnccF5xlIR7jxp
	Af1PUXm05BG290k+CfI5GRE/RQ2ODAcoPmJMgyfnwPpGtrpYGdAUadjHM9sL+D2M72rY+5XnN/qKc
	/BirfSvCRriT5jkwgVsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voUJS-0000000BslK-2WY4;
	Fri, 06 Feb 2026 22:28:30 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voUJR-0000000BslD-19ql
	for linux-nvme@lists.infradead.org;
	Fri, 06 Feb 2026 22:28:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5F31C600CB;
	Fri,  6 Feb 2026 22:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB968C116C6;
	Fri,  6 Feb 2026 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770416908;
	bh=4QIFGvFfg4LSWRydXVNM8TvmNgmijeL6c2LThIuq+4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r4gY9fKNZSIYkKwzxtJ9FAvasilXCzSvelXuXMd78N3A23EYF8kAk0NBMjE+z+uKD
	 UDXylHAw9PMX5Wm3jITE3ai3AjdImFGQHei5iJDX8qmqMrJ3k/ErrZuFrD45pH5JUb
	 PSLpPECKYtYxkVTXAFA2wJEwBvQjqrJzpDExTCHzoX84uMIY9oaTdpdR/1YlUSsfQc
	 fvJdh5duePbULMKYIjCTu0XraKDkPmP3CsKusc6Z0SyUcJgt9N1xbgKsP2o0mOYurq
	 cOKkoFfy5ziIQ/SAbp1kYUAgVwHxp8TlgkInffgfLgz8jZBzbcojV/Bjle2ZBW/FJq
	 ZSDMb76GB2tng==
Date: Fri, 6 Feb 2026 16:28:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: qinyuntan <qinyuntan@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Guixin Liu <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Message-ID: <20260206222826.GA98751@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88437e1a-2df0-41e6-a58f-dcc68d4458bc@linux.alibaba.com>
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

On Fri, Jan 30, 2026 at 12:53:25PM +0800, qinyuntan wrote:
> Hi All,
> 
> Thank you all for the insightful discussion!
> 
> I agree with Leon's point that not all devices are created equal when it
> comes to SR-IOV handling during driver unbind.
> 
> Looking at existing driver implementations, I found two different
> approaches:
> 
> 1) mlx5 - unconditionally disables SR-IOV in remove:
> 
>    drivers/net/ethernet/mellanox/mlx5/core/main.c:
>    static void remove_one(struct pci_dev *pdev)
>    {
>        ...
>        mlx5_sriov_disable(pdev, false);
>        ...
>    }
> 
>    drivers/net/ethernet/mellanox/mlx5/core/sriov.c:
>    void mlx5_sriov_disable(struct pci_dev *pdev, bool num_vf_change)
>    {
>        struct mlx5_core_dev *dev  = pci_get_drvdata(pdev);
>        struct devlink *devlink = priv_to_devlink(dev);
>        int num_vfs = pci_num_vf(dev->pdev);
> 
>        pci_disable_sriov(pdev);  /* Always disable, no pci_vfs_assigned()
> check */
>        devl_lock(devlink);
>        mlx5_device_disable_sriov(dev, num_vfs, true, num_vf_change);
>        devl_unlock(devlink);
>    }
> 
> 2) ixgbe - checks pci_vfs_assigned() and skips disable if VFs are in use:
> 
>    drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:
>    static void ixgbe_remove(struct pci_dev *pdev)
>    {
>        ...
>    #ifdef CONFIG_PCI_IOV
>        ixgbe_disable_sriov(adapter);
>    #endif
>        ...
>    }
> 
>    drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:
>    #ifdef CONFIG_PCI_IOV
>        if (pci_vfs_assigned(adapter->pdev)) {
>            e_dev_warn("Unloading driver while VFs are assigned - VFs will
> not be deallocated\n");
>            return -EPERM;
>        }
>        pci_disable_sriov(adapter->pdev);
>    #endif
> 
> Regarding the warning level discussion: I would prefer keeping it as
> dev_warn() rather than downgrading to dev_info(). As Leon mentioned,
> some devices do require SR-IOV to be disabled when the PF is unbound,
> and for those cases, this warning is important for operators to notice
> and take action. A warning level helps ensure it doesn't get lost in
> normal system logs.
> 
> Please let me know how you'd like to proceed.

"driver left SR-IOV enabled after remove\n" is KERN_WARNING today, and
I'm OK with leaving it that way.

