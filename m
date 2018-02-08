From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Feb 2018 08:59:43 -0700
Subject: [PATCH 2/2] nvme: Don't use a stack buffer for keep-alive command
In-Reply-To: <20180115084240.GA32313@lst.de>
References: <20180111213815.2107-1-roland@kernel.org>
 <76436c6a-5dee-b174-3b39-2735f8dc3a05@grimberg.me>
 <20180115084240.GA32313@lst.de>
Message-ID: <20180208155943.GB4906@localhost.localdomain>

On Mon, Jan 15, 2018@09:42:40AM +0100, Christoph Hellwig wrote:
> On Sun, Jan 14, 2018@11:31:40AM +0200, Sagi Grimberg wrote:
> > Thanks Roland,
> >
> > Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> 
> I think we'll need to fix this properly and embedd the struct nvme_command
> into struct nvme_request.  In the end any command could get an error
> without DNR, and then we'd have a stale SQE on the stack.

We needn't worry about the DNR case since driver allocated commands are
flagged "REQ_FAILFAST_DRIVER" and are never retried.

Allocating the full 64-byte NVMe command for each request seems a bit
excessive. Since it only really applies to async driver commands, and
there are so few of those as it is, I'm okay with having special cases
for these as Roland suggests. Sound okay?
