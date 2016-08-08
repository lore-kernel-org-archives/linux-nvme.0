From: daniel.verkamp@intel.com (Verkamp, Daniel)
Date: Mon, 8 Aug 2016 16:08:22 +0000
Subject: [PATCH 2/2] nvme-rdma: sqsize/hsqsize/hrqsize is 0-based val
In-Reply-To: <8bca04d5-8793-5bc3-9a18-4a7f66af40cc@grimberg.me>
References: <1470444851-7459-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470444851-7459-3-git-send-email-james_p_freyensee@linux.intel.com>
 <8bca04d5-8793-5bc3-9a18-4a7f66af40cc@grimberg.me>
Message-ID: <1470672500.40000.20.camel@intel.com>

On Sun, 2016-08-07@10:29 +0300, Sagi Grimberg wrote:
> > 
> > Per NVMe-over-Fabrics 1.0 spec, sqsize is represented as
> > a 0-based value.
> 
> Did we really decide that? The spec actually explicitly says
> that a 0 sqsize will be failed:
> 
> "If the size is 0h or larger than the controller supports, then a
> status value of Connect Invalid Parameters shall be returned."
> 
> And then it says: "This is a 0?s based value"
> 
> Confusing....

I think 0 is disallowed because that would mean the queue size is 1, and
NVMe requires at least a queue size of 2 to be useful at all (one slot
has to be empty to avoid confusion between queue full and queue empty
cases).

-- Daniel
