From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 7 Aug 2016 10:29:08 +0300
Subject: [PATCH 2/2] nvme-rdma: sqsize/hsqsize/hrqsize is 0-based val
In-Reply-To: <1470444851-7459-3-git-send-email-james_p_freyensee@linux.intel.com>
References: <1470444851-7459-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470444851-7459-3-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <8bca04d5-8793-5bc3-9a18-4a7f66af40cc@grimberg.me>


> Per NVMe-over-Fabrics 1.0 spec, sqsize is represented as
> a 0-based value.

Did we really decide that? The spec actually explicitly says
that a 0 sqsize will be failed:

"If the size is 0h or larger than the controller supports, then a
status value of Connect Invalid Parameters shall be returned."

And then it says: "This is a 0?s based value"

Confusing....
