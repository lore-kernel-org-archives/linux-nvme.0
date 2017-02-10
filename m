From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 10 Feb 2017 08:45:38 +0100
Subject: [PATCH V3 2/2] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
In-Reply-To: <1486660801-5105-3-git-send-email-scott.bauer@intel.com>
References: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
 <1486660801-5105-3-git-send-email-scott.bauer@intel.com>
Message-ID: <e82756b9-df77-6033-b6ce-fbf9aac3b9a8@suse.de>

On 02/09/2017 06:20 PM, Scott Bauer wrote:
> When CONFIG_KASAN is enabled, compilation fails:
> 
> block/sed-opal.c: In function 'sed_ioctl':
> block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> 
> Moved all the ioctl structures off the stack and dynamically activate
> using _IOC_SIZE()
> 
> Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
> 
> Reported-by: Arnd Bergmann <arnd at arndb.de>
> Signed-off-by: Scott Bauer <scott.bauer at intel.com>
> ---
>  block/sed-opal.c | 134 +++++++++++++++++++++----------------------------------
>  1 file changed, 50 insertions(+), 84 deletions(-)
> 

[...]

> -		if (copy_from_user(&session, arg, sizeof(session)))
> -			return -EFAULT;
> -		return opal_erase_locking_range(dev, &session);
> +	ioctl_ptr = kzalloc(cmd_size, GFP_KERNEL);
> +	if (!ioctl_ptr)
> +		return -ENOMEM;
> +	if (copy_from_user(ioctl_ptr, arg, cmd_size)) {
> +		ret = -EFAULT;
> +		goto out;
>  	}

Can't we use memdup_user() instead of kzalloc() + copy_from_user()?



-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
