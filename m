From: jsmart2021@gmail.com (James Smart)
Date: Wed, 13 Jun 2018 08:29:04 -0700
Subject: [PATCH v3 4/4] nvme_fc: add 'nvme_discovery' sysfs attribute to
 fc transport device
In-Reply-To: <20180613113325.GD18531@infradead.org>
References: <20180612235028.17969-1-jsmart2021@gmail.com>
 <20180612235028.17969-5-jsmart2021@gmail.com>
 <20180613113325.GD18531@infradead.org>
Message-ID: <1b96039c-53d7-f899-d400-18217e4146c2@gmail.com>

On 6/13/2018 4:33 AM, Christoph Hellwig wrote:
> On Tue, Jun 12, 2018@04:50:28PM -0700, James Smart wrote:
>> The fc transport device should allow for a rediscovery, as userspace
>> might have lost the events. Example is udev events not handled during
>> system startup.
> 
> Please stop adding hacks for your non-standard discovery methods.

Please stop these boorish anti-fc comments. There is nothing 
non-standard or hackish about fc's discovery methods.

This patch simply addresses an issue that arises as nvme discovery isn't 
in-kernel thus has a relationship to the boot process.


> 
>> +static void nvme_fc_discovery_unwind(struct list_head *lheadp)
>> +{
>> +	unsigned long flags;
>> +	struct nvme_fc_lport *lport;
>> +	struct nvme_fc_rport *rport, *tmp_rport;
>> +
>> +	list_for_each_entry_safe(rport, tmp_rport,
>> +				 lheadp, disc_list) {
>> +		spin_lock_irqsave(&nvme_fc_lock, flags);
>> +		list_del_init(&rport->disc_list);
>> +		spin_unlock_irqrestore(&nvme_fc_lock, flags);
> 
> Without the lock taken around the list iteration this is racy.
> 

how so ?

this list was built up ahead of time solely for this routine, gets are 
done on all objects as they were added to the list, the list isn't 
changed except for deleting elements from the list by this routine, and 
a port can't get on this list twice. I don't see the race.

-- james
