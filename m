From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Fri, 2 Mar 2018 11:18:47 +0800
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
In-Reply-To: <20180228164726.GB16536@lst.de>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
Message-ID: <fed4d1b1-6d55-b131-f0e1-ccb8262dea18@oracle.com>

Hi Christoph

Thanks for your kindly response and directive

On 03/01/2018 12:47 AM, Christoph Hellwig wrote:
> Note that we originally allocates irqs this way, and Keith changed
> it a while ago for good reasons.  So I'd really like to see good
> reasons for moving away from this, and some heuristics to figure
> out which way to use.  E.g. if the device supports more irqs than
> I/O queues your scheme might always be fine.

maybe we could add a logic that when get enough irq vectors, assign
separate irq vector to adminq, otherwise sharing.

Sincerely
Jianchao
