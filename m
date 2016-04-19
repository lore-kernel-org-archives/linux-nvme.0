From: hch@lst.de (Christoph Hellwig)
Date: Tue, 19 Apr 2016 20:37:00 +0200
Subject: [PATCH 2/5] nvme: introduce a controller state machine
In-Reply-To: <57167A68.5050206@grimberg.me>
References: <1460982893-11315-1-git-send-email-hch@lst.de>
 <1460982893-11315-3-git-send-email-hch@lst.de> <5715294A.3020309@grimberg.me>
 <20160418201710.GA4921@lst.de> <571543EA.6080700@grimberg.me>
 <20160419182545.GA989@lst.de> <57167A68.5050206@grimberg.me>
Message-ID: <20160419183700.GA1211@lst.de>

On Tue, Apr 19, 2016@09:35:20PM +0300, Sagi Grimberg wrote:
>> Let's allocate states on an as needed basis and avoid that new
>> state for now.
>
> Didn't mean a new state, just a transition to NVME_CTRL_DELETING
> if nvme_reset_work fails...

Oh, we can't actually do that - for PCIe deleting is only set
for calls from the PCI ->remove callback, which we'll invoke a
little later through the driver model from the workqueue we just
kicked off.
