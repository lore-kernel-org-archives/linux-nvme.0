From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 11:11:19 +0100
Subject: [for-4.16 PATCH v2 2/5] nvme: use request_queue's
 failover_rq_fn callback for multipath failover
In-Reply-To: <20171227032257.8182-3-snitzer@redhat.com>
References: <20171227032257.8182-1-snitzer@redhat.com>
 <20171227032257.8182-3-snitzer@redhat.com>
Message-ID: <20171229101119.GB25333@lst.de>

Independent on any policy question as raised in reply to the previous
patch:  until the ANA (ALUA equivalent for NVMe) spec has been finalized
and our code for it has landed there is no way we're going to expose
anything from this code based as it will be highly in flux.
