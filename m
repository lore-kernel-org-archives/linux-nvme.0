From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 10 Mar 2015 12:18:22 -0700
Subject: [PATCH] NVMe: Fix error handling of class_create("nvme")
In-Reply-To: <1425681821-620-1-git-send-email-khoroshilov@ispras.ru>
References: <1425681821-620-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <1426015102.18746.10.camel@jpfreyen-mobl5.amr.corp.intel.com>

On Sat, 2015-03-07@01:43 +0300, Alexey Khoroshilov wrote:
> class_create() returns ERR_PTR on failure,
> so IS_ERR() should be used instead of check for NULL.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov at ispras.ru>
> ---
>  drivers/block/nvme-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index ceb32dd52a6c..30ac50b3009d 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -3165,8 +3165,10 @@ static int __init nvme_init(void)
>  		nvme_char_major = result;
>  
>  	nvme_class = class_create(THIS_MODULE, "nvme");
> -	if (!nvme_class)
> +	if (IS_ERR(nvme_class)) {

Looking at IS_ERR(), it uses IS_ERR_VALUE() which uses unlikely(), which
from what I understand is a compiler hint that means "this error is
unlikely to happen".

Well, is this error unlikely to happen?  Looks like the error could be
caused by kzalloc() failing, which could more likely happen in a
low-cost Chromebook OS laptop (nvme boot driver just got accepted into
the OS). Or a number of other things going wrong within the
__class_register() call.

Without understanding the code in fine-print detail, it seems like how
'nvme_class' condition is checked can be a bit arbitrary.

> +		result = PTR_ERR(nvme_class);
>  		goto unregister_chrdev;
> +	}
>  
>  	result = pci_register_driver(&nvme_driver);
>  	if (result)
