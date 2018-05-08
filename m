From: hare@suse.de (Hannes Reinecke)
Date: Tue, 8 May 2018 07:57:40 +0200
Subject: [PATCH 1/7] nvme: remove unnecessary controller subnqn validation
In-Reply-To: <20180508001214.8951-2-jsmart2021@gmail.com>
References: <20180508001214.8951-1-jsmart2021@gmail.com>
 <20180508001214.8951-2-jsmart2021@gmail.com>
Message-ID: <20180508075740.39539081@pentland.suse.de>

On Mon,  7 May 2018 17:12:08 -0700
"James Smart" <jsmart2021@gmail.com> wrote:

> After creating the nvme controller, nvmf_create_ctrl() validates
> the newly created subsysnqn vs the one specified by the options.
> 
> In general, this is an unnecessary check as the Connect message
> should implicitly ensure this value matches.
> 
> With the change to the FC transport to do an asynchronous connect
> for the first association create, the transport will return to
> nvmf_create_ctrl() before that first association has been established,
> thus the subnqn will not yet be set.
> 
> Remove the unnecessary validation.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fabrics.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
