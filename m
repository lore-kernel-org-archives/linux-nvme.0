From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Oct 2018 09:26:35 -0600
Subject: [PATCH ] nvme-cli: fix a typo
In-Reply-To: <20181023151323.7578-1-ramirose@gmail.com>
References: <20181023151323.7578-1-ramirose@gmail.com>
Message-ID: <20181029152635.GA16453@localhost.localdomain>

On Tue, Oct 23, 2018@06:13:23PM +0300, Rami Rosen wrote:
> Signed-off-by: Rami Rosen <ramirose at gmail.com>
> ---
>  nvme-builtin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/nvme-builtin.h b/nvme-builtin.h
> index 7cf10ef..b913cea 100644
> --- a/nvme-builtin.h
> +++ b/nvme-builtin.h
> @@ -54,7 +54,7 @@ COMMAND_LIST(
>  	ENTRY("write-zeroes", "Submit a write zeroes command, return results", write_zeroes)
>  	ENTRY("write-uncor", "Submit a write uncorrectable command, return results", write_uncor)
>  	ENTRY("sanitize", "Submit a sanitize command", sanitize)
> -	ENTRY("sanitize-log", "Retrive sanitize log, show it", sanitize_log)
> +	ENTRY("sanitize-log", "Retrieve sanitize log, show it", sanitize_log)
>  	ENTRY("reset", "Resets the controller", reset)
>  	ENTRY("subsystem-reset", "Resets the controller", subsystem_reset)
>  	ENTRY("ns-rescan", "Rescans the NVME namespaces", ns_rescan)
> -- 

Applied, thank you!
