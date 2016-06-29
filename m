From: krisman@linux.vnet.ibm.com (Gabriel Krisman Bertazi)
Date: Wed, 29 Jun 2016 01:17:35 -0300
Subject: [PATCH 2/2] [RFC] nvme: enable asynchronous events notification
 by default
In-Reply-To: <20160628151137.GA8607@localhost.localdomain> (Keith Busch's
 message of "Tue, 28 Jun 2016 11:11:39 -0400")
References: <1466184075-10471-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1466184075-10471-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <57679355.6000303@gmail.com> <576821E9.2060009@linux.vnet.ibm.com>
 <20160620202135.GG12936@localhost.localdomain>
 <20160624081726.GA13596@infradead.org>
 <20160628151137.GA8607@localhost.localdomain>
Message-ID: <87r3bgsk68.fsf@linux.vnet.ibm.com>

Keith Busch <keith.busch at intel.com> writes:

> On Fri, Jun 24, 2016@01:17:26AM -0700, Christoph Hellwig wrote:
>> Yes, I'm not too excited about handling the AERs in kernel space,
>> having a userspace daemon to listen for them would generally be more
>> useful.
>
> How do daemons typically want to be notified of an event like this? I'm
> thinking sysfs_notify or maybe a KOBJ_CHANGE uevent. I don't know, this
> is unfamiliar territory to me.

For IPR (IBM Hardware RAID SCSI controller) we use KOBJ_CHANGE events
for a very similar situation, in which the driver signals a userspace
daemon, which goes over a sysfs attribute to collect adapter data dumps.

I'm also working on another async notifications mechanism for IPR,
similar to what is supported by nvme, in which I plan to use the same
uevent interface for userspace notifications.

-- 
Gabriel Krisman Bertazi
