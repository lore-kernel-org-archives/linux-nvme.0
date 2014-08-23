From: ngalbo@micron.com (Neal Galbo (ngalbo))
Date: Sat, 23 Aug 2014 23:23:43 +0000
Subject: SR-IOV
In-Reply-To: <C0B83244-67C7-4AE0-A86F-B32D43BC2298@gmail.com>
References: <CAB7xdi=szj1-koLwHwrt3zmtbyXO3zitcM8wUr7NsJgUALJ3nQ@mail.gmail.com>
 <alpine.LRH.2.03.1408220811580.4696@AMR>,
 <C0B83244-67C7-4AE0-A86F-B32D43BC2298@gmail.com>
Message-ID: <77B9E79B-9171-4432-90E9-94FB5B3A1839@micron.com>

NVMe can accommodate SRIOV. It depends upon the controller implementation whether there is hardware support for VM's or not. Not necessary though, it can be completely done in software too. 

PCI-SIG is the go to place for the SRIOV spec. 

~ Neal Galbo
[iPad Air 128GB]



> On Aug 23, 2014,@4:15 PM, "Learner" <learner.study@gmail.com> wrote:
> 
> Is there a spec or guidelines to follow for implementing/designing SRIOV over nvme...I think the nvme spec doesnt cover SRIOV.
> 
> Thanks for your time!
> 
>> On Aug 22, 2014,@7:18 AM, Keith Busch <keith.busch@intel.com> wrote:
>> 
>>> On Thu, 21 Aug 2014, sheng qiu wrote:
>>> May i ask is SR-IOV currently enabled on the NVMe driver side (linux)
>>> ? if not, is there any plan for it?
>> 
>> It's not implemented in the linux driver, but no one's proposed a patch
>> yet either. I've been holding on to this one for a while, but haven't
>> been able to test.
>> ---
>> 
>> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
>> index 28aec2d..70b6476 100644
>> --- a/drivers/block/nvme-core.c
>> +++ b/drivers/block/nvme-core.c
>> @@ -2961,6 +2961,24 @@ static int nvme_resume(struct device *dev)
>> 
>> static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
>> 
>> +static int nvme_pci_sriov_configure(struct pci_dev *pdev, int numvfs)
>> +{
>> +    if (!pdev->is_physfn)
>> +        return -EPERM;
>> +    if (numvfs == 0) {
>> +        if (pci_vfs_assigned(pdev)) {
>> +            dev_warn(&pdev->dev,
>> +                 "Cannot disable SR-IOV VFs while assigned\n");
>> +            return -EPERM;
>> +        }
>> +        pci_disable_sriov(pdev);
>> +    }
>> +    else
>> +        pci_enable_sriov(pdev, numvfs);
>> +
>> +    return 0;
>> +}
>> +
>> static const struct pci_error_handlers nvme_err_handler = {
>>   .error_detected    = nvme_error_detected,
>>   .mmio_enabled    = nvme_dump_registers,
>> @@ -2988,6 +3006,7 @@ static struct pci_driver nvme_driver = {
>>   .driver        = {
>>       .pm    = &nvme_dev_pm_ops,
>>   },
>> +    .sriov_configure = nvme_pci_sriov_configure,
>>   .err_handler    = &nvme_err_handler,
>> };
>> --
>> 
>> 
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
