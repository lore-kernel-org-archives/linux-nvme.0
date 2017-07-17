From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Mon, 17 Jul 2017 09:12:22 +0800
Subject: [PATCH 2/4] libmultipath: drop uevent_can_discard_by_devpath
In-Reply-To: <20170714113209.17177-3-mwilck@suse.com>
References: <20170714113209.17177-1-mwilck@suse.com>
 <20170714113209.17177-3-mwilck@suse.com>
Message-ID: <2d85a9ec-27af-af50-7242-9ca5d1b18e5d@huawei.com>

This patch combined with PATCH 3/4 looks more elegant than my previous patch
and it works to fix the multipathd hotplug problem for NoF.
Thanks.

Reviewed-by: Guan Junxiong <guanjunxiong at huawei.com>

On 2017/7/14 19:32, Martin Wilck wrote:
> This function is broken. Not all devices that matter for multipathd
> follow the block/$DEVICE/$PARTITION convention (example: NVME)
> 
> Signed-off-by: Martin Wilck <mwilck at suse.com>
> Reviewed-by: Hannes Reinecke <hare at suse.de>
> ---
>  libmultipath/uevent.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/libmultipath/uevent.c b/libmultipath/uevent.c
> index 4fbd1dfb..b688ca03 100644
> --- a/libmultipath/uevent.c
> +++ b/libmultipath/uevent.c
> @@ -143,36 +143,11 @@ uevent_need_merge(void)
>  	return need_merge;
>  }
>  
> -static bool
> -uevent_can_discard_by_devpath(const char *devpath)
> -{
> -	static const char BLOCK[] = "/block/";
> -	const char *tmp = strstr(devpath, BLOCK);
> -
> -	if (tmp == NULL) {
> -		condlog(4, "no /block/ in '%s'", devpath);
> -		return true;
> -	}
> -	tmp += sizeof(BLOCK) - 1;
> -	if (*tmp == '\0')
> -		/* just ".../block/" - discard */
> -		return true;
> -	/*
> -	 * If there are more path elements after ".../block/xyz",
> -	 * it's a partition - discard it; but don't discard ".../block/sda/".
> -	 */
> -	tmp = strchr(tmp, '/');
> -	return tmp != NULL && *(tmp + 1) != '\0';
> -}
> -
>  bool
>  uevent_can_discard(struct uevent *uev)
>  {
>  	struct config * conf;
>  
> -	if (uevent_can_discard_by_devpath(uev->devpath))
> -		return true;
> -
>  	/*
>  	 * do not filter dm devices by devnode
>  	 */
> 
