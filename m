From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Dec 2018 16:44:05 +0100
Subject: [PATCH v3 3/6] nvme-core: optionally poll sync commands
In-Reply-To: <20181213213410.9841-4-sagi@grimberg.me>
References: <20181213213410.9841-1-sagi@grimberg.me>
 <20181213213410.9841-4-sagi@grimberg.me>
Message-ID: <20181214154405.GB24417@lst.de>

On Thu, Dec 13, 2018@01:34:07PM -0800, Sagi Grimberg wrote:
> Pass poll bool to indicate that we need it to poll. This prepares us for
> polling support in nvmf since connect is an I/O that will be queued
> and has to be polled in order to complete. If poll is passed,
> we call nvme_execute_rq_polled which sends the requests and polls
> for its completion.

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
