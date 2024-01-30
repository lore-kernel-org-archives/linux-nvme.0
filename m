Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A180CC48285
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 17:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=cwtBGMuPYJO0DItcApZiBE2l59FMGRLcHdVZpk/l2s4=; b=R6iMxEIJQ0H0M8
	ZNZGHlwkxCjUToZMtRyJQMezEOi+56amw9GSENf9oN8OopCk37LaCwsblRNtj9/wjrhyshI6XYiQb
	vyfXrq40hW4gsXKsXdZ+ICg4J0UE0aaWSVpIbQLVlYy2EOFb0ZL9ICIHqfurJW4j8fl8+zwVoWLnT
	0+hM4r9yQRXwnwsbJW5KulH58d9mTYXEMDl9uyVPv9fnRy6GjcHKIo5EGXaaKc3LoOYpr16qqD1+b
	SZxk1vMCxZY+rpirhPpAKovOpZt/iD769I8qwJ6pUaOUQePOskLqLgje+rLhL6imiLWpusf5eEQBG
	8YdRvI77RpTtCeOW1ZDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUsJf-000000002P3-2JQ1;
	Tue, 30 Jan 2024 17:54:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUsJd-000000002Oh-0UVz
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 17:54:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8323A60E0A;
	Tue, 30 Jan 2024 17:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD5BC433C7;
	Tue, 30 Jan 2024 17:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706637272;
	bh=0YGBClCQ+97utqkf5LdBg/2cikXZCx2GN/y6SwZR9xo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kAi4zvkUxemGoiMfh4z96vt5SIEWc1YyusOmog+w9wrxmV9I2BW0M1MTwxPrSxat1
	 nSUFBM779SF4UWixtg1S5dbSmBOGCFUu3vvXFsA7V/NV6PCBYnkQhF3HMpiu+dWrwx
	 iDDgEzVvsTKVMtqQSkW8ztk5AzuhG5mW+6Fo5nnFChXeCoe6xDOnw92fB1wGxQOj3v
	 sgo4KCnR4X6Gs1LGs+KWd3n/Fqid+/PDMhcLv3Mww49jSKo7HPtZ2ApwaouuOwY7vC
	 AU6yo/Noi93M4oMHHUSHxNiHT2DHuE5KtBv12olztAQCOzTRnsWWonS2Yeu+UoKaU5
	 3u8mYMJc96z/Q==
Date: Tue, 30 Jan 2024 11:54:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] PCI: Support two-pass shutdown
Message-ID: <20240130175430.GA527253@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129181953.1183084-3-jallison@ciq.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_095433_264110_0EF696FE 
X-CRM114-Status: GOOD (  30.82  )
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

On Mon, Jan 29, 2024 at 10:19:50AM -0800, Jeremy Allison wrote:
> From: Tanjore Suresh <tansuresh@google.com>
> 
> Enhance the base PCI driver to add support for two-pass
> shutdown. Add shutdown_wait() method.
> 
> Assume a device takes n secs to shutdown. If a machine has been
> populated with M such devices, the total time spent in shutting down
> all the devices will be M * n secs if the shutdown is done
> synchronously. For example, if NVMe PCI Controllers take 5 secs
> to shutdown and if there are 16 such NVMe controllers in a system,
> system will spend a total of 80 secs to shutdown all
> NVMe devices in that system.
> 
> In order to speed up the shutdown time, a two-pass interface to
> shutdown has been implemented. The caller calls the shutdown method
> for each device in turn to allow a shutdown request to be sent,
> then the caller walks the list of devices and calls shutdown_wait()
> to synchronously wait for the shutdown to complete.
> 
> In the NVMe case above, all 16 devices will process the shutdown
> in parallel taking the total time to shutdown down to the time
> for one NVMe PCI Controller to shut down.
> 
> This will significantly reduce the machine reboot time.
> 
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> Signed-off-by: Jeremy Allison <jallison@ciq.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Please rewrap the commit log to fill 75 columns.

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

