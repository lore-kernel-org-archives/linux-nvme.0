From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 25 May 2018 08:25:37 -0600
Subject: [PATCHv3 7/9] nvme-pci: Attempt reset retry for IO failures
In-Reply-To: <20180525130423.GI23463@lst.de>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-8-keith.busch@intel.com>
 <20180525130423.GI23463@lst.de>
Message-ID: <20180525142537.GO11037@localhost.localdomain>

On Fri, May 25, 2018@03:04:23PM +0200, Christoph Hellwig wrote:
> On Thu, May 24, 2018@02:34:58PM -0600, Keith Busch wrote:
> > If the reset failed due to a non-fatal error, this patch will attempt
> > to reset the controller again, with a maximum of 4 attempts.
> 
> What kind of non-fatal errors do you see that this tries to handle?

Like how a non-fatal uncorrectable error can trigger a reset. If we
happen to be executing an initialization admin command, it returns
-EINTR. The driver would normally just unbind from the controller if
any admin command fails, but retrying may succeed.
