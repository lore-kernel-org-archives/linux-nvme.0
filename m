From: daniel.verkamp@intel.com (Verkamp, Daniel)
Date: Mon, 15 Aug 2016 15:55:48 +0000
Subject: [PATCH v1 1/5] fabrics: define admin sqsize min default, per spec
In-Reply-To: <1471046692-15978-2-git-send-email-james_p_freyensee@linux.intel.com>
References: <1471046692-15978-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1471046692-15978-2-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1471276545.3070.3.camel@intel.com>

On Fri, 2016-08-12@17:04 -0700, Jay Freyensee wrote:
> Upon admin queue connect(), the rdma qp was being
> set based on NVMF_AQ_DEPTH.??However, the fabrics layer was
> using the sqsize field value set for I/O queues for the admin
> queue, which through the nvme layer and rdma layer off-whack:

Minor grammar nit: "through" -> "threw".

Otherwise looks OK to me (given the following patches that fix up the
non-AQ case are also applied).

Thanks,
-- Daniel
