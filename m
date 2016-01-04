From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Mon, 4 Jan 2016 18:08:18 +0200
Subject: [PATCHv2 5/5] NVMe: Shutdown controller only for power-off
In-Reply-To: <20160104155431.GH31375@localhost.localdomain>
References: <1451580116-12252-1-git-send-email-keith.busch@intel.com>
 <1451580116-12252-6-git-send-email-keith.busch@intel.com>
 <568951C7.5010504@dev.mellanox.co.il>
 <20160104155431.GH31375@localhost.localdomain>
Message-ID: <568A98F2.9060707@dev.mellanox.co.il>


>> Just out of curiosity, what's "longer"? how much does this patch save us?
>
> It depends on the device's capacity in my experience. Testing on a 2TB
> P3700, a complete reset takes about 8 seconds when using controller
> shutdown, and ~3 seconds without it.

Fair enough.
