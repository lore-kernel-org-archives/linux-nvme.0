From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Wed, 5 Apr 2017 17:01:15 -0300
Subject: [PATCH] nvme: avoid NULL pointer dereference in error recovery
 path
In-Reply-To: <20170405194357.GA11705@lst.de>
References: <20170405194037.1019-1-gpiccoli@linux.vnet.ibm.com>
 <20170405194357.GA11705@lst.de>
Message-ID: <dbabb032-9d5f-9e92-b3c8-600e3e2e3719@linux.vnet.ibm.com>

On 04/05/2017 04:43 PM, Christoph Hellwig wrote:
> On Wed, Apr 05, 2017@04:40:37PM -0300, Guilherme G. Piccoli wrote:
>> It's possible that driver fails to recover from a PCI error and the
>> PCI core (or arch PCI specifics, like EEH in PowerPC) starts a process
>> of device removal. While this removal process is happening, if another
>> PCI error is triggered, we might have a NULL address for
>> "struct *nvme_dev", pointed by "pci_dev *driver_data" - for example this
>> happens if nvme_remove() already have set that pci_dev struct's field
>> to NULL.
>>
>> In this case, the driver error handler functions will dereferece a NULL
>> pointer, causing a kernel oops. This patch checks for NULL pointer on
>> error handlers and in case "driver_data" points to NULL, it aborts the
>> error recovery path and return a fail error value to PCI core.
> 
> I think this needs to be fixed at a higher level, that is the PCI
> core.  Once you have the callbacks run in parallel a simple null check
> isn't going to fix this but every single access to the structure
> is a possible use after free.
> 

Christoph, your point makes sense.
It's possible (I guess not expected, but at least feasible) to have a
2nd PCI error being triggered while a 1st error is in
recovery/removal-on-failure process, after the slot_reset() step of the
1st error specifically.

Many drivers around do these NULL pointer checks - solving this in EEH
core would mean having a way to every driver communicate the error
recovery process is completed and the next error could be "issued".
Like PCI core would "stack" the next error.

But...what if the device has really a severe issue in its slot, and it's
unable to recover at all? So, it'll trigger another error and naturally
the callbacks are going to be called, expecting to drop recoveries and
signal to PCI core something went real bad.

So, I believe these NULL checks will avoid at least this dereference
case and enforce signaling to PCI core to remove the device if this
"racy" error sequence happens after a device recovery failure is in process.

If you see another paths that multiple PCI errors happening in sequence
might cause trouble to nvme driver that I'm not aware, please let me
know and we can think a better solution. Also, if you have ideas on how
to address this in a more elegant/generic way, let me know too, I really
appreciate. Guess this patch is the most simplistic approach, at least
the one I could think of.

Thanks for the quick review!
Cheers,


Guilherme
