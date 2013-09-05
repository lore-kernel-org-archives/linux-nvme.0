From: keith.busch@intel.com (Keith Busch)
Date: Thu, 5 Sep 2013 17:23:33 -0600 (MDT)
Subject: [PATCH 1/9] NVMe: Merge issue on character device bring-up
In-Reply-To: <8A51900D08212F40B3DE22453052F698EE5F77@wdscexmb02.sc.wdc.com>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
 <1378413915-16667-2-git-send-email-keith.busch@intel.com>
 <8A51900D08212F40B3DE22453052F698EE5F28@wdscexmb02.sc.wdc.com>
 <alpine.LRH.2.03.1309051617070.1857@AMR>
 <8A51900D08212F40B3DE22453052F698EE5F77@wdscexmb02.sc.wdc.com>
Message-ID: <alpine.LRH.2.03.1309051651040.1857@AMR>

On Thu, 5 Sep 2013, John Utz wrote:
> OH HECK. I am on outlook, so I have no quoting mechanism. I gotta come up with a different MUA that speaks exchange.....
>
> Grrrr.....
>
> Comments crudely inserted inline

Sometimes I have no choice but to use outlook so I feel your pain. :)

Depending on which version you're using, there should be something like
"Options" -> "Mail", and you set "When replying to a message" with
"Prefix each line of original message with". I set that option to '>'
like how my linux email client does replies.

> On Thu, 5 Sep 2013, John Utz wrote:
>> What will happen when you go to create_cdev: if the character device already exists?
>>
>> Harmless? Or Not?
>>
>> Just curious.
>>
>> Tnx!
>>
>> johnu
>
> Hi John,
>
> The character device is created at the end of this pci_driver's 'probe'
> routine and deleted on 'remove', so I don't think it is possible for the
> character device to exist prior to the 'goto', right?
>
> JLUIII-> If the character device has been created and then the driver dies
> prior to the remove executing, you would be faced with an existing chardev
> when you restarted the driver.

I'm not sure how to make that kind of situation happen without creating
a more catastrophic problem. Can a pci driver be unloaded without all
the devices the driver claims be removed and still have a sane system?
The nvme_dev structure encapsulating the misc_dev it is associated with no
longer exists, right? Accessing the old character device handle probably
causes a page fault or worse.

Anyway, I tried to force the situation by skipping the misc_deregister
in the 'remove' function; it's not a good idea to leave the misc_dev up
and then reload the driver. You'll get "sysfs: cannot create duplicate
filename" and "kobject_add_internal failed with -EEXIST" warnings. Opening
the character device causes a "BUG: unable to handle kernel paging
request at ..." in this scenario.
