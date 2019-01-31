From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 Jan 2019 12:54:03 -0800
Subject: [PATCH] nvme-pci: Fix rapid add remove sequence
In-Reply-To: <20190124014611.8643-1-keith.busch@intel.com>
References: <20190124014611.8643-1-keith.busch@intel.com>
Message-ID: <a3b0f71e-0694-36eb-4eff-2a20d51a6d5d@grimberg.me>


> A surprise removal may fail to tear down request queues if it is racing
> with the initial asynchronous probe. If that happens, the remove path
> won't see the queue resources to tear down, and the controller reset
> path may create a new request queue on a removed device, but will not
> be able to make forward progress, deadlocking the pci removal.

Doesn't pci removal flush the reset work before making forward
progress? Perhaps what is needed that it will flush it earlier instead
of serializing with the shutdown lock?
