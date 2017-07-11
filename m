From: keith.busch@intel.com (Keith Busch)
Date: Tue, 11 Jul 2017 10:36:47 -0400
Subject: [PATCH v5 1/1] nvme: Add support for FW activation without reset
In-Reply-To: <1499780912-10253-1-git-send-email-a.dawn@samsung.com>
References: <1499780675-9869-1-git-send-email-a.dawn@samsung.com>
 <CGME20170711134755epcas1p1d699b8c70dab6fcde72ea92d03f76079@epcas1p1.samsung.com>
 <1499780912-10253-1-git-send-email-a.dawn@samsung.com>
Message-ID: <20170711143647.GA4604@localhost.localdomain>

On Tue, Jul 11, 2017@07:18:32PM +0530, Arnav Dawn wrote:
> This patch adds support for handling Fw activation without reset
> On completion of FW-activation-starting AER, all queues are
> paused till CSTS.PP is cleared or timed out (exceeds max time for
> fw activtion MTFA). If device fails to clear CSTS.PP within MTFA,
> driver issues reset controller
> 
> Signed-off-by: Arnav Dawn <a.dawn at samsung.com>

This looks okay to me, thanks for doing this feature.

Reviewed-by: Keith Busch <keith.busch at intel.com>
