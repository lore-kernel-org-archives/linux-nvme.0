From: schwidefsky@de.ibm.com (Martin Schwidefsky)
Date: Fri, 4 Oct 2013 09:40:53 +0200
Subject: [PATCH RFC 04/77] PCI/MSI/s390: Remove superfluous check of MSI
 type
In-Reply-To: <bae65aa3e30dfd23bd5ed47add7310cfbb96243a.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <bae65aa3e30dfd23bd5ed47add7310cfbb96243a.1380703262.git.agordeev@redhat.com>
Message-ID: <20131004094053.5e846a29@mschwide>

On Wed,  2 Oct 2013 12:48:20 +0200
Alexander Gordeev <agordeev@redhat.com> wrote:

> arch_setup_msi_irqs() hook can only be called from the generic
> MSI code which ensures correct MSI type parameter.
> 
> Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
> ---
>  arch/s390/pci/pci.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index c79c6e4..61a3c2c 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -425,8 +425,6 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  	int rc;
> 
>  	pr_debug("%s: requesting %d MSI-X interrupts...", __func__, nvec);
> -	if (type != PCI_CAP_ID_MSIX && type != PCI_CAP_ID_MSI)
> -		return -EINVAL;
>  	if (type == PCI_CAP_ID_MSI && nvec > 1)
>  		return 1;
>  	msi_vecs = min(nvec, ZPCI_MSI_VEC_MAX);

Acked-by: Martin Schwidefsky <schwidefsky at de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
