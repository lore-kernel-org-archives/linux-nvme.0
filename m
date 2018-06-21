From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Jun 2018 08:24:56 -0700
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <cb33de73-6b03-d4a8-ca73-dc094f83f742@kernel.dk>
References: <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
 <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
 <20180620204310.GA24840@localhost.localdomain>
 <34e64832-c345-3a70-401f-1915b5bb4af1@kernel.dk>
 <20180620223035.GA25196@localhost.localdomain>
 <7b6f885f-f605-1bfd-7a7e-2fce8cbde6c2@kernel.dk>
 <20180621071056.GB21304@infradead.org>
 <dc92becd-403d-9c15-e5bb-5e0c3b5d8a8c@kernel.dk>
 <20180621150139.GA22804@infradead.org>
 <cb33de73-6b03-d4a8-ca73-dc094f83f742@kernel.dk>
Message-ID: <20180621152456.GB29947@infradead.org>

On Thu, Jun 21, 2018@09:04:14AM -0600, Jens Axboe wrote:
> > I'll be spending the rest of the day on phone calls, so it'll take
> > some time to do more on this than writing some email, but I'll try
> > to find some time to look into these issues.
> 
> OK sounds good, would be nice to get this hashed out as I think some
> variant of this should go into 4.18.

Fine with me, but I'd rather not rush it out this week to give us
a little more time for details and aim for merging it to 4.18 next
week.
