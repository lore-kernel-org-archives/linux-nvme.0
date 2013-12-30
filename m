From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 30 Dec 2013 08:32:29 -0500
Subject: [PATCH RFC 1/5] NVMe: Code cleanup and minor checkpatch correction
In-Reply-To: <1388399240-13828-2-git-send-email-santoshsy@gmail.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
 <1388399240-13828-2-git-send-email-santoshsy@gmail.com>
Message-ID: <20131230133229.GG4945@linux.intel.com>

On Mon, Dec 30, 2013@03:57:16PM +0530, Santosh Y wrote:
> @@ -2120,7 +2120,7 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
>  
>  struct nvme_delq_ctx {
>  	struct task_struct *waiter;
> -	struct kthread_worker* worker;
> +	struct kthread_worker *worker;
>  	atomic_t refcount;
>  };
>  

This is fine ...

> @@ -2556,10 +2556,6 @@ static void nvme_remove(struct pci_dev *pdev)
>  {
>  	struct nvme_dev *dev = pci_get_drvdata(pdev);
>  
> -	spin_lock(&dev_list_lock);
> -	list_del_init(&dev->node);
> -	spin_unlock(&dev_list_lock);
> -
>  	pci_set_drvdata(pdev, NULL);
>  	flush_work(&dev->reset_work);
>  	misc_deregister(&dev->miscdev);

I'm going to let Keith comment on this before I apply it.  There might
be a reason to delete the node from the dev_list here before we call
flush_work().
