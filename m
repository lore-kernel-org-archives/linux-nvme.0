From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 8 Nov 2017 09:37:34 +0800
Subject: [PATCHv3 1/5] nvme: Centralize AEN defines
In-Reply-To: <20171107221314.27822-2-keith.busch@intel.com>
References: <20171107221314.27822-1-keith.busch@intel.com>
 <20171107221314.27822-2-keith.busch@intel.com>
Message-ID: <f352114e-5421-7d21-0374-3185f6cde764@huawei.com>


Reviewed-by: Guan Junxiong <guanjunxiong at huawei.com>

On 2017/11/8 6:13, Keith Busch wrote:
> All the transports were unnecessarilly duplicating the AEN request
> accounting. This patch defines everything in one place.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
