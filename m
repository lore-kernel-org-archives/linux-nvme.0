From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 24 Sep 2015 13:41:33 -0600
Subject: [PATCH] nvme: Add error checking in nvme_create_io_queues
In-Reply-To: <alpine.LNX.2.00.1509241920360.23840@localhost.lm.intel.com>
References: <1443118811-2153-1-git-send-email-jonathan.derrick@intel.com>
 <alpine.LNX.2.00.1509241920360.23840@localhost.lm.intel.com>
Message-ID: <20150924194133.GA28638@localhost.localdomain>

On Thu, Sep 24, 2015@07:23:27PM +0000, Keith Busch wrote:
> On Thu, 24 Sep 2015, Jon Derrick wrote:
> >allow nvme_create_io_queues to return an error if the first io queue
> >fails to be allocated or initialized
> 
> If the driver gets far enough to attempt creating IO queues, the device
> can be managed so I don't think we want to error out and bail on the
> device in this scenario, even though it is not IO capable.
> 

Very good point.

I think just the dev_warn should suffice then, without the teardown.
After testing I have not seeing any issues with only leaving the controller handle up.

> >Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
> >---
> >drivers/block/nvme-core.c | 20 ++++++++++++++++----
> >1 file changed, 16 insertions(+), 4 deletions(-)
