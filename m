From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 9 Nov 2017 13:37:43 +0200
Subject: [PATCH 3/5] nvme: track shared namespaces
In-Reply-To: <20171102183034.9320-4-hch@lst.de>
References: <20171102183034.9320-1-hch@lst.de>
 <20171102183034.9320-4-hch@lst.de>
Message-ID: <ddc19090-b69b-ffa1-fd85-497b410b2b94@grimberg.me>


> To allow lockless path lookup the list of nvme_ns structures per
> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
> structure through call_srcu.

Can you remind me why isn't rcu sufficient? Can looking up a
path (ns from head->list) block?
