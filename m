From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 15 Jan 2019 09:22:45 -0700
Subject: [PATCH] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
In-Reply-To: <20190115131140.GB28672@lst.de>
References: <20190103013106.26452-1-ming.lei@redhat.com>
 <20190114232338.GE33971@google.com> <20190115131140.GB28672@lst.de>
Message-ID: <05cb9e71-e455-a717-c64c-b5242ec38bad@kernel.dk>

On 1/15/19 6:11 AM, Christoph Hellwig wrote:
> On Mon, Jan 14, 2019@05:23:39PM -0600, Bjorn Helgaas wrote:
>> Applied to pci/msi for v5.1, thanks!
>>
>> If this is something that should be in v5.0, let me know and include the
>> justification, e.g., something we already merged for v5.0 or regression
>> info, etc, and a Fixes: line, and I'll move it to for-linus.
> 
> I'd be tempted to queues this up for 5.0.  Ming, what is your position?

I think we should - the API was introduced in this series, I think there's
little (to no) reason NOT to fix it for 5.0.

-- 
Jens Axboe
