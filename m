From: keith.busch@intel.com (Keith Busch)
Date: Thu, 15 Mar 2018 14:30:08 -0600
Subject: [PATCH] nvme_fc: fix ctrl create failures racing with workq items
In-Reply-To: <20180313164807.8981-1-jsmart2021@gmail.com>
References: <20180313164807.8981-1-jsmart2021@gmail.com>
Message-ID: <20180315203007.GE30695@localhost.localdomain>

On Tue, Mar 13, 2018@09:48:07AM -0700, James Smart wrote:
> If there are errors during initial controller create, the transport
> will teardown the partially initialized controller struct and free
> the ctlr memory.  Trouble is - most of those errors can occur due
> to asynchronous events happening such io timeouts and subsystem
> connectivity failures. Those failures invoke async workq items to
> reset the controller and attempt reconnect.  Those may be in progress
> as the main thread frees the ctrl memory, resulting in NULL ptr oops.
> 
> Prevent this from happening by having the main ctrl failure thread
> changing state to DELETING followed by synchronously cancelling any
> pending queued work item. The change of state will prevent the
> scheduling of resets or reconnect events.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

Thanks, applied for 4.17.
