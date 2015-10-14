From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 13 Oct 2015 18:11:50 -0700
Subject: [PATCH 2/5] block: Consolidate static integrity profile properties
In-Reply-To: <1444683912-7140-3-git-send-email-martin.petersen@oracle.com>
References: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
 <1444683912-7140-1-git-send-email-martin.petersen@oracle.com>
 <1444683912-7140-3-git-send-email-martin.petersen@oracle.com>
Message-ID: <CAPcyv4it_ju8JoNcmG7K3yiKyzS_hEsNRYhiLrU1ZvqfQHjVXw@mail.gmail.com>

On Mon, Oct 12, 2015 at 2:05 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
> We previously made a complete copy of a device's data integrity profile
> even though several of the fields inside the blk_integrity struct are
> pointers to fixed template entries in t10-pi.c.
>
> Split the static and per-device portions so that we can reference the
> template directly.
>
> Signed-off-by: Martin K. Petersen <martin.petersen at oracle.com>
> Reported-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
> Cc: Dan Williams <dan.j.williams at intel.com>
[..]
> diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
> index cb62ec6a12d0..9e1b0f656a9b 100644
> --- a/drivers/nvdimm/core.c
> +++ b/drivers/nvdimm/core.c
> @@ -399,19 +399,22 @@ static int nd_pi_nop_generate_verify(struct blk_integrity_iter *iter)
>
>  int nd_integrity_init(struct gendisk *disk, unsigned long meta_size)
>  {
> -       struct blk_integrity integrity = {
> +       struct blk_integrity bi;
> +       struct blk_integrity_profile profile = {
>                 .name = "ND-PI-NOP",
>                 .generate_fn = nd_pi_nop_generate_verify,
>                 .verify_fn = nd_pi_nop_generate_verify,
> -               .tuple_size = meta_size,
> -               .tag_size = meta_size,

'profile' here needs to be made static since we reference rather than
copy the profile data at blk_integrity_register() time.  This is part
of, but I don't think all of, my blk_integrity shutdown woes.
