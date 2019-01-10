From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 Jan 2019 07:50:08 -0700
Subject: [PATCH] nvme: fix out of bounds access in nvme_cqe_pending
In-Reply-To: <991b5090-adf7-78e1-ae19-0df94566c212@huawei.com>
References: <1546827727-49635-1-git-send-email-yaohongbo@huawei.com>
 <20190109183920.GA22070@lst.de>
 <991b5090-adf7-78e1-ae19-0df94566c212@huawei.com>
Message-ID: <20190110145008.GA21095@localhost.localdomain>

On Wed, Jan 09, 2019@05:54:59PM -0800, Yao HongBo wrote:
> On 1/10/2019 2:39 AM, Christoph Hellwig wrote:
> > On Mon, Jan 07, 2019@10:22:07AM +0800, Hongbo Yao wrote:
> >> There is an out of bounds array access in nvme_cqe_peding().
> >>
> >> When enable irq_thread for nvme interrupt, there is racing between the
> >> nvmeq->cq_head updating and reading.
> > 
> > Just curious: why did you enable this option?  Do you have a workload
> > where it matters?
> 
> Yes, there were a lot of hard interrupts reported when reading the nvme disk,
> the OS can not schedule and result in the soft lockup.so i enabled the irq_thread.

That seems a little unusual. We should be able to handle as many
interrupts as an nvme drive can send.
