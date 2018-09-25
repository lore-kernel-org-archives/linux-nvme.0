From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 25 Sep 2018 10:29:15 -0700
Subject: [PATCH v7 02/13] PCI/P2PDMA: Add sysfs group to display p2pmem
 stats
In-Reply-To: <20180925162231.4354-3-logang@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
 <20180925162231.4354-3-logang@deltatee.com>
Message-ID: <1537896555.11137.22.camel@acm.org>

On Tue, 2018-09-25@10:22 -0600, Logan Gunthorpe wrote:
> @@ -83,9 +132,14 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
>  
>  	pdev->p2pdma = p2p;
>  
> +	error = sysfs_create_group(&pdev->dev.kobj, &p2pmem_group);
> +	if (error)
> +		goto out_pool_destroy;
> +
>  	return 0;
>  
>  out_pool_destroy:
> +	pdev->p2pdma = NULL;
>  	gen_pool_destroy(p2p->pool);
>  out:
>  	devm_kfree(&pdev->dev, p2p);

This doesn't look right to me. Shouldn't devm_remove_action() be called instead
of devm_kfree() if sysfs_create_group() fails?

Thanks,

Bart.
