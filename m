From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 17 Jul 2019 18:35:22 +0000
Subject: [PATCH v2] nvmet-file: fix nvmet_file_flush() always returning an
 error
References: <20190715221707.3265-1-logang@deltatee.com>
Message-ID: <BYAPR04MB57492E5376FAAF29B70A46F786C90@BYAPR04MB5749.namprd04.prod.outlook.com>

On 07/15/2019 03:17 PM, Logan Gunthorpe wrote:
> Presently, nvmet_file_flush() always returns a call to
> errno_to_nvme_status() but that helper doesn't take into account the
> case when errno=0. So nvmet_file_flush() always returns an error code.
>
> All other callers of errno_to_nvme_status() check for success before
> calling it.
>
> To fix this, ensure errno_to_nvme_status() returns success if the
> errno is zero. This should prevent future mistakes like this from
> happening.
>
> Fixes: c6aa3542e010 ("nvmet: add error log support for file backend")
> Signed-off-by: Logan Gunthorpe<logang at deltatee.com>
> Cc: Chaitanya Kulkarni<chaitanya.kulkarni at wdc.com>

Thanks for the fix Logan, errno_to_nvme_status() needs to be only called 
in the case of error. Clearly bad example of calling function withing 
function.

Looks good to me.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
