From: gpiccoli@canonical.com (Guilherme G. Piccoli)
Date: Wed, 14 Aug 2019 15:29:17 -0300
Subject: [PATCH] nvme: Use first ctrl->instance id as subsystem id
In-Reply-To: <20190814162754.GB3256@localhost.localdomain>
References: <20190814142836.2322-1-gpiccoli@canonical.com>
 <20190814160640.GA3256@localhost.localdomain>
 <abfc4bd0-f4f0-5655-81ee-ec32d3516f35@canonical.com>
 <20190814162754.GB3256@localhost.localdomain>
Message-ID: <b5b471cc-8935-cf96-d55a-a7dc731cb0d6@canonical.com>

On 14/08/2019 13:27, Keith Busch wrote:
> On Wed, Aug 14, 2019@09:18:22AM -0700, Guilherme G. Piccoli wrote:
>> [...]If you can give a rough example I appreciate.
> 
> Sure, start with nvme subsystem A, with host connected to to
> controllers, X and Y.
> 
>  ctrl X gets instance 0, which you assign to the newly discovered
>  subsytem
> 
>  ctrl Y gets instance 1
> 
>  disconnect ctrl X, which releases instance 0 back to the allocator
> 

Thanks a lot for the example Keith! This is the point I missed,
returning the id back to allocator. If we happen to have some IDA in
kernel without this property, my idea could work!

>  connect to a new ctrl Z in new subsystem B: ctrl Z gets the first
>  available instance, which is now 0, and you assign that name to the new
>  susbystem, colliding with the sysfs nvme-subsys entries we've created
>  for subsys A, as well as any namespaces.
>  
>> But given the above statement is a fact, what do you think of trying the
>> ctrl->instance first and in case we have duplicity, fallback to
>> subsystem ID allocator?
> 
> At the point we assign the subsystem identifier, we're locked into using
> that for the namespace names, which may be discovered long before we're
> aware the host has multiple connections to the same subsystem.
> 
> I think it'd be better to just completely disassociate any notion of
> relationships based on names. The following patch enforces that way of
> thinking:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2019-May/024142.html
> 

Interesting thread, thanks for the pointer. I think no matter what we do
in this front (to disassociate the relation of nvme numbering), it'll
always be confusion, specially since we broke valid assumptions since
nvme day-0. Would it be possible of instead reusing the numbering
positions in the naming, add more fields?
It is a suggestion from my colleague Dan (CCed here), something like:
for non-multipath nvme, keep nvmeC and nvmeCnN (C=controller ida,
N=namespace); for multipath nvme, use nvmeScCnN (S=subsystem ida).

Let me know your thoughts, and thanks again for the prompt response!
Cheers,


Guilherme
