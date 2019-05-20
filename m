From: minwoo.im@samsung.com (Minwoo Im)
Date: Mon, 20 May 2019 14:44:32 +0900
Subject: [PATCH V3 2/4] nvme-status: Introduce nvme status module to map
 errno
In-Reply-To: <BN8PR04MB5747BFE1C3B0B448989A4BBF86060@BN8PR04MB5747.namprd04.prod.outlook.com>
References: <BN8PR04MB5747BFE1C3B0B448989A4BBF86060@BN8PR04MB5747.namprd04.prod.outlook.com>
 <20190519183913.3493-1-minwoo.im.dev@gmail.com>
 <20190519183913.3493-3-minwoo.im.dev@gmail.com>
 <CGME20190520051526epcas4p268b27507fc5aa3aac2a2e30ff9fdd27e@epcms2p1>
Message-ID: <20190520054432epcms2p117ec6863810f257db816655f31b4eef7@epcms2p1>

> I'm not sure if this patch is tested or I'm making some terrible mistake
> in testing.
> 
> It is breaking tests based on the nvme-cli unless I'm doing something wrong,
> 
> in that case please correct me.

The one who has made a terrible mistake here is me ;)

> Default :-
> 
> root at mat ~/nvme-cli (master)# nvme id-ns /dev/nvme0n1
> NVME Identify Namespace 1:
> nsze    : 0x200000
> ncap    : 0x200000
> nuse    : 0x200000
> nsfeat  : 0
> nlbaf   : 0
> flbas   : 0
> mc      : 0
> dpc     : 0
> dps     : 0
> nmic    : 0
> rescap  : 0
> fpi     : 0
> dlfeat  : 0
> nawun   : 0
> nawupf  : 0
> nacwu   : 0
> nabsn   : 0
> nabo    : 0
> nabspf  : 0
> noiob   : 0
> nvmcap  : 0
> nsattr    : 0
> nvmsetid: 0
> anagrpid: 0
> endgid  : 0
> nguid   : 00000000000000000000000000000000
> eui64   : 0000000000000000
> lbaf  0 : ms:0   lbads:9  rp:0 (in use)
> root at mat ~/nvme-cli (master)# echo $?
> 0
> 
> With this patch-series.
> 
> root at mat ~/nvme-cli (master)# ./nvme id-ns /dev/nvme0n1
> NVME Identify Namespace 1:
> nsze    : 0x200000
> ncap    : 0x200000
> nuse    : 0x200000
> nsfeat  : 0
> nlbaf   : 0
> flbas   : 0
> mc      : 0
> dpc     : 0
> dps     : 0
> nmic    : 0
> rescap  : 0
> fpi     : 0
> dlfeat  : 0
> nawun   : 0
> nawupf  : 0
> nacwu   : 0
> nabsn   : 0
> nabo    : 0
> nabspf  : 0
> noiob   : 0
> nvmcap  : 0
> nsattr    : 0
> nvmsetid: 0
> anagrpid: 0
> endgid  : 0
> nguid   : 00000000000000000000000000000000
> eui64   : 0000000000000000
> lbaf  0 : ms:0   lbads:9  rp:0 (in use)
> root at mat ~/nvme-cli (master)# echo $?
> 5
> root at mat ~/nvme-cli (master)#
> 
> If I read code correctly it will default into the return EIO for
> nvme_XXX_status_to_errno(),
> 
> else will return EIO when status == 0. If my analysis is correct
> following untested patch
> 
> should fix the problem.
> 
> root@ ~/nvme-cli (master)# git diff
> diff --git a/nvme-status.c b/nvme-status.c
> index 349b49e..2dbfad8 100644
> --- a/nvme-status.c
> +++ b/nvme-status.c
> @@ -127,6 +127,9 @@ __u8 nvme_status_to_errno(int status, bool fabrics)
>  {
>         __u8 sct;
> 
> +       if (status == 0)
> +               return 0;
> +
>         if (status < 0)
>                 return ECOMM;
> 
> any thoughts ?

Totally agreed with this one.  Will prepare a V4 patch for this after some more reviews
on this :)

Thanks, really.
