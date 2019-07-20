From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 20 Jul 2019 17:25:04 +0900
Subject: [PATCH v2 07/10] nvme-cli: Add routine to search for controller
 with specific attributes
In-Reply-To: <20190719225305.11397-8-jsmart2021@gmail.com>
References: <20190719225305.11397-1-jsmart2021@gmail.com>
 <20190719225305.11397-8-jsmart2021@gmail.com>
Message-ID: <20190720082504.GG22395@minwoo-desktop>

On 19-07-19 15:53:02, James Smart wrote:
> In preparation for searching controllers to match with connect args:
> 
> Create a new routine find_ctrl_with_connectargs() that will search the
> controllers that exist in the system to find one that has attributes
> that match the connect arguments specified.  If found, the routine
> returns the controller name ("nvme?"). If not found, a NULL is returned.
> 
> Routine is defined as a global as a subsequent patch will use it
> from the fabrics routines.
> 
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> 
> ---
> v2:
>   change "ctlr" to "ctrl" in fprintf

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>

> ---
>  nvme.c | 37 +++++++++++++++++++++++++++++++++++++
>  nvme.h |  1 +
>  2 files changed, 38 insertions(+)
> 
> diff --git a/nvme.c b/nvme.c
> index 7f706c8..e4fdb4e 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -2048,6 +2048,43 @@ cleanup_exit:
>  	return found;
>  }
>  
> +/*
> + * Look through the system to find an existing controller whose
> + * attributes match the connect arguments specified
> + * If found, a string containing the controller name (ex: "nvme?")
> + * is returned.
> + * If not found, a NULL is returned.
> + */
> +char *find_ctrl_with_connectargs(struct connect_args *args)
> +{
> +	struct dirent **devices;
> +	char *devname = NULL;
> +	int i, n;
> +
> +	n = scandir(SYS_NVME, &devices, scan_ctrls_filter, alphasort);
> +	if (n < 0) {
> +		fprintf(stderr, "no NVMe controller(s) detected.\n");
> +		return NULL;
> +	}
> +
> +	for (i = 0; i < n; i++) {
> +		if (ctrl_matches_connectargs(devices[i]->d_name, args)) {

James,

It might be too late to discuss about this argument, but did you decided
to have (struct connect_args) as a parameter for this function?

Sorry for not giving any thoughts on the following mail[1], but I would
prefer not introducing a new data structure for this because it's just a
bypass argument from a perspective of find_ctrl_with_connetargs().  But
If you think it's okay to go with, then I'm fine with that too.

[1] http://lists.infradead.org/pipermail/linux-nvme/2019-July/025646.html

Thanks!
