From: keith.busch@intel.com (Keith Busch)
Date: Tue, 12 Mar 2013 16:13:54 -0600 (MDT)
Subject: [PATCH 3/4] NVMe: End-to-end data protection
In-Reply-To: <OF4D215762.7078BEB8-ON86257B2C.004F99F8-86257B2C.00538982@hgst.com>
References: <OF4D215762.7078BEB8-ON86257B2C.004F99F8-86257B2C.00538982@hgst.com>
Message-ID: <alpine.LRH.2.03.1303121559570.17928@localhost.localdom>

That sounds pretty good. I think at some point the integrity extensions
will be publicly defined in the kernel so the driver won't have to
define/copy it. Until then though, I think we have to reject namespaces
with formats the driver can't handle, otherwise we could corrupt
data/memory.

The DIF meta-data generate and verify functions don't specify the size
meta-data per sector, so we can't handle anything that isn't a DIF tuple
size of 8 bytes. I suppose we could allow namespaces with separate
meta-data when protection information is disabled, but it wouldn't be
used for anything at this point.

A block driver can't handle data interleaved with meta-data if the
controller doesn't automatically generate/stripe on writes/reads. That
requires protection information is enabled and meta-data size is 8 bytes.

On Tue, 12 Mar 2013, David.Darrington@hgst.com wrote:

> I first noticed the kernels CONFIG_BLK_DEV_INTEGRITY option when I was
> trying to understand end-to-end protection and meta-data. When I saw the
> 'struct bio_integrity_payload *' in the definition of the strucure, I
> figured that hte block layer (or perhaps above) could setup a
> bio_integrity_payload. In which case, the bio's received by the driver
> would already include bips and woudl simply write the meta-data to the
> drive.
>
> From Documentation/block/data-integrity.txt in the kernel tree:
>
> "...
> The current implementation allows the block layer to automatically
> generate the protection information for any I/O.  Eventually the intent is
> to move the integrity metadata calculation to userspace for user data.
> Metadata and other I/O that originates within the kernel will still use
> the automatic generation interface.
> ...
> "
>
>
>
>
>
>
> "Linux-nvme" <linux-nvme-bounces at lists.infradead.org> wrote on 03/11/2013
> 05:32:56 PM:
>
>> On Mon, 11 Mar 2013, David.Darrington@hgst.com wrote:
>>
>>> Is this correct:
>>>> +/*
>>>> + * Valid formats must have either no meta-data, or meta-data equal
> to
>>> the DIF
>>>> + * size and formatted for protection information. The driver has no
> use
>>> for
>>>> + * meta-data for any other purpose.
>>>> + */
>>>
>>> This patch fails nvme_alloc_ns() if there is meta data, but data
>>> protection is not enabled.
>>>
>>> Are there valid use cases where the driver passes through the
> meta-data to
>>> and from the controller, without generating  or verifying? Is it
> possible
>>> for applications to provided there own meta-data?
>>
>> Other than the integrity extensions, I don't think there is anything in
>> a bio request that a block driver can use to set the command meta-data
>> pointer, whether an application wants to provide it or otherwise. Please
>> let me know if I've missed something, though.
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://merlin.infradead.org/mailman/listinfo/linux-nvme
>
>
