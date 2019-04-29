From: minwoo.im@samsung.com (Minwoo Im)
Date: Tue, 30 Apr 2019 08:37:56 +0900
Subject: [PATCH] nvmet: protect discovery change log event list iteration
In-Reply-To: <20190429232819.9844-1-sagi@grimberg.me>
References: <20190429232819.9844-1-sagi@grimberg.me>
 <CGME20190429232827epcas4p2d2a2bdfa7777059fe52f5591a2488109@epcms2p7>
Message-ID: <20190429233756epcms2p7e5b84be4fe61314b61399df3420f4a39@epcms2p7>

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
> Behalf Of Sagi Grimberg
> Sent: Tuesday, April 30, 2019 8:28 AM
> To: linux-nvme at lists.infradead.org
> Cc: Keith Busch; Christoph Hellwig
> Subject: [PATCH] nvmet: protect discovery change log event list iteration
> 
> When we iterate on the discovery subsystem controllers
> we need to protect against concurrent mutations to it.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im at samsung.com>
