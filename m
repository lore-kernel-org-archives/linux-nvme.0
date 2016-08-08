From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Aug 2016 09:05:34 +0200
Subject: [PATCH 1/2] nvme-rdma: tell fabrics layer admin queue depth
In-Reply-To: <970b69cc-b439-63ac-b26e-90f3581b49de@grimberg.me>
References: <1470444851-7459-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470444851-7459-2-git-send-email-james_p_freyensee@linux.intel.com>
 <970b69cc-b439-63ac-b26e-90f3581b49de@grimberg.me>
Message-ID: <20160808070534.GA12902@lst.de>

On Sun, Aug 07, 2016@10:20:38AM +0300, Sagi Grimberg wrote:
> No need for admin_sqsize member, its always set to NVMF_AQ_DEPTH-1,
> just use that...

Agreed.
