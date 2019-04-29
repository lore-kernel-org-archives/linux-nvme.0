From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Mon, 29 Apr 2019 11:40:52 -0600
Subject: [PATCH V2 1/3] nvme: introduce nvme-ctrl state name string array
In-Reply-To: <20190429032442.5923-2-chaitanya.kulkarni@wdc.com>
References: <20190429032442.5923-1-chaitanya.kulkarni@wdc.com>
 <20190429032442.5923-2-chaitanya.kulkarni@wdc.com>
Message-ID: <067b8ef5-abea-2bc8-9da5-a39ac3b54a1b@intel.com>



On 4/28/2019 9:24 PM, Chaitanya Kulkarni wrote:
> From: Hannes Reinecke <hare at suse.com>
> 
> This patch intoduces nvme-ctrl state name array which is used inthe the
s/intoduces /introduces/
s/inthe/in the/

> later patch to improve the logging of the ctrl state.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>   drivers/nvme/host/nvme.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 527d64545023..01a36bbafed6 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -146,6 +146,16 @@ enum nvme_ctrl_state {
>   	NVME_CTRL_DEAD,
>   };
>   
> +static const char *const nvme_ctrl_state_name[] = {
> +	[NVME_CTRL_NEW]         = "new",
> +	[NVME_CTRL_LIVE]        = "live",
> +	[NVME_CTRL_ADMIN_ONLY]  = "only-admin",
> +	[NVME_CTRL_RESETTING]   = "resetting",
> +	[NVME_CTRL_CONNECTING]  = "connecting",
> +	[NVME_CTRL_DELETING]    = "deleting",
> +	[NVME_CTRL_DEAD]        = "dead",
> +};

I haven't been paying attention if this was bought up before but won't 
this create multiple copies of this data for every source file the 
includes the header file?

> +
>   struct nvme_ctrl {
>   	bool comp_seen;
>   	enum nvme_ctrl_state state;
> 
