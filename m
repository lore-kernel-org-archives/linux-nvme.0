From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 17 Jun 2018 13:26:01 +0300
Subject: [PATCH 2/2] nvme: start keep alive timer when enabling the
 controller
In-Reply-To: <20180417152407.GB25823@lst.de>
References: <20180415084741.4235-1-sagi@grimberg.me>
 <20180415084741.4235-2-sagi@grimberg.me>
 <fe43038e-001c-7468-be66-3df96d9d95e0@mellanox.com>
 <9529fb23-ba35-0f41-7eda-2439612e1cd6@grimberg.me>
 <20180417152407.GB25823@lst.de>
Message-ID: <c42b311e-cd42-5d5b-1528-a0c7614bfe71@mellanox.com>



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

This wasn't pushed eventually to upstream.
I see an issue during error flow in case nvme_rdma_configure_io_queues 
is failed during nvme_rdma_create_ctrl.
Should we stop the keep-alive explicitly (start keep-alive was called 
during nvme_enable_ctrl ?

I can send V2..
