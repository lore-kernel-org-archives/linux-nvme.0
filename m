From: aaron.ma@canonical.com (Aaron Ma)
Date: Thu, 18 Apr 2019 22:21:03 +0800
Subject: [PATCH] nvme: determine the number of IO queues
In-Reply-To: <20190418134820.GA7589@localhost.localdomain>
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
 <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
 <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
 <20190418134820.GA7589@localhost.localdomain>
Message-ID: <ddabda2a-b30d-77cc-7b2e-05a6b599cae7@canonical.com>



On 4/18/19 9:48 PM, Keith Busch wrote:
> It does change the default behavior. If I have a degraded controller that
> can't do IO in a machine with 1000's of CPUs, I have to iterate this
> non-standard behavior 1000's of times before the drive is servicable
> again. We currenlty figure that out in just a single try.
> 
> At least the quirks document *why* the driver is doing non-standard
> behavior. We do the IO queue quirks for Macbooks, for example.
> 
> But why don't you file a bug report with the device vendor instead? Surely
> a firmware fix provides the best possible outcome, and would make this
> device work not only in all versions of Linux, but also every standard
> compliant driver for any OS.

I will do it, no v2 for now.

Thanks,
Aaron
