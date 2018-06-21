From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Jun 2018 08:45:39 -0700
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <873b1ec2-50a9-1660-2550-c4e539c2413d@kernel.dk>
References: <20180620204310.GA24840@localhost.localdomain>
 <34e64832-c345-3a70-401f-1915b5bb4af1@kernel.dk>
 <20180620223035.GA25196@localhost.localdomain>
 <7b6f885f-f605-1bfd-7a7e-2fce8cbde6c2@kernel.dk>
 <20180621071056.GB21304@infradead.org>
 <dc92becd-403d-9c15-e5bb-5e0c3b5d8a8c@kernel.dk>
 <20180621150139.GA22804@infradead.org>
 <cb33de73-6b03-d4a8-ca73-dc094f83f742@kernel.dk>
 <20180621152456.GB29947@infradead.org>
 <873b1ec2-50a9-1660-2550-c4e539c2413d@kernel.dk>
Message-ID: <20180621154539.GA30025@infradead.org>

On Thu, Jun 21, 2018@09:34:02AM -0600, Jens Axboe wrote:
> Oh, I'm totally fine with that, no rush outside of just wanting to
> ensure it ends up in 4.18. But there's plenty of time for that.
> 
> Below is cleaner I think, keeping it all in pci.c and fabrics should
> just work. I'll test...

Ok, this actually looks harmless enough that with successfull testing
and an ack from Keith we could queue it up this week..
