From: james.smart@broadcom.com (James Smart)
Date: Mon, 8 Apr 2019 14:57:53 -0700
Subject: [PATCH] nvmet: Fix discover log page when offsets are used
In-Reply-To: <20190408192932.563-1-keith.busch@intel.com>
References: <20190408192932.563-1-keith.busch@intel.com>
Message-ID: <dc9a802a-6a5c-f5b3-83e3-a1662f36f718@broadcom.com>



On 4/8/2019 12:29 PM, Keith Busch wrote:
> The nvme target hadn't been taking the Get Log Page offset parameter
> into consideration, and so has been returning corrupting logs pages when
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
>   drivers/nvme/target/admin-cmd.c | 10 +++++++
>   drivers/nvme/target/discovery.c | 63 +++++++++++++++++++++++++----------------
>   drivers/nvme/target/nvmet.h     |  1 +
>   3 files changed, 50 insertions(+), 24 deletions(-)
>
>

Reviewed-by:? James Smart? <james.smart at broadcom.com>

Looks good.

-- james
