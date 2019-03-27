From: s.miroshnichenko@yadro.com (Sergey Miroshnichenko)
Date: Wed, 27 Mar 2019 20:30:10 +0300
Subject: [PATCH RFC v4 08/21] nvme-pci: Handle movable BARs
In-Reply-To: <20190326202055.GP24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-9-s.miroshnichenko@yadro.com>
 <20190326202055.GP24180@google.com>
Message-ID: <63989325-c1f8-9579-8405-56dc83751a3b@yadro.com>

On 3/26/19 11:20 PM, Bjorn Helgaas wrote:
> [+cc Keith, Jens, Christoph, Sagi, linux-nvme, LKML]
> 
> On Mon, Mar 11, 2019@04:31:09PM +0300, Sergey Miroshnichenko wrote:
>> Hotplugged devices can affect the existing ones by moving their BARs.
>> PCI subsystem will inform the NVME driver about this by invoking
>> reset_prepare()+reset_done(), then iounmap()+ioremap() must be called.
> 
> Do you mean the PCI core will invoke ->rescan_prepare() and
> ->rescan_done() (as opposed to *reset*)?
> 

Yes, of course, sorry for the confusion!

These are new callbacks, so drivers can explicitly show their support of movable BARs, and
the PCI core can detect if they don't and note that the corresponding BARs can't be moved
for now.

>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko at yadro.com>
>> ---
>>  drivers/nvme/host/pci.c | 29 +++++++++++++++++++++++++++--
>>  1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 92bad1c810ac..ccea3033a67a 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -106,6 +106,7 @@ struct nvme_dev {
>>  	unsigned int num_vecs;
>>  	int q_depth;
>>  	u32 db_stride;
>> +	resource_size_t current_phys_bar;
>>  	void __iomem *bar;
>>  	unsigned long bar_mapped_size;
>>  	struct work_struct remove_work;
>> @@ -1672,13 +1673,16 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
>>  {
>>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>>  
>> -	if (size <= dev->bar_mapped_size)
>> +	if (dev->bar &&
>> +	    dev->current_phys_bar == pci_resource_start(pdev, 0) &&
>> +	    size <= dev->bar_mapped_size)
>>  		return 0;
>>  	if (size > pci_resource_len(pdev, 0))
>>  		return -ENOMEM;
>>  	if (dev->bar)
>>  		iounmap(dev->bar);
>> -	dev->bar = ioremap(pci_resource_start(pdev, 0), size);
>> +	dev->current_phys_bar = pci_resource_start(pdev, 0);
>> +	dev->bar = ioremap(dev->current_phys_bar, size);
> 
> dev->current_phys_bar is different from pci_resource_start() in the
> case where the PCI core has moved the nvme BAR, but nvme has not yet
> remapped it.
> 
> I'm not sure it's worth keeping track of current_phys_bar, as opposed
> to always unmapping and remapping.  Is this a performance path?  I
> think there are advantages to always exercising the same code path,
> regardless of whether the BAR happened to be moved, e.g., if there's a
> bug in the "BAR moved" path, it may be a heisenbug because whether we
> exercise that path depends on the current configuration.
> 
> If you do need to cache current_phys_bar, maybe this, so it's a little
> easier to see that you're not changing the ioremap() itself:
> 
>   dev->bar = ioremap(pci_resource_start(pdev, 0), size);
>   dev->current_phys_bar = pci_resource_start(pdev, 0);
> 

Oh, I see now. Rescan is rather a rare event, and unconditional remapping is simpler, so a
bit more resistant to bugs.

>>  	if (!dev->bar) {
>>  		dev->bar_mapped_size = 0;
>>  		return -ENOMEM;
>> @@ -2504,6 +2508,8 @@ static void nvme_reset_work(struct work_struct *work)
>>  	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
>>  		goto out;
>>  
>> +	nvme_remap_bar(dev, db_bar_size(dev, 0));
> 
> How is this change connected to rescan?  This looks reset-related.
> 

Thanks for catching that! This has also slipped form early stage of this pathset, when
reset_done() (which is rescan_done() now) just initiated an NVME reset.

Best regards,
Serge

>>  	/*
>>  	 * If we're called to reset a live controller first shut it down before
>>  	 * moving on.
>> @@ -2910,6 +2916,23 @@ static void nvme_error_resume(struct pci_dev *pdev)
>>  	flush_work(&dev->ctrl.reset_work);
>>  }
>>  
>> +void nvme_rescan_prepare(struct pci_dev *pdev)
>> +{
>> +	struct nvme_dev *dev = pci_get_drvdata(pdev);
>> +
>> +	nvme_dev_disable(dev, false);
>> +	nvme_dev_unmap(dev);
>> +	dev->bar = NULL;
>> +}
>> +
>> +void nvme_rescan_done(struct pci_dev *pdev)
>> +{
>> +	struct nvme_dev *dev = pci_get_drvdata(pdev);
>> +
>> +	nvme_dev_map(dev);
>> +	nvme_reset_ctrl_sync(&dev->ctrl);
>> +}
>> +
>>  static const struct pci_error_handlers nvme_err_handler = {
>>  	.error_detected	= nvme_error_detected,
>>  	.slot_reset	= nvme_slot_reset,
>> @@ -2974,6 +2997,8 @@ static struct pci_driver nvme_driver = {
>>  	},
>>  	.sriov_configure = pci_sriov_configure_simple,
>>  	.err_handler	= &nvme_err_handler,
>> +	.rescan_prepare	= nvme_rescan_prepare,
>> +	.rescan_done	= nvme_rescan_done,
>>  };
>>  
>>  static int __init nvme_init(void)
>> -- 
>> 2.20.1
>>
