From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 05 Jun 2015 10:37:56 -0600
Subject: [PATCHv3] NVMe: Automatic namespace rescan
In-Reply-To: <1433190494-19375-1-git-send-email-keith.busch@intel.com>
References: <1433190494-19375-1-git-send-email-keith.busch@intel.com>
Message-ID: <5571D064.4020405@kernel.dk>

On 06/01/2015 02:28 PM, Keith Busch wrote:
> Namespaces may be dynamically allocated and deleted or attached and
> detached. This has the driver rescan the device for namespace changes
> after each device reset or namespace change asynchronous event.
>
> There could potentially be many detached namespaces that we don't want
> polluting /dev/ with unusable block handles, so this will delete disks
> if the namespace is not active as indicated by the response from identify
> namespace. This also skips adding the disk if no capacity is provisioned
> to the namespace in the first place.

Looks good to me. I'll apply this, and then I should also respin the 
patch to detach namespaces dynamically on top of this.

-- 
Jens Axboe
