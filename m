From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 1 Mar 2018 18:05:53 +0800
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
In-Reply-To: <ddfc2ab4-1a51-c488-25e8-bc434edf8aba@grimberg.me>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
 <ddfc2ab4-1a51-c488-25e8-bc434edf8aba@grimberg.me>
Message-ID: <66e4ad3e-4019-13ec-94c0-e168cc1d95b4@oracle.com>

Hi sagi

Thanks for your kindly response.

On 03/01/2018 05:28 PM, Sagi Grimberg wrote:
> 
>> Note that we originally allocates irqs this way, and Keith changed
>> it a while ago for good reasons.? So I'd really like to see good
>> reasons for moving away from this, and some heuristics to figure
>> out which way to use.? E.g. if the device supports more irqs than
>> I/O queues your scheme might always be fine.
> 
> I still don't understand what this buys us in practice. Seems redundant
> to allocate another vector without any (even marginal) difference.
> 

When the adminq is free, ioq0 irq completion path has to invoke nvme_irq twice, one for itself,
one for adminq completion irq action.
We are trying to save every cpu cycle across the nvme host path, why we waste nvme_irq cycles here.
If we have enough vectors, we could allocate another irq vector for adminq to avoid this.

Sincerely
Jianchao 
