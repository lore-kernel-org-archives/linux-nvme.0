From: hch@lst.de (Christoph Hellwig)
Date: Tue, 18 Dec 2018 18:07:38 +0100
Subject: [PATCH] nvme-rdma: fix timeout handler
In-Reply-To: <7b1f148f-a881-2483-1b04-3b2ff5b11449@broadcom.com>
References: <20181213212917.8900-1-sagi@grimberg.me>
 <20181216163217.GA12814@lst.de>
 <a9c82a82-6841-3e3d-54b1-659c72a062fd@grimberg.me>
 <7b1f148f-a881-2483-1b04-3b2ff5b11449@broadcom.com>
Message-ID: <20181218170738.GA13748@lst.de>

On Tue, Dec 18, 2018@08:55:46AM -0800, James Smart wrote:
>
>
> On 12/17/2018 1:58 PM, Sagi Grimberg wrote:
>>
>>> So why did nvme_rdma_error_recovery not complete this request?
>>> I think that is where our problem is, and we are just papering over it.
>>
>> nvme_rdma_error_recovery in essence, kicks in when the controller is
>> LIVE and only then sees a failure. What it does is teardown the
>> controller and schedule a periodic reconnect work..
>>
>> When we fail the connection establishment, we don't want to do that,
>> but simply fail and let create_ctrl cleanup and fail.
>>
>> Technically, nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) is
>> failing because we are not LIVE, but rather CONNECTING (as we are still
>> in the create_ctrl time).
>
> which is why I believe the transports need at least a routine that runs 
> down the queues, terminates anything pending (error recovery may be an io 
> timeout), and marks the queues down - regardless of the state of the 
> controller.? That run down will terminate the connection admin commands 
> that may be in error, allowing the fail path Sagi points out to kick in. 
> This same path needs to occur at the start of the reset and delete as well.

That was my impression as well.  Or in fact just allow a transition
from connecting to reset (or a special connect terminate state that
is very similar except for not recovering)
