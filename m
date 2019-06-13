From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 13 Jun 2019 10:57:18 -0700
Subject: [PATCH v2 3/3] nvme: Set physical block size and optimal I/O size
 according to NVMe 1.4
In-Reply-To: <yq15zpa2que.fsf@oracle.com>
References: <20190610210612.103952-1-bvanassche@acm.org>
 <20190610210612.103952-4-bvanassche@acm.org> <yq15zpa2que.fsf@oracle.com>
Message-ID: <fcd3b41c-38b9-4865-05c0-2f96c9382ea5@acm.org>

On 6/12/19 6:53 PM, Martin K. Petersen wrote:
> 
> Bart,
> 
>> +	nawupf = (1 + ns->ctrl->subsys->awupf) * bs;
>> +	if (id->nsfeat & (1 << 1))
>> +		nawupf = (1 + id->nawupf) * bs;
> 
> This tripped me up a bit. I would have preferred an else statement and
> maybe a clarifying comment to make it obvious whether the value comes
> from the controller or the namespace.
> 
> Also, unlike awupf, nawupf is not a 0-based value (0 means "use awupf"
> and not 1 logical block).

Hi Martin,

I agree that NAWUPF == 0 means that AWUPF should be used instead. But
are you sure that NAWUPF is not 0's-based? From version 1.4 of the NVMe
specification:

Namespace Atomic Write Unit Power Fail (NAWUPF): This field indicates
the namespace specific size of the write operation guaranteed to be
written atomically to the NVM during a power fail or error condition.
A value of 0h indicates that the size for this namespace is the same
size as that reported in the AWUPF field of the Identify Controller data
structure. All other values specify a size in terms of logical blocks
using the same encoding as the AWUPF field. Refer to section 6.4.
[ ... ]
Atomic Write Unit Power Fail (AWUPF): [ ... ] This field is specified in
logical blocks and is a 0?s based value. The AWUPF value shall be less
than or equal to the AWUN value.

Since the spec says that NAWUPF and AWUPF use the same encoding, does
that mean that NAWUPF is also 0's based?

Thanks,

Bart.
