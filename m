From: maxg@mellanox.com (Max Gurtovoy)
Date: Sat, 14 Oct 2017 21:41:45 +0300
Subject: [PATCH] nvme/target: Change max_nsid in subsystem due to
 ns_disable if needed
In-Reply-To: <1507651167-4839-1-git-send-email-roys@lightbitslabs.com>
References: <1507651167-4839-1-git-send-email-roys@lightbitslabs.com>
Message-ID: <0ee63b18-9b42-a2c9-be1a-74c69735eb87@mellanox.com>



On 10/10/2017 6:59 PM, roys@lightbitslabs.com wrote:
> From: Roy Shterman <roys at lightbitslabs.com>
> 
> In case we disable namespaces which has the nsid like
> subsystem max_nsid we need to search for the next largest nsid
> in this subsystem. If the subsystem don't has more namespaces
> we set it to 0, else we take nsid from the last namespace in
> namespaces list because the list is sorted while inserting.
> 
> Signed-off-by: Roy Shterman <roys at lightbitslabs.com>
> ---

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
