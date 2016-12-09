From: hch@lst.de (Christoph Hellwig)
Date: Fri, 9 Dec 2016 19:28:27 +0100
Subject: [PATCH] nvmet: fix KATO offset in Set Features
In-Reply-To: <138d5098-5d12-9a06-66c4-14f53770b0ba@intel.com>
References: <20161207183947.128897-1-daniel.verkamp@intel.com>
 <138d5098-5d12-9a06-66c4-14f53770b0ba@intel.com>
Message-ID: <20161209182827.GA16834@lst.de>

On Wed, Dec 07, 2016@12:09:40PM -0700, Daniel Verkamp wrote:
> Should I remove the nvmet_set_result() or fix it to at least return
> the correct units?

Please remove it, as the spec does not define the result.  Otherwise
the patch looks fine to me.

Thanks for doing this work! Btw, did you catch this using a test
suite?
