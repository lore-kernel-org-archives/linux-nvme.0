From: keith.busch@intel.com (Keith Busch)
Date: Mon, 20 Jun 2016 18:54:45 -0400
Subject: [PATCH 0/3] nvme: Don't add namespaces for locked drives
In-Reply-To: <57683415.1060202@jbeekman.nl>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
 <20160620152639.GD12936@localhost.localdomain>
 <57683415.1060202@jbeekman.nl>
Message-ID: <20160620225444.GB1448@localhost.localdomain>

On Mon, Jun 20, 2016@11:21:09AM -0700, Jethro Beekman wrote:
> On 20-06-16 08:26, Keith Busch wrote:
> 
> Would this just be a matter of setting req->retries and checking for it in
> nvme_req_needs_retry? How does one keep track of the number of tries so far?

I just sent a patch out earlier today to use req->retries to track the
retry count, and nvme module parameter to set the max retries. I think
that would fix the long delays you're seeing, assuming the patch is okay.
 
> You're right, I assumed that admin commands can't have namespace ids, but
> looking at the spec, that's not the case. Turns out there's a problem with the
> driver then: nvme_ioctl never includes the ns for NVME_IOCTL_ADMIN_CMD.

The NVME_IOCTL_ADMIN_CMD already takes any namespace identifier the user
put in that field.
