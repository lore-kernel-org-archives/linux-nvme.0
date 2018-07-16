From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Jul 2018 18:00:38 +0300
Subject: [PATCHv4 2/4] nvme: Start controller in own work queue
In-Reply-To: <20180713205609.19701-3-keith.busch@intel.com>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-3-keith.busch@intel.com>
Message-ID: <7647e947-f20c-a0eb-d4b5-f19748e2b4bd@grimberg.me>


> This moves the controller start from the reset_work to its own work.
> This is preparing for the possibility of running IO when starting the
> controller, which we shouldn't do from the reset_work since we need that
> context to handle timeouts.

What do you mean handle timeouts? the timeout handler is not invoked
from the reset_work thread.
