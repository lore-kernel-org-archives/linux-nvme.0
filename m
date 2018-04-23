From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 23 Apr 2018 13:08:19 +0300
Subject: [PATCH 2/2] nvme: start keep alive timer when enabling the
 controller
In-Reply-To: <20180417152407.GB25823@lst.de>
References: <20180415084741.4235-1-sagi@grimberg.me>
 <20180415084741.4235-2-sagi@grimberg.me>
 <fe43038e-001c-7468-be66-3df96d9d95e0@mellanox.com>
 <9529fb23-ba35-0f41-7eda-2439612e1cd6@grimberg.me>
 <20180417152407.GB25823@lst.de>
Message-ID: <99c20baf-a871-faf0-4073-9958f959dfe6@mellanox.com>

Hi Sagi/Christoph,

On 4/17/2018 6:24 PM, Christoph Hellwig wrote:
> On Sun, Apr 15, 2018@01:17:58PM +0300, Sagi Grimberg wrote:
>>> Christoph suggested to add the keep-alive stop to the disable/shutdown (I
>>> guess we need to add it to both, right ?) and in the target side to start
>>> expecting also once ctrl is enabled and stop when disabled.
>>
>> I don't necessarily think we need to. Also, its better to do this sooner
>> rather than later (stop_ctrl happens before disable/shutdown) and also,
>> disable/shutdown might not even execute if the transport is not connected.
> 
> I was suggesting to do it in disable as that is the point at which
> we can't send one for sure.  But yes, I suspect stop_ctrl is even
> better due to the reasons Sagi stated.  Sorry for the confusion.
> 

Actually after running more tests in our lab we found out that it must 
be symmetric (similar to my V1 that started the discussion).
For example a situation that we have many subsystems per portal.
This will create many controllers and QPs (in RDMA transport).
If we unload nvme_rdma module we'll call for each ctrl:
nvme_delete_ctrl
     queue nvme_delete_ctrl_work
         nvme_stop_ctrl
             nvme_stop_keep_alive


in this situation we'll stop the keep_alive mechanism at the initiator
before starting the IO queues destruction, that may take a while during 
high load. In this situation the KA timer can expire in the target side 
and this will follow ctrl destruction (QPs are freed...).
Let's continue in the initiator side:
we'll try to call nvme_shutdown_ctrl that reg_write32/reg_read32 from 
the ctrl that was already destroyed in the target side. This may cause 
the __nvme_submit_sync_cmd to stuck forever... (may stuck if we return 
BLK_EH_RESET_TIMER in nvme_rdma_timeout callback, as was proposed in 
IsraelR patchset that is disscussed in the mailing list and on hold now).

So I suggest we re-think about the KA fix and make the start/stop keep 
alive as symmetric as possible, even if we'll need to update RDMA/FC code...

-Max.
