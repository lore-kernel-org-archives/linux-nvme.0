From: hch@lst.de (Christoph Hellwig)
Date: Tue, 19 Jun 2018 07:42:34 +0200
Subject: [PATCH 2/2] nvme: start keep alive timer when enabling the
 controller
In-Reply-To: <c42b311e-cd42-5d5b-1528-a0c7614bfe71@mellanox.com>
References: <20180415084741.4235-1-sagi@grimberg.me>
 <20180415084741.4235-2-sagi@grimberg.me>
 <fe43038e-001c-7468-be66-3df96d9d95e0@mellanox.com>
 <9529fb23-ba35-0f41-7eda-2439612e1cd6@grimberg.me>
 <20180417152407.GB25823@lst.de>
 <c42b311e-cd42-5d5b-1528-a0c7614bfe71@mellanox.com>
Message-ID: <20180619054234.GD23184@lst.de>

On Sun, Jun 17, 2018@01:26:01PM +0300, Max Gurtovoy wrote:
>> I was suggesting to do it in disable as that is the point at which
>> we can't send one for sure.  But yes, I suspect stop_ctrl is even
>> better due to the reasons Sagi stated.  Sorry for the confusion.
>>
>
> This wasn't pushed eventually to upstream.
> I see an issue during error flow in case nvme_rdma_configure_io_queues is 
> failed during nvme_rdma_create_ctrl.
> Should we stop the keep-alive explicitly (start keep-alive was called 
> during nvme_enable_ctrl ?
>
> I can send V2..

Please resend after this much time, I don't even rember the issues we
were talking about..
