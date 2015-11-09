From: hch@lst.de (Christoph Hellwig)
Date: Mon, 9 Nov 2015 20:25:19 +0100
Subject: [PATCH 09/12] nvme: properly free resources for cancelled command
In-Reply-To: <20151109185731.GB5386@localhost.localdomain>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
 <1446885906-20967-10-git-send-email-hch@lst.de>
 <20151109185731.GB5386@localhost.localdomain>
Message-ID: <20151109192518.GA10681@lst.de>

On Mon, Nov 09, 2015@06:57:31PM +0000, Keith Busch wrote:
> On Sat, Nov 07, 2015@09:45:03AM +0100, Christoph Hellwig wrote:
> > +	if (unlikely(req->errors)) {
> > +		/*
> > +		 * Some silly Intel userspace code breaks if it doesn't get a
> > +		 * negative errno back for driver returns values.
> > +		 */
> 
> Whoa now, it's neither Intel nor userpace that needs this. It's to know
> if the controller is unresponsive or returned an error. The difference
> matters to the driver for initialization.

Haha, so we at least can root cause this now.  Can you point me
to the caller that cares?  I'd really like to get rid of the special
case of passing a negative errno here, so I'd like to figure out how
we could pass this information on instead.
