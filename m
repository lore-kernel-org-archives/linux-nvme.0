From: keith.busch@intel.com (Keith Busch)
Date: Thu, 5 Sep 2013 16:21:01 -0600 (MDT)
Subject: [PATCH 1/9] NVMe: Merge issue on character device bring-up
In-Reply-To: <8A51900D08212F40B3DE22453052F698EE5F28@wdscexmb02.sc.wdc.com>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
 <1378413915-16667-2-git-send-email-keith.busch@intel.com>
 <8A51900D08212F40B3DE22453052F698EE5F28@wdscexmb02.sc.wdc.com>
Message-ID: <alpine.LRH.2.03.1309051617070.1857@AMR>

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
routine and deleted on 'remove', so I don't think it is possible for
the character device to exist prior to the 'goto', right?

Thanks,
Keith
