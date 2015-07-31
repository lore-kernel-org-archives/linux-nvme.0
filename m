From: mlin@kernel.org (Ming Lin)
Date: Fri, 31 Jul 2015 10:04:28 -0700
Subject: [RFC] Multi level NVMe stack
In-Reply-To: <20150730145222.GA12744@infradead.org>
References: <1438214118.24174.9.camel@ssi>
 <20150730145222.GA12744@infradead.org>
Message-ID: <CAF1ivSaK_G_ukWeEv0c07WG0s2BieA7JPJD_DfzmGpORvj8qWQ@mail.gmail.com>

On Thu, Jul 30, 2015@7:52 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Jul 29, 2015@04:55:18PM -0700, Ming Lin wrote:
>> I'm working on a virtio-nvme driver.
>> NVMe over Fabrics initiator will probably be available some time.
>>
>> I wonder does it make sense to have a multi level NVMe stack(similar as
>> SCSI). So we can re-use the NVMe core code.
>
> Hi Ming,
>
> I've put some work in for abstraction, see the work to submit the
> internal NVMe command through struct request.
>
> Once we actually get other transports we can split main data structures,
> and move the parts sitting above that abstraction out into a separate
> module.
>
> From both looking at the I/O code I'd prefer not to add any abstractions
> in the I/O code for.
>
> I'd suggest you prototype the code without big refactoring first,
> and then compare your implementation against the NVMe virtualization
> extensions from Google and check if it's worth it:
>
> http://lists.infradead.org/pipermail/linux-nvme/2014-July/001076.html

I'll prototype the code.

Thanks.
