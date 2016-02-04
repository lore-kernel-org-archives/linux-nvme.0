From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 4 Feb 2016 17:57:07 +0200
Subject: [PATCH 2/4] NVMe: Sync stopped queues with block layer
In-Reply-To: <1454515543-21683-3-git-send-email-keith.busch@intel.com>
References: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
 <1454515543-21683-3-git-send-email-keith.busch@intel.com>
Message-ID: <56B374D3.9010003@dev.mellanox.co.il>


> Make sure no work will submit requests to a stopped h/w queue.

Not sure what that buys us, and it's not documented. But
I don't mind having it. Can you provide a better explanation
why it's added?
