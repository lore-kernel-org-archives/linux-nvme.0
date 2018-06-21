From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Jun 2018 10:54:13 -0700
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <93716224-d6a5-77e9-9865-7cf22d48b0da@kernel.dk>
References: <20180621071056.GB21304@infradead.org>
 <dc92becd-403d-9c15-e5bb-5e0c3b5d8a8c@kernel.dk>
 <20180621150139.GA22804@infradead.org>
 <cb33de73-6b03-d4a8-ca73-dc094f83f742@kernel.dk>
 <20180621152456.GB29947@infradead.org>
 <873b1ec2-50a9-1660-2550-c4e539c2413d@kernel.dk>
 <20180621154539.GA30025@infradead.org>
 <697a18cb-43c7-c768-6d17-6eb8123f26ff@kernel.dk>
 <20180621162725.GA26993@localhost.localdomain>
 <93716224-d6a5-77e9-9865-7cf22d48b0da@kernel.dk>
Message-ID: <20180621175413.GA23315@infradead.org>

On Thu, Jun 21, 2018@11:20:05AM -0600, Jens Axboe wrote:
> Thanks Keith - Christoph/Keith, where do you want to queue this up?
> I can do it directly, or we can do it through the nvme tree.

I've queued it up in the nvme tree already.
