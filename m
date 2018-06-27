From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 27 Jun 2018 11:46:18 +0300
Subject: [PATCH 1/1] nvme-rdma: fix WARN_ON condition during RDMA ctrl
 setup
In-Reply-To: <defd212c-56d0-bb7e-1313-d3aa1dfa7844@mellanox.com>
References: <1530015365-30049-1-git-send-email-maxg@mellanox.com>
 <dbeadb2d-b227-d8c0-23e4-dafcf507913d@grimberg.me>
 <defd212c-56d0-bb7e-1313-d3aa1dfa7844@mellanox.com>
Message-ID: <8792975f-4859-dd23-86a5-93015cd07e38@grimberg.me>


>>> We can only agree to fail moving to NVME_CTRL_LIVE while we're in
>>> NVME_CTRL_DELETING for existing controllers. In case we are in the
>>> initial creation of the controller we never should fail.
>>
>> A. the change log is incorrect as we do fail, its about the warning
>> message.
> 
> Ok.
> 
>>
>> B. What is this designed to warn against? did you actually see this? or
>> is it to warn if we happened to mess up?
> 
> Yes to warn if something unusual happened. Exactly as it was before your 
> patch "nvme-rdma: centralize controller setup sequence"

fair enough, please fix your change log and respin. thanks.
