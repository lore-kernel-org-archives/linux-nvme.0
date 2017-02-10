From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Feb 2017 09:01:23 +0100
Subject: [PATCH V3 2/2] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
In-Reply-To: <1486660801-5105-3-git-send-email-scott.bauer@intel.com>
References: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
 <1486660801-5105-3-git-send-email-scott.bauer@intel.com>
Message-ID: <4455227.qpXP0b5apU@wuerfel>

On Thursday, February 9, 2017 10:20:01 AM CET Scott Bauer wrote:
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
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index bf1406e..4985d95 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -2346,7 +2346,10 @@ EXPORT_SYMBOL(opal_unlock_from_suspend);
>  
>  int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
>  {
> +	void *ioctl_ptr;
> +	int ret = -ENOTTY;
>  	void __user *arg = (void __user *)ptr;
> +	unsigned int cmd_size = _IOC_SIZE(cmd);
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EACCES;

We usually have a size check in there to avoid allocating large amounts
of memory. _IOC_SIZEBITS is 14, so you can have up to 16kb here, which
is probably ok, but I'd recommend either adding a comment to say that
it is, or just checking against the largest realistic size.

Having something like v4l with their tables if ioctl commands and
function pointers would also solve it, as you'd be checking for valid
command numbers before doing the copy then.

Otherwise looks good to me.

	Arnd
