From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 11 Mar 2019 11:58:21 +0800
Subject: [PATCH 4/5] nvme: Fail dead namespace's entered requests
In-Reply-To: <20190308174006.5032-4-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-4-keith.busch@intel.com>
Message-ID: <671edb24-d3a7-988e-c1e5-3ba140da5451@oracle.com>

Hi Keith

How about introducing a per hctx queue_rq callback, then install a
separate .queue_rq callback for the dead hctx. Then we just need to
start and complete the request there.

Thanks
Jianchao
