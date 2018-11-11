From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 11 Nov 2018 15:39:02 +0200
Subject: [PATCH] nvmet-rdma: Fix using unallocated nvmet_rdma_delete_wq
In-Reply-To: <20181107082004.GB24841@lst.de>
References: <1541435031-16919-1-git-send-email-israelr@mellanox.com>
 <2b8067ce-9943-0345-31ff-e71b06c57568@mellanox.com>
 <5d3b0ef9-0559-699c-e845-cb0ac8162cda@grimberg.me>
 <20181107082004.GB24841@lst.de>
Message-ID: <a5bac7b3-293a-3300-d8b0-98b6057ba7d9@mellanox.com>


On 11/7/2018 10:20 AM, Christoph Hellwig wrote:
> On Tue, Nov 06, 2018@07:15:31PM -0800, Sagi Grimberg wrote:
>>> Sagi/Christoph/Keith,
>>>
>>> please note that the problematic commit? "nvmet-rdma: use a private
>>> workqueue for delete" is only merged to nvme-4.20 so this fix can be
>>> squashed to it IMO.
>> I think we need to revert 2acf70a ("nvmet-rdma: use a private workqueue for
>> delete") altogether because it never made any difference..
> Agreed.  And nvme-4.20 has been merged to mainline already, so we can't
> squash anything.  I'll plan to revert it for now.


so how we overcome the circular lock that was reported by Bart ?
