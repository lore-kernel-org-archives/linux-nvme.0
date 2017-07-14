From: bmarzins@redhat.com (Benjamin Marzinski)
Date: Fri, 14 Jul 2017 17:29:56 -0500
Subject: [PATCH 3/4] libmultipath: only listen for uevents with
 DEVTYPE=disk
In-Reply-To: <20170714113209.17177-4-mwilck@suse.com>
References: <20170714113209.17177-1-mwilck@suse.com>
 <20170714113209.17177-4-mwilck@suse.com>
Message-ID: <20170714222956.GC2940@octiron.msp.redhat.com>

ACK

-Ben

On Fri, Jul 14, 2017@01:32:08PM +0200, Martin Wilck wrote:
> We are only interested in disks anyway. This saves us checking
> for devtype in the uevent processing queue, and is more powerful
> than the previous test in the dropped function
> uevent_can_discard_by_devpath().
> 
> Signed-off-by: Martin Wilck <mwilck at suse.com>
> Reviewed-by: Hannes Reinecke <hare at suse.de>
> ---
>  libmultipath/uevent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libmultipath/uevent.c b/libmultipath/uevent.c
> index b688ca03..eb44da56 100644
> --- a/libmultipath/uevent.c
> +++ b/libmultipath/uevent.c
> @@ -770,7 +770,7 @@ int uevent_listen(struct udev *udev)
>  		goto out;
>  	}
>  	err = udev_monitor_filter_add_match_subsystem_devtype(monitor, "block",
> -							      NULL);
> +							      "disk");
>  	if (err)
>  		condlog(2, "failed to create filter : %s", strerror(-err));
>  	err = udev_monitor_enable_receiving(monitor);
> -- 
> 2.13.2
