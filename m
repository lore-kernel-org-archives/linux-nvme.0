From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Fri, 2 Mar 2018 11:11:22 +0800
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
In-Reply-To: <20180301151544.GA17676@localhost.localdomain>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
 <ddfc2ab4-1a51-c488-25e8-bc434edf8aba@grimberg.me>
 <66e4ad3e-4019-13ec-94c0-e168cc1d95b4@oracle.com>
 <20180301151544.GA17676@localhost.localdomain>
Message-ID: <b2ec4cb3-5125-3fce-4b6d-f483b75d0b2e@oracle.com>

Hi Keith

Thanks for your kindly directive and precious time for this.

On 03/01/2018 11:15 PM, Keith Busch wrote:
> On Thu, Mar 01, 2018@06:05:53PM +0800, jianchao.wang wrote:
>> When the adminq is free, ioq0 irq completion path has to invoke nvme_irq twice, one for itself,
>> one for adminq completion irq action.
> 
> Let's be a little more careful on the terminology when referring to spec
> defined features: there is no such thing as "ioq0". The IO queues start
> at 1. The admin queue is the '0' index queue.

Yes, indeed, sorry for my bad description.

>> We are trying to save every cpu cycle across the nvme host path, why we waste nvme_irq cycles here.
>> If we have enough vectors, we could allocate another irq vector for adminq to avoid this.
> 
> Please understand the _overwhelming_ majority of time spent for IRQ
> handling is the context switches. There's a reason you're not able to
> measure a perf difference between IOQ1 and IOQ2: the number of CPU cycles
> to chain a second action is negligible.
> 

Yes, indeed

Sincerely
Jianchao
