From: Steve.Schremmer@netapp.com (Schremmer, Steven)
Date: Tue, 6 Nov 2018 19:02:33 +0000
Subject: [PATCH] nvme: fixup ANA group descriptor offset
In-Reply-To: <20181105150036.17041-1-hare@suse.de>
References: <20181105150036.17041-1-hare@suse.de>
Message-ID: <BL0PR06MB4564B516DE22CB13359C73FA8CCB0@BL0PR06MB4564.namprd06.prod.outlook.com>

> From: Linux-nvme <linux-nvme-bounces at lists.infradead.org> On Behalf Of Hannes Reinecke
> 
> The ANA group descriptor offset changed between the specification
> sent for ratification and the final ratified document, causing the
> ANA log page not to be displayed correctly.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  linux/nvme.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux/nvme.h b/linux/nvme.h
> index 37d3bc1..1ad970a 100644
> --- a/linux/nvme.h
> +++ b/linux/nvme.h
> @@ -546,7 +546,7 @@ struct nvme_ana_group_desc {
>         __le32  nnsids;
>         __le64  chgcnt;
>         __u8    state;
> -       __u8    rsvd17[7];
> +       __u8    rsvd17[15];
>         __le32  nsids[];
>  };
> 
> --
> 2.13.7


Thanks, I was just getting ready to create a patch for this.

Reviewed-by: Steve Schremmer <steve.schremmer at netapp.com>
