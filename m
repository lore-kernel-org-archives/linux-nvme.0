From: hare@suse.de (Hannes Reinecke)
Date: Tue, 8 May 2018 08:01:21 +0200
Subject: [PATCH 4/7] nvme_fc: remove reinit_request routine
In-Reply-To: <20180508001214.8951-5-jsmart2021@gmail.com>
References: <20180508001214.8951-1-jsmart2021@gmail.com>
 <20180508001214.8951-5-jsmart2021@gmail.com>
Message-ID: <20180508080121.6c32d222@pentland.suse.de>

On Mon,  7 May 2018 17:12:11 -0700
"James Smart" <jsmart2021@gmail.com> wrote:

> The reinit_request routine is not necessary. Remove support for the
> op callback.
> 
> As all that nvme_reinit_tagset() does is itterate and call the
> reinit routine, it too has no purpose. Remove the call.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fc.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
