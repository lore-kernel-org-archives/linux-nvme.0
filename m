From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 11 Jul 2019 17:49:39 -0700
Subject: [PATCH rfc v2 06/10] nvme-cli: Add routine to compare
 ctrl_list_item to connect args
In-Reply-To: <20190712003140.16221-7-jsmart2021@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-7-jsmart2021@gmail.com>
Message-ID: <f4aa9904-b362-0908-ae20-d97715d9ad2d@grimberg.me>


> In preparation for searching controllers to match with connect args:
> 
> Create a new routine that receives a structure containing connect
> arguments and a device name. The routine will build and fill in a
> ctrl_list_item for the device and compare its attributes with the
> connect arguments. The routine returns true/false on whether they
> match.
> 
> Routine is defined as a global as a subsequent patch will use it
> from the fabrics routines.
> 
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> CC: Sagi Grimberg <sagi at grimberg.me>
> CC: Hannes Reinecke <hare at suse.com>
> ---
>   nvme.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   nvme.h |  9 +++++++++
>   2 files changed, 49 insertions(+)
> 
> diff --git a/nvme.c b/nvme.c
> index 66ba2fc..ef3c61c 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -2010,6 +2010,46 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
>   	return nvme_status_to_errno(ret, false);
>   }
>   
> +static char *nvme_ctrl_dir = "/sys/class/nvme/";

SYS_NVME?


Other than that, looks good

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
