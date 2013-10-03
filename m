From: bhutchings@solarflare.com (Ben Hutchings)
Date: Thu, 3 Oct 2013 22:52:54 +0100
Subject: [PATCH RFC 06/77] PCI/MSI: Factor out pci_get_msi_cap() interface
In-Reply-To: <9c282c4ab92731c719d161d2db6fc54ce33891d9.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <9c282c4ab92731c719d161d2db6fc54ce33891d9.1380703262.git.agordeev@redhat.com>
Message-ID: <1380837174.3419.21.camel@bwh-desktop.uk.level5networks.com>

On Wed, 2013-10-02@12:48 +0200, Alexander Gordeev wrote:
[...]
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -812,6 +812,21 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
>  	return 0;
>  }
>  
> +int pci_get_msi_cap(struct pci_dev *dev)
> +{
> +	int ret;
> +	u16 msgctl;
> +
> +	if (!dev->msi_cap)
> +		return -EINVAL;
[...]
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1144,6 +1144,11 @@ struct msix_entry {
>  
> 
>  #ifndef CONFIG_PCI_MSI
> +static inline int pci_get_msi_cap(struct pci_dev *dev)
> +{
> +	return -1;
[...]

Shouldn't this also return -EINVAL?

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
