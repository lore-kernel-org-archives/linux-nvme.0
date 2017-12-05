From: thomas.tai@oracle.com (Thomas Tai)
Date: Tue, 5 Dec 2017 15:43:09 -0500
Subject: [PATCH] nvme: nvme_remove should cancel the reset_work before
 setting the ctrl state
In-Reply-To: <20171205200952.GA20019@localhost.localdomain>
References: <1512500495-16147-1-git-send-email-thomas.tai@oracle.com>
 <20171205200952.GA20019@localhost.localdomain>
Message-ID: <a47a4ffd-6c14-bf72-02c9-03afe2eae60d@oracle.com>



On 2017-12-05 03:09 PM, Keith Busch wrote:
> On Tue, Dec 05, 2017@12:01:35PM -0700, Thomas Tai wrote:
>> During nvme_probe, a reset_work task is queued up
>> for execution. When removing the nvme during unbinding,
>> the remove function set the ctrl state to NVME_CTRL_DELETING
>> and then cancel the reset_work. The correct sequence should
>> have been cancel the reset_work first then change the state.
>>
>> Otherwise, if the reset_work happens to schedule to work,
>> the NVME_CTRL_DELETING causes the reset_work function to
>> fail with "failed to make controller live".
> 
> The message seems to make sense. You requested to unbind the driver
> before the controller went live.
>   
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index a11cfd4..e2d10f9 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2534,9 +2534,9 @@ static void nvme_remove(struct pci_dev *pdev)
>>   {
>>   	struct nvme_dev *dev = pci_get_drvdata(pdev);
>>   
>> -	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>>   
>>   	cancel_work_sync(&dev->ctrl.reset_work);
>> +	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>>   	pci_set_drvdata(pdev, NULL);
> 
> The state is changed before synchronously cancelling the reset work so
> that nvme_remove is guaranteed another reset can't possibly occur while
> we're deleting the controller. This change provies a small window for
> which that could happen, and bad things will happen if it does.

Hi Keith,
Thank you for your explanation. So changing the state before 
cancel_work_sync() is the right way to go then.

Thank you,
Thomas

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
