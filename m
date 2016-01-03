From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 3 Jan 2016 18:52:23 +0200
Subject: [PATCHv2 5/5] NVMe: Shutdown controller only for power-off
In-Reply-To: <1451580116-12252-6-git-send-email-keith.busch@intel.com>
References: <1451580116-12252-1-git-send-email-keith.busch@intel.com>
 <1451580116-12252-6-git-send-email-keith.busch@intel.com>
Message-ID: <568951C7.5010504@dev.mellanox.co.il>


> We don't need to shutdown a controller for a reset. A controller in a
> shutdown state may take longer to become ready than one that was simply
> disabled.

Just out of curiosity, what's "longer"? how much does this patch save us?

Otherwise,

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
