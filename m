From: keith.busch@intel.com (Keith Busch)
Date: Thu, 26 May 2016 11:12:26 -0400
Subject: [PATCH v2 0/2] move nvme_cancel_io() to common code
In-Reply-To: <CAF1ivSbFUDmue3EKCdiSWReFsEugfCB61N7jfOa4zQ7d-v5hew@mail.gmail.com>
References: <1463605502-27839-1-git-send-email-mlin@kernel.org>
 <CAF1ivSbFUDmue3EKCdiSWReFsEugfCB61N7jfOa4zQ7d-v5hew@mail.gmail.com>
Message-ID: <20160526151225.GE28668@localhost.localdomain>

On Thu, May 26, 2016@12:16:33AM -0700, Ming Lin wrote:
> On Wed, May 18, 2016@2:05 PM, Ming Lin <mlin@kernel.org> wrote:
> > From: Ming Lin <ming.l at samsung.com>
> >
> > So it can be used by fabrics driver also.
> >
> > v2:
> >   - not declare "ctrl"
> >   - rename nvme_cancel_io to nvme_cancel_request
> >
> > Ming Lin (2):
> >   nvme: update and rename nvme_cancel_io to nvme_cancel_request
> >   nvme: move nvme_cancel_request() to common code
> 
> Hi Keith,
> 
> Are you OK with these 2 patches?
> 
> Thanks,
> Ming

Looks fine to me.

Reviewed-by: Keith Busch <keith.bsuch at intel.com>
