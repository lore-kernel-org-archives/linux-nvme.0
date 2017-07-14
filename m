From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Fri, 14 Jul 2017 09:50:20 -0300
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <20170713212955.GD14716@localhost.localdomain>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
 <20170707181436.GC24427@lst.de>
 <20170713212955.GD14716@localhost.localdomain>
Message-ID: <03e07267-4ae0-24c7-a3ce-10e55debd4a8@linux.vnet.ibm.com>

On 07/13/2017 06:29 PM, Keith Busch wrote:
> On Fri, Jul 07, 2017@08:14:36PM +0200, Christoph Hellwig wrote:
>>
>> Can we have an nvme-aen helper that gets invoked by a trivial udev rule,
>> which would read a config file for policy?
> 
> Sure, I can work on an aen helper for udev. Do you know if there is an
> existing project for these sorts of things that would take this feature?

We were planning to implement this here on LTC, and some ideas in
discussion is whether such tool could be integrated to nvme-cli, like a
"nvmed" tool, a daemon to handle the events. Advantages of the daemon
are possible implementation of RAS features like trigger actions based
on adapter's error, etc.

Do you think this kind of tool is interesting? Suggestions on this topic
are greatly appreciated. One of our concerns is that AEN events still
need to be enabled by the user, not all events are enabled by default.
One such tool would allow friendly configuration on which events user
wants to enable.

Thanks,



Guilherme
