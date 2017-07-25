From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 25 Jul 2017 20:13:28 +0300
Subject: [PATCH 1/1] nvme: fix CMB sysfs file removal in reset path
In-Reply-To: <20170725155630.GA25693@lst.de>
References: <1500991116-8227-1-git-send-email-maxg@mellanox.com>
 <20170725155630.GA25693@lst.de>
Message-ID: <49d30a85-736e-be6f-466b-cce4a0970063@mellanox.com>



On 7/25/2017 6:56 PM, Christoph Hellwig wrote:
> On Tue, Jul 25, 2017@04:58:36PM +0300, Max Gurtovoy wrote:
>> Currently we create the sysfs entry even if we fail mapping
>> it. In that case, the unmapping will not remove the sysfs created
>> file.
>>
>> Fixes: f63572dff ("nvme: unmap CMB and remove sysfs file in reset path")
>
> This looks correct, but I wonder if the better plan would be to only
> add the sysfs file if we have a working CMB?

Yes I thought about it too, but in case we don't want to "use_cmb_sqes"
and still want to see the device CMB capabilities, using this sysfs we 
could.
Why to do it ? for using this iomem for p2pmem for example.
Since, p2pmem is not yet upstream we can go with working CMB approach.

>
> Also the comment about the auto-removal above the call to
> sysfs_add_file_to_group for dev_attr_cmb looks wrong to me, that
> might be worth fixing up as well.

Sure, I'll update it in V2.
