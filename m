From: hare@suse.de (Hannes Reinecke)
Date: Thu, 13 Dec 2018 13:19:25 +0100
Subject: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
In-Reply-To: <20181213114124.GB7543@calabresa>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de>
 <20181213114124.GB7543@calabresa>
Message-ID: <049a1fb5-a5da-4aa7-8733-bcbe290a9713@suse.de>

On 12/13/18 12:41 PM, Thadeu Lima de Souza Cascardo wrote:
> On Thu, Dec 13, 2018@10:18:40AM +0100, Hannes Reinecke wrote:
>> On 12/6/18 5:48 PM, Thadeu Lima de Souza Cascardo wrote:
>>> Without this exposure, lsblk will fail as it tries to find out the
>>> device's dev_t numbers. This causes a real problem for nvme multipath
>>> devices, as their slaves are hidden.
>>>
>>> Exposing them fixes the problem, even though trying to open the devices
>>> returns an error in the case of nvme multipath. So, right now, it's the
>>> driver's responsibility to return a failure to open hidden devices.
>>>
>>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo at canonical.com>
>>> ---
>>>    block/genhd.c | 9 ++++-----
>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/block/genhd.c b/block/genhd.c
>>> index 7674fce32fca..65a7fa664188 100644
>>> --- a/block/genhd.c
>>> +++ b/block/genhd.c
>>> @@ -687,6 +687,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>>>    	disk_alloc_events(disk);
>>> +	disk_to_dev(disk)->devt = devt;
>>>    	if (disk->flags & GENHD_FL_HIDDEN) {
>>>    		/*
>>>    		 * Don't let hidden disks show up in /proc/partitions,
>>> @@ -698,13 +699,12 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>>>    		int ret;
>>>    		/* Register BDI before referencing it from bdev */
>>> -		disk_to_dev(disk)->devt = devt;
>>>    		ret = bdi_register_owner(disk->queue->backing_dev_info,
>>>    						disk_to_dev(disk));
>>>    		WARN_ON(ret);
>>> -		blk_register_region(disk_devt(disk), disk->minors, NULL,
>>> -				    exact_match, exact_lock, disk);
>>>    	}
>>> +	blk_register_region(disk_devt(disk), disk->minors, NULL,
>>> +			    exact_match, exact_lock, disk);
>>>    	register_disk(parent, disk, groups);
>>>    	if (register_queue)
>>>    		blk_register_queue(disk);
>>> @@ -776,8 +776,7 @@ void del_gendisk(struct gendisk *disk)
>>>    		WARN_ON(1);
>>>    	}
>>> -	if (!(disk->flags & GENHD_FL_HIDDEN))
>>> -		blk_unregister_region(disk_devt(disk), disk->minors);
>>> +	blk_unregister_region(disk_devt(disk), disk->minors);
>>>    	kobject_put(disk->part0.holder_dir);
>>>    	kobject_put(disk->slave_dir);
>>>
>> Welll ... this is not just 'lsblk', but more importantly this will force
>> udev to create _block_ device nodes for the hidden devices, essentially
>> 'unhide' them.
>>
>> Is this what we want?
>> Christoph?
>> I thought the entire _point_ of having hidden devices is that the are ...
>> well ... hidden ...
>>
> 
> I knew this would be the most controversial patch. And I had other solutions as
> well, but preferred this one. So, the other alternative would be just not use
> GENHD_FL_HIDDEN for the nvme devices, which would leave that flag without a
> single user in the kernel. That would still fix the two problems
> (initramfs-tools and lsblk), and not create any other problem I know of. That
> patch would still fail to open the underlying devices when there is a
> head/multipath associated with it.
> 
> So, the only thing GENHD_FL_HIDDEN gives us is saving some resources, like bdi,
> for example. And we could also use it to fail open when blkdev_get* is called.
> Of couse, that would still imply that its name should be changed, but as we
> already have an attribute named after that, I find it hard to suggest such a
> change.
> 
The whole point of the native nvme multipath implementation was that the 
block devices behind the multipathed device are _NOT_ visible to the OS.

This patch reverts the whole scheme, making it behaving just like the 
classical device-mapper multipathing did.

Why can't we just update lsblk to present the correct output?

nvme-cli (and multipath, for that matter) work happily with the current 
setup, _and_ provide the correct topology:

So why can't we do it with lsblk?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
