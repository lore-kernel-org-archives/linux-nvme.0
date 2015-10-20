From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 20 Oct 2015 11:20:16 -0700
Subject: [PATCH 2/5] block: Consolidate static integrity profile properties
In-Reply-To: <1445309132-31824-3-git-send-email-martin.petersen@oracle.com>
References: <yq1fv16gtus.fsf@sermon.lab.mkp.net>
 <1445309132-31824-1-git-send-email-martin.petersen@oracle.com>
 <1445309132-31824-3-git-send-email-martin.petersen@oracle.com>
Message-ID: <CAPcyv4imFN+rknxXoYBOkhDy26iYO588MYghZ55QK26HWQA__Q@mail.gmail.com>

On Mon, Oct 19, 2015 at 7:45 PM, Martin K. Petersen
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
> ---
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

Oops, this version is missing the fix to make this static, I'll fold
that in for my local series and refresh
nvdimm.git/for-4.4/blk-intetgrity.
