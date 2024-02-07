Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7FAC4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=+6GgPNRuYtORArNTsgFy2E9ZmwlQ6KMtUVTT0zWiH9Y=; b=ccjbGUYdhDIxsK
	HKUCycmv/gazNAaVUu2Rw+Z584V/XosDi46c/MIXnh6NWnqaxVZTUwSnbWc1NcaLNNDNaAr6Byfwc
	Hb2aJuVb2ZJJ2XpjPgru19ZrCGjCXWutr8F/x9o6Sfxey2PgZvprVV0QOI3MDz/c/e9MbSBCgnBWa
	Ye1JxNjYYIRnfYiI1RL9AaW8rjv9/bCIKrviUB3x5Jp7hv3Swmi2H5Q93V2S257yaG10IxbgbP3Lo
	2XJ4ltQs4HYACS8o/etzO68F8adeJA8pbwDOg9VMMH6YRYvXqgoUOmPcLUqAhw97KjG5Lw13WqGPP
	el7SfyUNtNVUC+salRRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpxU-0000000C1qt-05Ih;
	Wed, 07 Feb 2024 21:59:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpxR-0000000C1qE-1FEv
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:59:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AF8C861253;
	Wed,  7 Feb 2024 21:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B30EC433C7;
	Wed,  7 Feb 2024 21:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707343192;
	bh=On018TSorg/OL4LLqCUiBrcY56aHb4+WsqD1cysQwhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nned71oxXmJpmZX+gpLGr1pfwpPkRxSivERYrGdEzE+PKb2CyWrOdwe/1wDay3ABL
	 fRMwDANqDbvL84JWpHK0ftRyYaVxLKnM8fLXw+qoeUWpcAJEiGi5WpSwvkvyP3mUh0
	 z+a3gQMyHWja+KN5Dl10ls91CdkE3b+ieYyje/VyfJxB414nchzqPT6KQylAlMI0LQ
	 +WGK0dGWqGStA9YKJVfaNN+ix5V0/mxp10u9Ek7VIpVr5kbFLkdT5/GwcIsiQiqd/a
	 11E9VUeu79/VrT0Qs2IwSVoGuZG8tvYRjyKIzc1pUku7gNS3PgMKcC2DjiPXBT1J0r
	 YSNXw6ZYxf2sQ==
Date: Wed, 7 Feb 2024 15:59:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	sagi@grimberg.me, djeffery@redhat.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] PCI: Support two-pass shutdown
Message-ID: <20240207215950.GA919764@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207214044.2374295-3-jallison@ciq.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_135953_443343_9FBE7233 
X-CRM114-Status: GOOD (  29.22  )
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

On Wed, Feb 07, 2024 at 01:40:41PM -0800, Jeremy Allison wrote:
> From: Tanjore Suresh <tansuresh@google.com>
> 
> Enhance the base PCI driver to add support for two-pass shutdown. Add
> shutdown_wait() method.
> 
> Assume a device takes n secs to shutdown. If a machine has been populated
> with M such devices, the total time spent in shutting down all the devices
> will be M * n secs if the shutdown is done synchronously. For example, if
> NVMe PCI Controllers take 5 secs to shutdown and if there are 16 such NVMe
> controllers in a system, system will spend a total of 80 secs to shutdown
> all NVMe devices in that system.
> 
> In order to speed up the shutdown time, a two-pass interface to shutdown
> has been implemented. The caller calls the shutdown method for each device
> in turn to allow a shutdown request to be sent, then the caller walks the
> list of devices and calls shutdown_wait() to synchronously wait for the
> shutdown to complete.
> 
> In the NVMe case above, all 16 devices will process the shutdown in
> parallel taking the total time to shutdown down to the time for one NVMe
> PCI Controller to shut down.
> 
> This will significantly reduce the machine reboot time.
> 
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> Signed-off-by: Jeremy Allison <jallison@ciq.com>

I already acked this, so you can include that ack in subsequent
revisions unless you make significant changes:
https://lore.kernel.org/r/20240130175430.GA527253@bhelgaas

Thanks for rewrapping the commit log!

> ---
>  drivers/pci/pci-driver.c | 9 +++++++++
>  include/linux/pci.h      | 2 ++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 51ec9e7e784f..257bbb04c806 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -547,6 +547,14 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
>  }
>  #endif /* CONFIG_PM_SLEEP */
>  
> +static void pci_device_shutdown_wait(struct device *dev)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct pci_driver *drv = pci_dev->driver;
> +
> +	if (drv && drv->shutdown_wait)
> +		drv->shutdown_wait(pci_dev);
> +}
>  #ifdef CONFIG_PM
>  
>  /* Auxiliary functions used for system resume and run-time resume */
> @@ -1682,6 +1690,7 @@ struct bus_type pci_bus_type = {
>  	.probe		= pci_device_probe,
>  	.remove		= pci_device_remove,
>  	.shutdown	= pci_device_shutdown,
> +	.shutdown_wait	= pci_device_shutdown_wait,
>  	.dev_groups	= pci_dev_groups,
>  	.bus_groups	= pci_bus_groups,
>  	.drv_groups	= pci_drv_groups,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index add9368e6314..5ef014ac84f2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -917,6 +917,7 @@ struct module;
>   *		Useful for enabling wake-on-lan (NIC) or changing
>   *		the power state of a device before reboot.
>   *		e.g. drivers/net/e100.c.
> + * @shutdown_wait: Optional driver callback to allow two-pass shutdown.
>   * @sriov_configure: Optional driver callback to allow configuration of
>   *		number of VFs to enable via sysfs "sriov_numvfs" file.
>   * @sriov_set_msix_vec_count: PF Driver callback to change number of MSI-X
> @@ -947,6 +948,7 @@ struct pci_driver {
>  	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
>  	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
>  	void (*shutdown)(struct pci_dev *dev);
> +	void (*shutdown_wait)(struct pci_dev *dev);
>  	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
>  	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
>  	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
> -- 
> 2.39.3
> 
> 

