From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 8 Nov 2017 09:39:18 +0800
Subject: [PATCHv3 4/5] nvme: Unexport starting async event work
In-Reply-To: <20171107221314.27822-5-keith.busch@intel.com>
References: <20171107221314.27822-1-keith.busch@intel.com>
 <20171107221314.27822-5-keith.busch@intel.com>
Message-ID: <b8c30284-5311-8d91-e694-9bdd16230bc5@huawei.com>


Reviewed-by: Guan Junxiong <guanjunxiong at huawei.com>

On 2017/11/8 6:13, Keith Busch wrote:
> Async event work is for core use only and should not be called directly
> from drivers.
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
