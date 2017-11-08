From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 8 Nov 2017 09:38:33 +0800
Subject: [PATCHv3 2/5] nvme/fc: remove unused "queue_size" field
In-Reply-To: <20171107221314.27822-3-keith.busch@intel.com>
References: <20171107221314.27822-1-keith.busch@intel.com>
 <20171107221314.27822-3-keith.busch@intel.com>
Message-ID: <ff3e3d65-9814-6d36-661c-820c2ed6ef3d@huawei.com>



On 2017/11/8 6:13, Keith Busch wrote:
> This was being saved in a structure, but never used anywhere. The queue
> size is obtained through other means, so there's no reason to duplicate
> this without a user for it.

Reviewed-by: Guan Junxiong <guanjunxiong at huawei.com>
