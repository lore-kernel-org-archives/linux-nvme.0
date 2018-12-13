From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Dec 2018 09:27:32 +0100
Subject: [PATCH v2 2/6] nvme-core: allow __nvme_submit_sync_cmd to poll
In-Reply-To: <20181213063819.13614-3-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-3-sagi@grimberg.me>
Message-ID: <20181213082732.GB869@lst.de>

On Wed, Dec 12, 2018@10:38:14PM -0800, Sagi Grimberg wrote:
> Pass poll bool to indicate that we need it to poll. This prepares us for
> polling support in nvmf since connect is an I/O that will be queued
> and has to be polled in order to complete.

I hate these bool parameters.  Maybe we just need a blk_execute_rq_flags
that instead of the at_head paramter takes a flags paramter.  I guess
for now this is ok, but I don't really like it:

Reviewed-by: Christoph Hellwig <hch at lst.de>
