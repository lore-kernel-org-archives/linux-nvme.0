From: Christian.Koenig@amd.com (Koenig, Christian)
Date: Tue, 23 Jul 2019 16:23:23 +0000
Subject: [PATCH 03/14] PCI/P2PDMA: Apply host bridge white list for ACS
In-Reply-To: <20190722230859.5436-4-logang@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-4-logang@deltatee.com>
Message-ID: <7ced9658-33f9-4496-4335-a6852f08ed12@amd.com>

Am 23.07.19 um 01:08 schrieb Logan Gunthorpe:
> When a P2PDMA transfer is rejected due to ACS being set, we
> can also check the white list and allow the transactions.
>
> Do this by pushing the whitelist check into the
> upstream_bridge_distance() function.
>
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>

This one and patch #2 are Reviewed-by: Christian K?nig 
<christian.koenig at amd.com>.

But I actually think the two patches could be merged.

Christian.

> ---
>   drivers/pci/p2pdma.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 289d03a31e7d..d5034e28d1e1 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -324,15 +324,7 @@ static int __upstream_bridge_distance(struct pci_dev *provider,
>   		dist_a++;
>   	}
>   
> -	/*
> -	 * Allow the connection if both devices are on a whitelisted root
> -	 * complex, but add an arbitrary large value to the distance.
> -	 */
> -	if (root_complex_whitelist(provider) &&
> -	    root_complex_whitelist(client))
> -		return (dist_a + dist_b) | P2PDMA_THRU_HOST_BRIDGE;
> -
> -	return (dist_a + dist_b) | P2PDMA_NOT_SUPPORTED;
> +	return (dist_a + dist_b) | P2PDMA_THRU_HOST_BRIDGE;
>   
>   check_b_path_acs:
>   	bb = b;
> @@ -350,7 +342,8 @@ static int __upstream_bridge_distance(struct pci_dev *provider,
>   	}
>   
>   	if (acs_cnt)
> -		return P2PDMA_NOT_SUPPORTED | P2PDMA_ACS_FORCES_UPSTREAM;
> +		return (dist_a + dist_b) | P2PDMA_ACS_FORCES_UPSTREAM |
> +			P2PDMA_THRU_HOST_BRIDGE;
>   
>   	return dist_a + dist_b;
>   }
> @@ -397,7 +390,17 @@ static int upstream_bridge_distance(struct pci_dev *provider,
>   				    struct pci_dev *client,
>   				    struct seq_buf *acs_list)
>   {
> -	return __upstream_bridge_distance(provider, client, acs_list);
> +	int dist;
> +
> +	dist = __upstream_bridge_distance(provider, client, acs_list);
> +
> +	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
> +		return dist;
> +
> +	if (root_complex_whitelist(provider) && root_complex_whitelist(client))
> +		return dist;
> +
> +	return dist | P2PDMA_NOT_SUPPORTED;
>   }
>   
>   static int upstream_bridge_distance_warn(struct pci_dev *provider,
