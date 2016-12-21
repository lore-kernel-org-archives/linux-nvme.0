From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Dec 2016 11:27:44 +0100
Subject: [PATCH] nvmet: fix KATO offset in Set Features
In-Reply-To: <7c17a439-5a28-f458-3af7-221d84607611@intel.com>
References: <20161207183947.128897-1-daniel.verkamp@intel.com>
 <138d5098-5d12-9a06-66c4-14f53770b0ba@intel.com>
 <20161209182827.GA16834@lst.de>
 <7c17a439-5a28-f458-3af7-221d84607611@intel.com>
Message-ID: <20161221102744.GA30308@lst.de>

On Fri, Dec 09, 2016@01:04:49PM -0700, Daniel Verkamp wrote:
> On 12/09/2016 11:28 AM, Christoph Hellwig wrote:
> > On Wed, Dec 07, 2016@12:09:40PM -0700, Daniel Verkamp wrote:
> >> Should I remove the nvmet_set_result() or fix it to at least return
> >> the correct units?
> > 
> > Please remove it, as the spec does not define the result.  Otherwise
> > the patch looks fine to me.
> 
> I sent a new version of the patch that just fixes the unused variable.
> I'll send another one to remove the result.  I was going to remove it
> in this patch, but I couldn't find out where (if anywhere) the result
> is initialized to 0 in the common command handling.  Is it OK to just
> remove the call to nvmet_set_result()? Is the whole request zeroed
> out somewhere earlier? Or should I just change it to call
> nvmet_set_result(req, 0) for clarity?

We currently don't touch ->result unless the spec specifies any
value for it, although it might be a good idea to just always
initialize it to make sure nothing is leaked.

So if you feel like sending patches I'd send one patch to initialize
the 64-bit result field to 0 in nvmet_req_init next to where ->status
is initialized and then just remove it.
