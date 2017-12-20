From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Dec 2017 20:58:43 +0200
Subject: Fabrics Bug: keep alive timer re-initialized when active
In-Reply-To: <MWHPR04MB09434A9403F6CD4742D39C94820B0@MWHPR04MB0943.namprd04.prod.outlook.com>
References: <MWHPR04MB09434A9403F6CD4742D39C94820B0@MWHPR04MB0943.namprd04.prod.outlook.com>
Message-ID: <7c4f0acb-0248-7c56-3b97-a6c0b4d5ea92@grimberg.me>

Hi Berck (or Nash :))

> During fabric cable pulls, sometimes the keep alive timer gets
> re-initialized while it's already active.  It appears to be a race as it
> doesn't happen every time, but can be reproduced fairly consistently
> with a dozen or cable pulls.  Without object debugging enabled, the
> resulting crash is a pretty opaque dereference of a poisoned object.
> See attached for the ODEBUG output.

Thanks for reporting.

> We're seeing this on 4.12, but I couldn't find any reference to it being
> fixed later.

Some code in the reconnect area was indeed changed in the area of auto
reconnects, can you try the latest nvme-4.15 branch
(http://git.infradead.org/nvme.git)?

If the issue still persist there, the only way this can happen is if
reconnect and reset are concurrently running together.
