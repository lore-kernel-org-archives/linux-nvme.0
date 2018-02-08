From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Feb 2018 18:02:04 +0200
Subject: [PATCH 2/2] nvme: Don't use a stack buffer for keep-alive command
In-Reply-To: <20180208155943.GB4906@localhost.localdomain>
References: <20180111213815.2107-1-roland@kernel.org>
 <76436c6a-5dee-b174-3b39-2735f8dc3a05@grimberg.me>
 <20180115084240.GA32313@lst.de> <20180208155943.GB4906@localhost.localdomain>
Message-ID: <38ae419b-1c41-37e7-46a5-3156802f6744@grimberg.me>


> We needn't worry about the DNR case since driver allocated commands are
> flagged "REQ_FAILFAST_DRIVER" and are never retried.

Yea.

> Allocating the full 64-byte NVMe command for each request seems a bit
> excessive.

Why?

> Since it only really applies to async driver commands, and
> there are so few of those as it is, I'm okay with having special cases
> for these as Roland suggests. Sound okay?

I'm fine with fixing this locally, btw isn't this exact same stale sqe
happen in pci's nvme_delete_queue?
