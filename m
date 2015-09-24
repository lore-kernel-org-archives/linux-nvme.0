From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 Sep 2015 19:23:27 +0000 (UTC)
Subject: [PATCH] nvme: Add error checking in nvme_create_io_queues
In-Reply-To: <1443118811-2153-1-git-send-email-jonathan.derrick@intel.com>
References: <1443118811-2153-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <alpine.LNX.2.00.1509241920360.23840@localhost.lm.intel.com>

On Thu, 24 Sep 2015, Jon Derrick wrote:
> allow nvme_create_io_queues to return an error if the first io queue
> fails to be allocated or initialized

If the driver gets far enough to attempt creating IO queues, the device
can be managed so I don't think we want to error out and bail on the
device in this scenario, even though it is not IO capable.

> Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
> ---
> drivers/block/nvme-core.c | 20 ++++++++++++++++----
> 1 file changed, 16 insertions(+), 4 deletions(-)
