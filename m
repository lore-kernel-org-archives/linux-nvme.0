From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Dec 2016 16:34:00 +0100
Subject: [PATCH 2/3] nvmet: Make cntlid globally unique
In-Reply-To: <1480936146-6406-3-git-send-email-sagi@grimberg.me>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-3-git-send-email-sagi@grimberg.me>
Message-ID: <20161205153400.GA6529@lst.de>

On Mon, Dec 05, 2016@01:09:05PM +0200, Sagi Grimberg wrote:
> We usually log the cntlid which is confusing in case
> we have multiple subsystems each with it's own cntlid ida.
> Instead make cntlid ida globally unique and log the initial
> association.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/target/core.c        | 10 ++++------
>  drivers/nvme/target/fabrics-cmd.c |  4 ++--
>  drivers/nvme/target/nvmet.h       |  1 -
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 4a367549eb93..cee26ddc47bb 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -18,6 +18,7 @@
>  
>  static struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
>  
> +static DEFINE_IDA(cntlid_ida);
>  /*

How about moving the empty line after this declaration instead of before?

> +	pr_info("creating controller %d for subsystem %s for NQN %s.\n",
> +		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn);

That's going to be a crazy long line in the dmesg log..

Otherwise looks fine:


Reviewed-by: Christoph Hellwig <hch at lst.de>
