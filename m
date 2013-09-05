From: John.Utz@wdc.com (John Utz)
Date: Thu, 5 Sep 2013 22:47:36 +0000
Subject: [PATCH 1/9] NVMe: Merge issue on character device bring-up
In-Reply-To: <alpine.LRH.2.03.1309051617070.1857@AMR>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
 <1378413915-16667-2-git-send-email-keith.busch@intel.com>
 <8A51900D08212F40B3DE22453052F698EE5F28@wdscexmb02.sc.wdc.com>
 <alpine.LRH.2.03.1309051617070.1857@AMR>
Message-ID: <8A51900D08212F40B3DE22453052F698EE5F77@wdscexmb02.sc.wdc.com>

OH HECK. I am on outlook, so I have no quoting mechanism. I gotta come up with a different MUA that speaks exchange.....

Grrrr.....

Comments crudely inserted inline

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Thursday, September 5, 2013 3:21 PM
To: John Utz
Cc: Keith Busch; linux-nvme at lists.infradead.org
Subject: RE: [PATCH 1/9] NVMe: Merge issue on character device bring-up

On Thu, 5 Sep 2013, John Utz wrote:
> What will happen when you go to create_cdev: if the character device already exists?
>
> Harmless? Or Not?
>
> Just curious.
>
> Tnx!
>
> johnu

Hi John,

The character device is created at the end of this pci_driver's 'probe'
routine and deleted on 'remove', so I don't think it is possible for the character device to exist prior to the 'goto', right?

JLUIII-> If the character device has been created and then the driver dies prior to the remove executing, you would be faced with an existing chardev when you restarted the driver.

Thanks,
Keith
