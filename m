From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 29 Nov 2018 17:30:25 -0800
Subject: [PATCH] nvme-rdma: complete requests from ->timeout
In-Reply-To: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
Message-ID: <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>


> This does not hold at least for NVMe RDMA host driver. An example scenario
> is when the RDMA connection is gone while the controller is being deleted.
> In this case, the nvmf_reg_write32() for sending shutdown admin command by
> the delete_work could be hung forever if the command is not completed by
> the timeout handler.

If the queue is gone, this means that the queue has already flushed and
any commands that were inflight has completed with a flush error
completion...

Can you describe the scenario that caused this hang? When has the
queue became "gone" and when did the shutdown command execute?
