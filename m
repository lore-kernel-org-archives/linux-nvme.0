From: kbusch@kernel.org (Keith Busch)
Date: Wed, 14 Aug 2019 14:08:47 -0600
Subject: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
In-Reply-To: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
Message-ID: <20190814200847.GA3504@localhost.localdomain>

On Wed, Aug 14, 2019@01:08:24PM -0700, Mario Limonciello wrote:
> One of the components in LiteON CL1 device has limitations that
> can be encountered based upon boundary race conditions using the
> nvme bus specific suspend to idle flow.
> 
> When this situation occurs the drive doesn't resume properly from
> suspend-to-idle.
> 
> LiteON has confirmed this problem and fixed in the next firmware
> version.  As this firmware is already in the field, avoid running
> nvme specific suspend to idle flow.
> 
> Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
> Link: http://lists.infradead.org/pipermail/linux-nvme/2019-July/thread.html
> Signed-off-by: Mario Limonciello <mario.limonciello at dell.com>
> Signed-off-by: Charles Hyde <charles.hyde at dellteam.com>

Looks fine to me.

Reviewed-by: Keith Busch <kbusch at kernel.org>
