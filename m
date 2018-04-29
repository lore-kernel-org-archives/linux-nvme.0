From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 29 Apr 2018 15:11:00 +0300
Subject: [Suspected-Phishing]Re: [PATCH 2/2] nvme: start keep alive timer
 when enabling the controller
In-Reply-To: <99c20baf-a871-faf0-4073-9958f959dfe6@mellanox.com>
References: <20180415084741.4235-1-sagi@grimberg.me>
 <20180415084741.4235-2-sagi@grimberg.me>
 <fe43038e-001c-7468-be66-3df96d9d95e0@mellanox.com>
 <9529fb23-ba35-0f41-7eda-2439612e1cd6@grimberg.me>
 <20180417152407.GB25823@lst.de>
 <99c20baf-a871-faf0-4073-9958f959dfe6@mellanox.com>
Message-ID: <fa0ff7fc-1dc8-4eb5-4428-8b39220e76c3@mellanox.com>



On 4/23/2018 1:08 PM, Max Gurtovoy wrote:
> Hi Sagi/Christoph,
> 
> On 4/17/2018 6:24 PM, Christoph Hellwig wrote:
>> On Sun, Apr 15, 2018@01:17:58PM +0300, Sagi Grimberg wrote:
>>>> Christoph suggested to add the keep-alive stop to the 
>>>> disable/shutdown (I
>>>> guess we need to add it to both, right ?) and in the target side to 
>>>> start
>>>> expecting also once ctrl is enabled and stop when disabled.
>>>
>>> I don't necessarily think we need to. Also, its better to do this sooner
>>> rather than later (stop_ctrl happens before disable/shutdown) and also,
>>> disable/shutdown might not even execute if the transport is not 
>>> connected.
>>
>> I was suggesting to do it in disable as that is the point at which
>> we can't send one for sure.? But yes, I suspect stop_ctrl is even
>> better due to the reasons Sagi stated.? Sorry for the confusion.
>>
> 
> Actually after running more tests in our lab we found out that it must 
> be symmetric (similar to my V1 that started the discussion).
> For example a situation that we have many subsystems per portal.
> This will create many controllers and QPs (in RDMA transport).
> If we unload nvme_rdma module we'll call for each ctrl:
> nvme_delete_ctrl
>  ??? queue nvme_delete_ctrl_work
>  ??????? nvme_stop_ctrl
>  ??????????? nvme_stop_keep_alive
> 
> 
> in this situation we'll stop the keep_alive mechanism at the initiator
> before starting the IO queues destruction, that may take a while during 
> high load. In this situation the KA timer can expire in the target side 
> and this will follow ctrl destruction (QPs are freed...).
> Let's continue in the initiator side:
> we'll try to call nvme_shutdown_ctrl that reg_write32/reg_read32 from 
> the ctrl that was already destroyed in the target side. This may cause 
> the __nvme_submit_sync_cmd to stuck forever... (may stuck if we return 
> BLK_EH_RESET_TIMER in nvme_rdma_timeout callback, as was proposed in 
> IsraelR patchset that is disscussed in the mailing list and on hold now).

Seems like James commit "nvme: expand nvmf_check_if_ready checks" 
elimenates this command to stuck since it fails during queue_rq now..

> 
> So I suggest we re-think about the KA fix and make the start/stop keep 
> alive as symmetric as possible, even if we'll need to update RDMA/FC 
> code...
> 
> -Max.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7C20861682aa09445a86f908d5a9024756%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636600749628505218&sdata=K5g4rTCnadeCWSMBkrURad7iWxPb%2F05IhFfDz6FWGg0%3D&reserved=0 
> 
