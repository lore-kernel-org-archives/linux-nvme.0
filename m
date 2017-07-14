From: bmarzins@redhat.com (Benjamin Marzinski)
Date: Fri, 14 Jul 2017 17:29:32 -0500
Subject: [PATCH 2/4] libmultipath: drop uevent_can_discard_by_devpath
In-Reply-To: <20170714113209.17177-3-mwilck@suse.com>
References: <20170714113209.17177-1-mwilck@suse.com>
 <20170714113209.17177-3-mwilck@suse.com>
Message-ID: <20170714222932.GB2940@octiron.msp.redhat.com>

ACK

-Ben

On Fri, Jul 14, 2017@01:32:07PM +0200, Martin Wilck wrote:
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
> -- 
> 2.13.2
