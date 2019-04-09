From: james.smart@broadcom.com (James Smart)
Date: Mon, 8 Apr 2019 17:30:03 -0700
Subject: [PATCHv2] nvmet: Fix discover log page when offsets are used
In-Reply-To: <20190408194652.641-1-keith.busch@intel.com>
References: <20190408194652.641-1-keith.busch@intel.com>
Message-ID: <036a4f13-eec5-794b-6b2c-bde20f60a69f@broadcom.com>



On 4/8/2019 12:46 PM, Keith Busch wrote:
> The nvme target hadn't been taking the Get Log Page offset parameter
> into consideration, and so has been returning corrupted logs pages when
> offsets are used. Since many tools, including nvme-cli, split the log
> request to 4k, we've been breaking discovery log responses when more
> than 3 subsystems exist.
>
> Fix the log page by internally generating the entire discovery log page
> and copying only the requested bytes into the user buffer.
>
> Cc: Hannes Reinecke <hare at suse.de>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> v1 -> v2:
>
>    Fixed releasing nvmet_config_sem read lock
>
>    Fixed commit log spelling error
>
>    Return invalid field if offset is not dword aligned. This is spec
>    optional, but it's either check these bits or mask them off. I just
>    chose the former.
>
>   drivers/nvme/target/admin-cmd.c | 10 ++++++
>   drivers/nvme/target/discovery.c | 68 ++++++++++++++++++++++++++---------------
>   drivers/nvme/target/nvmet.h     |  1 +
>   3 files changed, 55 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 76250181fee0..e7f3f6e71853 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -24,6 +24,16 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd)
>   	return len;
>   }
>   
>

Reviewed-by:?? James Smart?? <james.smart at broadcom>

I didn't see anything this time.

-- james
