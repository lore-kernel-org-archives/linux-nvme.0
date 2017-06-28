From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 28 Jun 2017 12:51:51 -0400
Subject: [PATCH] nvme: Quirks for PM1725 controllers
In-Reply-To: <20170628164449.GA2650@localhost.localdomain> (Keith Busch's
 message of "Wed, 28 Jun 2017 12:44:50 -0400")
References: <20170628022757.32309-1-martin.petersen@oracle.com>
 <f3690fd0-caa7-fb84-3a81-9a90c90f6db4@grimberg.me>
 <20170628164449.GA2650@localhost.localdomain>
Message-ID: <yq1fuekxdg8.fsf@oracle.com>


Keith,

>> and the this is:
>> 
>> 	} else if (dev->ctrl.quirks & NVME_QUIRK_QD_LIMIT_64) {
>> 
>> While its inside the pci driver, I think it would be cleaner to
>> use the quirks mechanism.
>> 
>> Kieth? thoughts?
>
> Yeah, that's better than VID:DID checks. We only get 32 defined quirks
> using driver_data, and while we currently can spare 2 of them for q-depth
> quirks, I was hoping to use these bits more sparingly.

That's fine. I did tinker with quirks for the queue depth at some point
but I think I had problems due to needing to clamp the admin queue depth
as well. I had to shuffle a bunch of stuff and introduce wrappers for
accessing the AQ depth. But with Sagi's recent patch that's no longer
necessary. So most of that churn went away when I rebased yesterday.

Will resend.

-- 
Martin K. Petersen	Oracle Linux Engineering
