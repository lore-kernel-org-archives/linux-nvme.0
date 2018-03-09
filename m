From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 9 Mar 2018 08:52:35 +0100
Subject: NVMf initiator persistent across boots
In-Reply-To: <3194fcec-aca1-06dc-5da8-e3fadad3ce25@mellanox.com>
References: <20170830094553.GC3941@linux-x5ow.site>
 <21e13bdf-d7a4-b47b-0885-855ba5ed995b@mellanox.com>
 <b4a9ae60-c374-653d-0207-62d1ea36ae76@grimberg.me>
 <67d0fb1b-bd3c-b17f-b0a6-3c2b748d74fb@mellanox.com>
 <20180308083917.hddo3wqmlqmx6fes@linux-x5ow.site>
 <bf33f7c7-8173-c98c-8a17-de0277e5f05c@mellanox.com>
 <20180308101313.ozwedysig3amjoel@linux-x5ow.site>
 <0385c9c1-dac3-e243-335d-af61ceb0c4fb@mellanox.com>
 <20180308132656.yx2uiix4dcjzmp2a@linux-x5ow.site>
 <3194fcec-aca1-06dc-5da8-e3fadad3ce25@mellanox.com>
Message-ID: <20180309075235.5ouqlyd7pmslwvjg@linux-x5ow.site>

On Thu, Mar 08, 2018@07:04:17PM +0200, Max Gurtovoy wrote:
> diff --git a/fabrics.c b/fabrics.c
> index 4bdaaf2..774d5dc 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -614,6 +614,14 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry
> *e)
>                 p += len;
>         }
> 
> +       if (cfg.host_traddr) {
> +               len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
> +               if (len < 0)
> +                       return -EINVAL;
> +               p+= len;
> +       }
> +
> +
>         switch (e->trtype) {
>         case NVMF_TRTYPE_LOOP: /* loop */
>                 len = sprintf(p, ",transport=loop");
> @@ -659,11 +667,6 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry
> *e)
>                                 return -EINVAL;
>                         p += len;
> 
> -                       len = sprintf(p, ",host_traddr=%s",
> cfg.host_traddr);
> -                       if (len < 0)
> -                               return -EINVAL;
> -                       p+= len;
> -
>                         len = sprintf(p, ",traddr=%.*s",
>                                       space_strip_len(NVMF_TRADDR_SIZE,
> e->traddr),
>                                       e->traddr);
> 
> 
> thoughts ?

Looks good to me.
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
