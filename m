From: joe@perches.com (Joe Perches)
Date: Thu, 20 Jul 2017 08:52:14 -0700
Subject: [PATCH v2 3/3] nvme: wwid_show: strip trailing 0-bytes
In-Reply-To: <20170720152745.3274-4-mwilck@suse.com>
References: <20170720152745.3274-1-mwilck@suse.com>
 <20170720152745.3274-4-mwilck@suse.com>
Message-ID: <1500565934.14415.12.camel@perches.com>

On Thu, 2017-07-20@17:27 +0200, Martin Wilck wrote:
> Some broken targets (such as the current Linux target) pad
> model or serial fields with 0-bytes rather than spaces. The
> NVME spec disallows 0 bytes in "ASCII" fields.
> Thus strip trailing 0-bytes, too.
> 
> Signed-off-by: Martin Wilck <mwilck at suse.com>
> Reviewed-by: Hannes Reinecke <hare at suse.de>
> Acked-by: Christoph Hellwig <hch at lst.de>
> 
> ---
>  drivers/nvme/host/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
[]
> @@ -2001,9 +2001,11 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
>  	if (memchr_inv(ns->eui, 0, sizeof(ns->eui)))
>  		return sprintf(buf, "eui.%8phN\n", ns->eui);
>  
> -	while (ctrl->serial[serial_len - 1] == ' ')
> +	while (ctrl->serial[serial_len - 1] == ' ' ||
> +	       ctrl->serial[serial_len - 1] == '\0')
>  		serial_len--;
> -	while (ctrl->model[model_len - 1] == ' ')
> +	while (ctrl->model[model_len - 1] == ' ' ||
> +	       ctrl->model[model_len - 1] == '\0')
>  		model_len--;

Please add a <foo>_len > 0 to the while loops too
