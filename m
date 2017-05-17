From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 17 May 2017 02:02:02 -0700
Subject: [PATCH v4, under testing] nvme-rdma: support devices with queue
 size < 32
In-Reply-To: <310709514.10440651.1493902200194.JavaMail.zimbra@kalray.eu>
References: <79901165.5342369.1493805915415.JavaMail.zimbra@kalray.eu>
 <823aa3f0-685f-4569-11d6-238cc4f0b126@grimberg.me>
 <780938034.8003164.1493824767084.JavaMail.zimbra@kalray.eu>
 <20170503155316.GA14334@obsidianresearch.com>
 <1493827096.3901.4.camel@sandisk.com>
 <77ada146-67eb-9dce-d252-6ac630c9a1e8@grimberg.me>
 <20170503162708.GO22833@mtr-leonro.local>
 <1493829456.3901.13.camel@sandisk.com>
 <310709514.10440651.1493902200194.JavaMail.zimbra@kalray.eu>
Message-ID: <20170517090202.GA23880@infradead.org>

> This looks like a good idea to me. Then the division can change into
> an AND. I'll come back with another version soon.

Did you get a chance to look at this?  I'm tempted to just merge v2
with the division in it and leave any fixing up for the time we move this
guestimate into the rdma core..
