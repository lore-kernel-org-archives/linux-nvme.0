From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 22 Jul 2019 15:09:14 -0700
Subject: [PATCH] nvme-pci: fix probe and remove race
In-Reply-To: <ef8149f9-b7e0-d2ba-6bcb-ff51d8e2a908@acm.org>
References: <20190719194256.23618-1-sagi@grimberg.me>
 <ef8149f9-b7e0-d2ba-6bcb-ff51d8e2a908@acm.org>
Message-ID: <045c47a4-0844-ec0f-bb5a-6d6c0bf386fe@grimberg.me>


>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 4b508d5e45cf..50061abe49c6 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -127,6 +127,7 @@ struct nvme_dev {
>> ????? dma_addr_t host_mem_descs_dma;
>> ????? struct nvme_host_mem_buf_desc *host_mem_descs;
>> ????? void **host_mem_desc_bufs;
>> +??? async_cookie_t async_probe;
>> ? };
>> ? static int io_queue_depth_set(const char *val, const struct 
>> kernel_param *kp)
>> @@ -2765,7 +2766,7 @@ static int nvme_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>> ????? dev_info(dev->ctrl.device, "pci function %s\n", 
>> dev_name(&pdev->dev));
>> ????? nvme_get_ctrl(&dev->ctrl);
>> -??? async_schedule(nvme_async_probe, dev);
>> +??? dev->async_probe = async_schedule(nvme_async_probe, dev);
>> ????? return 0;
>> @@ -2810,6 +2811,8 @@ static void nvme_remove(struct pci_dev *pdev)
>> ? {
>> ????? struct nvme_dev *dev = pci_get_drvdata(pdev);
>> +??? /* wait for async probe to complete */
>> +??? async_synchronize_cookie(dev->async_probe + 1);
>> ????? nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>> ????? pci_set_drvdata(pdev, NULL);
> 
> Hi Sagi,
> 
> Does the async_synchronize_cookie() call wait until all previously 
> started probes have finished? In other words, does the change in 
> nvme_remove() introduce a dependency between probe and remove calls of 
> different NVMe devices? Is that dependency important? If not, can it be 
> avoided to introduce that dependency?

It does create dependency as they are in the same domain I assume. Given
that nvme_remove() is really a hot-unplug operation (or shutdown) I am
not sure if this dependency is a limitation in any real use-case
though..
