From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 18 Aug 2017 00:14:28 -0700
Subject: [RFC PATCH] nvme: always return IRQ_HANDLED
In-Reply-To: <28c04e46-043f-2864-f9c6-d4a76e5e2248@kernel.dk>
References: <06b85884-efb4-e419-4b31-3aa4751bb338@kernel.dk>
 <20170817201526.GA21397@localhost.localdomain>
 <60b6e2b7-86d1-d5c7-66af-e771d17384b8@kernel.dk>
 <20170817202945.GB21397@localhost.localdomain>
 <28c04e46-043f-2864-f9c6-d4a76e5e2248@kernel.dk>
Message-ID: <20170818071428.GA5460@infradead.org>

On Thu, Aug 17, 2017@02:25:27PM -0600, Jens Axboe wrote:
> Yes, that will work. We need to get this into 4.13.

I'll pick it up for the pull request I'm going to send you today.
