From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 28 Mar 2018 12:17:50 +0300
Subject: [PATCH 1/1] nvme-rdma: Add IB event handling support
In-Reply-To: <20180328081015.GE20373@lst.de>
References: <1521647315-10011-1-git-send-email-maxg@mellanox.com>
 <20180328081015.GE20373@lst.de>
Message-ID: <a1ea3c36-a130-09a0-3270-2cf06240de62@mellanox.com>



On 3/28/2018 11:10 AM, Christoph Hellwig wrote:
> Eww.  I guess something like this is required, but we really need
> one coherent rdma event model instead of this mix between rdms/cm,
> struct ib_client and ib_event.
> 

Yes, I agree. Let's ignore this patch for now.
