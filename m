From: gpiccoli@canonical.com (Guilherme G. Piccoli)
Date: Thu, 15 Aug 2019 10:01:43 -0300
Subject: [PATCH] nvme: Use first ctrl->instance id as subsystem id
In-Reply-To: <20190814190814.GC3256@localhost.localdomain>
References: <20190814142836.2322-1-gpiccoli@canonical.com>
 <20190814160640.GA3256@localhost.localdomain>
 <abfc4bd0-f4f0-5655-81ee-ec32d3516f35@canonical.com>
 <20190814162754.GB3256@localhost.localdomain>
 <b5b471cc-8935-cf96-d55a-a7dc731cb0d6@canonical.com>
 <20190814190814.GC3256@localhost.localdomain>
Message-ID: <9edcb6b3-806c-a422-8d44-c1ab49ce0b57@canonical.com>

On 14/08/2019 16:08, Keith Busch wrote:
> On Wed, Aug 14, 2019@11:29:17AM -0700, Guilherme G. Piccoli wrote:
>> It is a suggestion from my colleague Dan (CCed here), something like:
>> for non-multipath nvme, keep nvmeC and nvmeCnN (C=controller ida,
>> N=namespace); for multipath nvme, use nvmeScCnN (S=subsystem ida).
> 
> This will inevitably lead to collisions. The existing naming scheme was
> selected specifically to avoid that problem.
> 

Thanks again for the discussion Keith! So, I guess the way to go is
really the kernel parameter in case users want to fallback to the old
numbering (and only if they're not using multipath).

Cheers,


Guilherme
