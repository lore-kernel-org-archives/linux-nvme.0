From: hare@suse.de (Hannes Reinecke)
Date: Tue, 8 May 2018 07:58:17 +0200
Subject: [PATCH 2/7] nvme_fc: remove setting DNR on exception conditions
In-Reply-To: <20180508001214.8951-3-jsmart2021@gmail.com>
References: <20180508001214.8951-1-jsmart2021@gmail.com>
 <20180508001214.8951-3-jsmart2021@gmail.com>
Message-ID: <20180508075817.1195bd13@pentland.suse.de>

On Mon,  7 May 2018 17:12:09 -0700
"James Smart" <jsmart2021@gmail.com> wrote:

> Current code will set DNR if the controller is deleting or there is
> an error during controller init. None of this is necessary.
> 
> remove the code that sets DNR
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fc.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
