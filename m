From: keith.busch@intel.com (Busch, Keith)
Date: Tue, 30 Apr 2013 22:13:41 +0000
Subject: Added MSI supoort (includes MSI Multiple) to Linux NVME Driver
In-Reply-To: <CAKt=HwLSYf66pq8N9kdt-iq8_O7UH5neHGL13gR5pAngEZeetA@mail.gmail.com>
References: <CAKt=HwLSYf66pq8N9kdt-iq8_O7UH5neHGL13gR5pAngEZeetA@mail.gmail.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93AE9D7E3@ORSMSX154.amr.corp.intel.com>

On Mon, 5 Mar 2013, Ramachandra Rao Gajula wrote:
> ------
> 
> Added MSI supoort (includes MSI Multiple) to Linux NVME Driver
> 
> ------

Could you make this a proper git commit message, including Signed-off-by tag?

> @@ -1416,6 +1416,7 @@ static int set_queue_count(struct nvme_dev *dev, int count)
> static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)  {
>  	int result, cpu, i, nr_io_queues, db_bar_size, q_depth;
> +	int try_msi=0;

I don't think you need this variable 'try_msi' when you can just check
pci_dev->msix_enabled to know if you should try msi.

> +		if (result == 0) {	/* got all vectors */
> +			dev->pci_dev.msix_enabled = 1;

You shouldn't be setting this directly. pci_enable_msix will set the value if
it was successful.

> +		if (result == 0) {
> +				dev->pci_dev.msi_enabled = 1;

Same situation here as msix_enabled.

>  	result = nvme_setup_prp_pools(dev);
>  	if (result)
> -		goto disable_msix;
> +		goto free_instance;
> 
>  	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
>  	if (!dev->bar) {
>  		result = -ENOMEM;
> -		goto disable_msix;
> +		goto free_prps;
>  	}

Looks like you're fixing up some of the error out cases. Maybe separate this in
a different patch?

> @@ -1796,3 +1826,4 @@
> MODULE_LICENSE("GPL");
> MODULE_VERSION("0.8");
> module_init(nvme_init);
> module_exit(nvme_exit);
> +

Extra newline here at the end?

In general, code comments should be used to explain something that isn't
obvious from reading the code, and I think you've used comments a bit
liberally in this patch.
