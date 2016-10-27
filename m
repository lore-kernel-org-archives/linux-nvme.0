From: hch@lst.de (Christoph Hellwig)
Date: Thu, 27 Oct 2016 09:16:00 +0200
Subject: [PATCH 1/2] nvme: introduce struct nvme_request
In-Reply-To: <98e72062-abb2-e596-cbdd-d6f915f8ba4d@broadcom.com>
References: <1477411779-2993-1-git-send-email-hch@lst.de>
 <1477411779-2993-2-git-send-email-hch@lst.de>
 <9ca268e3-355c-578f-30ee-5c148a7d8c47@broadcom.com>
 <2aa1235b-8dae-3399-7d7b-2ebed8ad53c5@broadcom.com>
 <98e72062-abb2-e596-cbdd-d6f915f8ba4d@broadcom.com>
Message-ID: <20161027071600.GA6573@lst.de>

On Wed, Oct 26, 2016@12:11:54PM -0700, James Smart wrote:
> Ok - I understand. nevermind. Patch description covered it.
>
> Can't say I agree with these kind of subtle coding requirements between 
> layers. As soon as the patch description is gone, the understanding of the 
> requirement gets lost without deep understanding of the code.

It's not really any different from the current passthrough code,
which casts two unrelated field in struct request to NVMe data structures.
I'll have to see if I could come up with some BUILD_BUG_ON magic, but
in the this is how we do poor man's inheritance.
