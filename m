From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Fri, 9 Dec 2016 13:04:49 -0700
Subject: [PATCH] nvmet: fix KATO offset in Set Features
In-Reply-To: <20161209182827.GA16834@lst.de>
References: <20161207183947.128897-1-daniel.verkamp@intel.com>
 <138d5098-5d12-9a06-66c4-14f53770b0ba@intel.com>
 <20161209182827.GA16834@lst.de>
Message-ID: <7c17a439-5a28-f458-3af7-221d84607611@intel.com>

On 12/09/2016 11:28 AM, Christoph Hellwig wrote:
> On Wed, Dec 07, 2016@12:09:40PM -0700, Daniel Verkamp wrote:
>> Should I remove the nvmet_set_result() or fix it to at least return
>> the correct units?
> 
> Please remove it, as the spec does not define the result.  Otherwise
> the patch looks fine to me.

I sent a new version of the patch that just fixes the unused variable.
I'll send another one to remove the result.  I was going to remove it
in this patch, but I couldn't find out where (if anywhere) the result
is initialized to 0 in the common command handling.  Is it OK to just
remove the call to nvmet_set_result()? Is the whole request zeroed
out somewhere earlier? Or should I just change it to call
nvmet_set_result(req, 0) for clarity?

> Thanks for doing this work! Btw, did you catch this using a test
> suite?

I caught this when testing the SPDK NVMe over Fabrics host code, which
was using the Set Features command to set up KATO.  However, I later
realized that since we already set KATO during Connect, it's pretty
useless to configure it again with a Set Features - so I removed the
code that was hitting this bug.

A NVMe over Fabrics test suite would be a great idea, though...

Thanks,
-- Daniel
