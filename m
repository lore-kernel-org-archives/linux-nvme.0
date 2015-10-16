From: mlin@kernel.org (Ming Lin)
Date: Thu, 15 Oct 2015 23:14:14 -0700
Subject: [PATCH 17/18] nvme: move namespace scanning to common code
In-Reply-To: <1444975128-8768-18-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-18-git-send-email-hch@lst.de>
Message-ID: <1444976054.18781.2.camel@hasee>

On Fri, 2015-10-16@07:58 +0200, Christoph Hellwig wrote:
> @@ -2810,11 +2651,9 @@ static int __init nvme_init(void)
>  	if (!nvme_workq)
>  		return -ENOMEM;
>  
> -	result = register_blkdev(nvme_major, "nvme");
> +	result = nvme_core_init();
>  	if (result < 0)
>  		goto kill_workq;
> -	else if (result > 0)
> -		nvme_major = result;
>  
>  	result = __register_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme",
>  							&nvme_dev_fops);
> @@ -2839,7 +2678,7 @@ static int __init nvme_init(void)
>   unregister_chrdev:
>  	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
>   unregister_blkdev:
> -	unregister_blkdev(nvme_major, "nvme");
> +	nvme_core_exit();
>   kill_workq:
>  	destroy_workqueue(nvme_workq);
>  	return result;
> @@ -2848,7 +2687,7 @@ static int __init nvme_init(void)
>  static void __exit nvme_exit(void)
>  {
>  	pci_unregister_driver(&nvme_driver);
> -	unregister_blkdev(nvme_major, "nvme");
> +	nvme_core_exit();
>  	destroy_workqueue(nvme_workq);
>  	class_destroy(nvme_class);
>  	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");

Should nvme_core_{init,exit} be called in core.c?

I did this:
https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/commit/?h=nvme-split/virtio&id=76fa970
