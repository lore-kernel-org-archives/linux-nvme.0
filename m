From: hch@lst.de (Christoph Hellwig)
Date: Mon, 15 Jan 2018 09:42:40 +0100
Subject: [PATCH 2/2] nvme: Don't use a stack buffer for keep-alive command
In-Reply-To: <76436c6a-5dee-b174-3b39-2735f8dc3a05@grimberg.me>
References: <20180111213815.2107-1-roland@kernel.org>
 <76436c6a-5dee-b174-3b39-2735f8dc3a05@grimberg.me>
Message-ID: <20180115084240.GA32313@lst.de>

On Sun, Jan 14, 2018@11:31:40AM +0200, Sagi Grimberg wrote:
> Thanks Roland,
>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

I think we'll need to fix this properly and embedd the struct nvme_command
into struct nvme_request.  In the end any command could get an error
without DNR, and then we'd have a stale SQE on the stack.
