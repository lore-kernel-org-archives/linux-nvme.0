From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 00:37:33 +0300
Subject: [PATCH v3 1/3] nvme-rdma: correctly check for target keyed sgl
 support
In-Reply-To: <8da47cd4-44d5-2229-ef82-26d165dfc245@opengridcomputing.com>
References: <cover.1527618402.git.swise@opengridcomputing.com>
 <fb738c0b251da31747451906630cfd09a5135c7b.1527618402.git.swise@opengridcomputing.com>
 <14063C7AD467DE4B82DEDB5C278E8663B38EE822@FMSMSX108.amr.corp.intel.com>
 <3acbea43-d777-88a5-0059-10275655d545@opengridcomputing.com>
 <8da47cd4-44d5-2229-ef82-26d165dfc245@opengridcomputing.com>
Message-ID: <c180e592-a11c-de09-d094-3ab569289fab@grimberg.me>


>>> I can see that the 2 and 20 are defined for specific things.  Since they are
>>> used in several places (in the next 2 patches), is there any chance these
>>> could be defined bits?
>>>
>>> Mike
>>>
>> That seems reasonable.? I would think these defines could also be shared
>> across the host and target.? Perhaps include/linux/nvme.h?? I see both
>> nvme/host/nvme.h and nvme/target/nvmet.h include linux/nvme.h.? So they
>> could go there.
>>
>> Christoph, what do you think?? It seems like these are either nvme
>> protocol bits or nvme/f protocol bits...
>>
>> Steve.
>>
>>
> 
> It looks like these bits are part of the Identify Controller Data
> Structure, figure 90 in the 1.2.1 spec.? The SGL Support (SGLS) field
> within that struct.?? So I guess it belongs in include/linux/nvme.h?
> But I don't see any of this big structure in that header.
> 

Yea, good idea, though please add the offset type sgl as well.
