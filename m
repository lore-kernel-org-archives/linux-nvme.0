From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Sun, 9 Dec 2018 14:22:29 +0000
Subject: [PATCH] nvme-rdma: complete requests from ->timeout
In-Reply-To: <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
Message-ID: <b7b26a7a-70be-d805-ee64-67fba0b4efa8@mellanox.com>

Hi,
We encountered similar issue.
I think that the problem is that error_recovery might not even be 
queued, in case we're in DELETING state (or CONNECTING state, for that 
matter), because we cannot move from those states to RESETTING.

We prepared some patches which handle completions in case such scenario 
happens (which, in fact, might happen in numerous error flows).

Does it solve your problem?
Nitzan.


On 30/11/2018 03:30, Sagi Grimberg wrote:
> 
>> This does not hold at least for NVMe RDMA host driver. An example 
>> scenario
>> is when the RDMA connection is gone while the controller is being 
>> deleted.
>> In this case, the nvmf_reg_write32() for sending shutdown admin 
>> command by
>> the delete_work could be hung forever if the command is not completed by
>> the timeout handler.
> 
> If the queue is gone, this means that the queue has already flushed and
> any commands that were inflight has completed with a flush error
> completion...
> 
> Can you describe the scenario that caused this hang? When has the
> queue became "gone" and when did the shutdown command execute?
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-nvme-Introduce-nvme_is_aen_req-function.patch
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20181209/09a1c174/attachment.ksh>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0002-nvme-rdma-Handle-completions-if-error_recovery-fails.patch
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20181209/09a1c174/attachment-0001.ksh>
