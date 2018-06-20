From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 20 Jun 2018 16:30:18 -0600
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <20180620223035.GA25196@localhost.localdomain>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
 <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
 <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
 <20180620204310.GA24840@localhost.localdomain>
 <34e64832-c345-3a70-401f-1915b5bb4af1@kernel.dk>
 <20180620223035.GA25196@localhost.localdomain>
Message-ID: <7b6f885f-f605-1bfd-7a7e-2fce8cbde6c2@kernel.dk>

On 6/20/18 4:30 PM, Keith Busch wrote:
> On Wed, Jun 20, 2018@02:54:26PM -0600, Jens Axboe wrote:
>> I should also mention that this came out of a real life hang
>> on a production box. I suppose we haven't seen a lot of these
>> since a lot of nvme controllers have a hw limit of 128k, but
>> the ones that don't can pretty easily hit the hang of needing
>> 2^2 pages and failing miserably forever.
> 
> I can certainly believe that. I'm totally fine with setting a smaller
> upper bound on the IO size. There really isn't a meaningful bandwidth
> advantage to larger transfers on NVMe PCIe once you get over 256k anyway.

Right. We can retain most of the maximum size there, but the segments
must go down. But functionally it's the same, and we're well within
the region that should be plenty fast.

> Since you're making the change to core, let's wait to hear if there are
> any concerns on the fabrics front.

If the fabrics folks have concerns, we could make it dependent on
it being a pci device. That's the case I care about anyway, and the
one that's currently breaking for me.

-- 
Jens Axboe
