From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 4 Jan 2018 15:50:40 -0600
Subject: [PATCH 02/12] pci-p2p: Add sysfs group to display p2pmem stats
In-Reply-To: <20180104190137.7654-3-logang@deltatee.com>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-3-logang@deltatee.com>
Message-ID: <20180104215040.GE189897@bhelgaas-glaptop.roam.corp.google.com>

On Thu, Jan 04, 2018@12:01:27PM -0700, Logan Gunthorpe wrote:
> Attributes display the total amount of P2P memory, the ammount available
> and whether it is published or not.

s/ammount/amount/ (also below)

> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 25 ++++++++++++++++
>  drivers/pci/p2p.c                       | 51 +++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 44d4b2be92fd..7b80ea77faca 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -323,3 +323,28 @@ Description:
>  
>  		This is similar to /sys/bus/pci/drivers_autoprobe, but
>  		affects only the VFs associated with a specific PF.
> +
> +What:		/sys/bus/pci/devices/.../p2pmem/available

I wonder if "p2pdma" would be a more suggestive term?  It's not really
the *memory* that is peer-to-peer; the peer-to-peer part is referring
to *access* to the memory.

> @@ -82,6 +130,9 @@ static int pci_p2pmem_setup(struct pci_dev *pdev)
>  	if (error)
>  		goto out_pool_destroy;
>  
> +	if (sysfs_create_group(&pdev->dev.kobj, &p2pmem_group))
> +		dev_warn(&pdev->dev, "failed to create p2p sysfs group\n");

Not sure the warning (by itself) is worthwhile.  If we were going to
disable the feature if sysfs_create_group() failed, that's one thing,
but we aren't doing anything except generating a warning, which the
user can't really do anything with.  If the user is looking for the
sysfs file, its absence will be obvious even without the message.

>  	pdev->p2p = p2p;
>  
>  	return 0;
> -- 
> 2.11.0
> 
