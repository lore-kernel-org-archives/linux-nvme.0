From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 27 Dec 2017 23:01:48 +0200
Subject: [PATCH 2/3] nvme/pci: Remove cq_vector check in IO path
In-Reply-To: <95c8319b-3e01-07b5-88a8-864c5a8f60a5@grimberg.me>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-3-keith.busch@intel.com>
 <95c8319b-3e01-07b5-88a8-864c5a8f60a5@grimberg.me>
Message-ID: <33f024c8-b4be-c8cb-decb-f36eb68fb99a@grimberg.me>


> Awesome!
> 
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

Wait, aren't we unquiesce queues also in nvme_dev_disable?

Doesn't that rely that the queues are suspended and queue_rq
will fail there?
