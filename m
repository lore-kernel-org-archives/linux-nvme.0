From: kbusch@kernel.org (Keith Busch)
Date: Wed, 14 Aug 2019 14:19:01 -0600
Subject: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
In-Reply-To: <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
 <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
Message-ID: <20190814201900.GA3511@localhost.localdomain>

On Wed, Aug 14, 2019@01:14:50PM -0700, Sagi Grimberg wrote:
> Mario,
> 
> Can you please respin a patch that applies cleanly on nvme-5.4?

This fixes a regression we introduced in 5.3, so it should go in
5.3-rc. For this to apply cleanly, though, we'll need to resync to Linus'
tree to get Rafael's PCIe ASPM check after he sends his linux-pm pull
request.
