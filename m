From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 26 Jun 2018 15:43:17 +0300
Subject: [PATCH 1/1] nvme-rdma: fix WARN_ON condition during RDMA ctrl
 setup
In-Reply-To: <dbeadb2d-b227-d8c0-23e4-dafcf507913d@grimberg.me>
References: <1530015365-30049-1-git-send-email-maxg@mellanox.com>
 <dbeadb2d-b227-d8c0-23e4-dafcf507913d@grimberg.me>
Message-ID: <defd212c-56d0-bb7e-1313-d3aa1dfa7844@mellanox.com>



On 6/26/2018 3:27 PM, Sagi Grimberg wrote:
> 
>> We can only agree to fail moving to NVME_CTRL_LIVE while we're in
>> NVME_CTRL_DELETING for existing controllers. In case we are in the
>> initial creation of the controller we never should fail.
> 
> A. the change log is incorrect as we do fail, its about the warning
> message.

Ok.

> 
> B. What is this designed to warn against? did you actually see this? or
> is it to warn if we happened to mess up?

Yes to warn if something unusual happened. Exactly as it was before your 
patch "nvme-rdma: centralize controller setup sequence"
