From: kbusch@kernel.org (Keith Busch)
Date: Thu, 18 Apr 2019 07:48:21 -0600
Subject: [PATCH] nvme: determine the number of IO queues
In-Reply-To: <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
 <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
 <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
Message-ID: <20190418134820.GA7589@localhost.localdomain>

On Thu, Apr 18, 2019@02:21:57PM +0800, Aaron Ma wrote:
> On 4/18/19 1:33 AM, Maxim Levitsky wrote:
> >>
> >> Maybe its better to add a quirk for the broken device, which needs this?
> 
> Adding quirk only makes the code more complicated.
> This patch doesn't change the default behavior.
> Only handle the NVME error code.

It does change the default behavior. If I have a degraded controller that
can't do IO in a machine with 1000's of CPUs, I have to iterate this
non-standard behavior 1000's of times before the drive is servicable
again. We currenlty figure that out in just a single try.

At least the quirks document *why* the driver is doing non-standard
behavior. We do the IO queue quirks for Macbooks, for example.

But why don't you file a bug report with the device vendor instead? Surely
a firmware fix provides the best possible outcome, and would make this
device work not only in all versions of Linux, but also every standard
compliant driver for any OS.
