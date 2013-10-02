From: jacob.e.keller@intel.com (Keller, Jacob E)
Date: Wed, 2 Oct 2013 20:50:51 +0000
Subject: [PATCH RFC 40/77] ixgbevf: Update MSI/MSI-X interrupts
 enablement code
In-Reply-To: <338c9012577acf694eb23622902185584987bd8f.1380703263.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <338c9012577acf694eb23622902185584987bd8f.1380703263.git.agordeev@redhat.com>
Message-ID: <1380747051.32715.7.camel@jekeller-desk1.amr.corp.intel.com>

On Wed, 2013-10-02@12:48 +0200, Alexander Gordeev wrote:
> As result of recent re-design of the MSI/MSI-X interrupts enabling
> pattern this driver has to be updated to use the new technique to
> obtain a optimal number of MSI/MSI-X interrupts required.
> 
> Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   18 +++++++-----------
>  1 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index fa0537a..d506a01 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -1749,8 +1749,7 @@ void ixgbevf_reset(struct ixgbevf_adapter *adapter)
>  static int ixgbevf_acquire_msix_vectors(struct ixgbevf_adapter *adapter,
>  					int vectors)
>  {
> -	int err = 0;
> -	int vector_threshold;
> +	int err, vector_threshold;
>  
>  	/* We'll want at least 2 (vector_threshold):
>  	 * 1) TxQ[0] + RxQ[0] handler
> @@ -1763,18 +1762,15 @@ static int ixgbevf_acquire_msix_vectors(struct ixgbevf_adapter *adapter,
>  	 * Right now, we simply care about how many we'll get; we'll
>  	 * set them up later while requesting irq's.
>  	 */
> -	while (vectors >= vector_threshold) {
> -		err = pci_enable_msix(adapter->pdev, adapter->msix_entries,
> -				      vectors);
> -		if (!err || err < 0) /* Success or a nasty failure. */
> -			break;
> -		else /* err == number of vectors we should try again with */
> -			vectors = err;
> -	}
> +	err = pci_msix_table_size(adapter->pdev);
I would prefer to use something other than "err" here since the value
isn't really an error if it's greater than 0. However, it's not really a
big issue, since you immediately conver to using vectors on the next
line of code.. I think its alright overall.

Regards,
Jake

> +	if (err < 0)
> +		return err;
>  
> +	vectors = min(vectors, err);
>  	if (vectors < vector_threshold)
> -		err = -ENOSPC;
> +		return -ENOSPC;
>  
> +	err = pci_enable_msix(adapter->pdev, adapter->msix_entries, vectors);
>  	if (err) {
>  		dev_err(&adapter->pdev->dev,
>  			"Unable to allocate MSI-X interrupts\n");
