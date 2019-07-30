From: kbusch@kernel.org (Keith Busch)
Date: Tue, 30 Jul 2019 14:48:29 -0600
Subject: [PATCH] drivers/nvme: save/restore HMB on suspend/resume
In-Reply-To: <362aad7f1cf547c2a73e1c4f564984db@AUSX13MPS303.AMER.DELL.COM>
References: <362aad7f1cf547c2a73e1c4f564984db@AUSX13MPS303.AMER.DELL.COM>
Message-ID: <20190730204829.GI13948@localhost.localdomain>

On Tue, Jul 30, 2019@08:09:15PM +0000, Charles.Hyde@dellteam.com wrote:
> LiteOn CL1 devices allocate host memory buffer at initialization.
> This patch saves and restores the host memory buffer allocation
> for any NVMe device which has HMB.  Devices which have on-board
> memory buffers are not impacted.  This patch has been tested locally
> with the following devices: LiteOn CL1 and CA3, Hynix BC511 and
> PC601, WDC SN520 and SN720.  This patch has also been tested by
> our partners at Wistron and Compal.

Please explain why you're doing this rather than what you're doing. We
previously concluded that NVMe power states have no spec defined impact
on HMB, so changing driver behavior requires justification.
