From: snitzer@redhat.com (Mike Snitzer)
Date: Fri, 29 Dec 2017 15:22:00 -0500
Subject: [for-4.16 PATCH v2 2/5] nvme: use request_queue's failover_rq_fn
 callback for multipath failover
In-Reply-To: <20171229101119.GB25333@lst.de>
References: <20171227032257.8182-1-snitzer@redhat.com>
 <20171227032257.8182-3-snitzer@redhat.com>
 <20171229101119.GB25333@lst.de>
Message-ID: <20171229202200.GB8876@redhat.com>

On Fri, Dec 29 2017 at  5:11am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Independent on any policy question as raised in reply to the previous
> patch:  until the ANA (ALUA equivalent for NVMe) spec has been finalized
> and our code for it has landed there is no way we're going to expose
> anything from this code based as it will be highly in flux.

Please stop hiding behind specs like they are governing this aspect of
Linux's NVMe implementation.

Please just own the need for NVMe to provide DM multipathing
compatibility.

Thanks.
