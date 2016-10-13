From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 13 Oct 2016 09:43:17 -0700
Subject: [PATCH 2/3] fine tune the nvme-discover manpage
In-Reply-To: <20161013102632.GA14543@lst.de>
References: <1476261953-23119-1-git-send-email-hch@lst.de>
 <1476261953-23119-3-git-send-email-hch@lst.de>
 <1476292685.5410.67.camel@linux.intel.com> <20161013102632.GA14543@lst.de>
Message-ID: <1476376997.6246.3.camel@linux.intel.com>

On Thu, 2016-10-13@12:26 +0200, Christoph Hellwig wrote:
> On Wed, Oct 12, 2016@10:18:05AM -0700, J Freyensee wrote:
> > 
> > > 
> > > -nvme-discover - Send Get Log Page request to Discovery
> > > Controller.
> > > +nvme-discover - Send Discovery requests to Fabrics Discovery
> > > Controllers.
> > 
> > I preferred mentioning "Get Log Page" because that is really what
> > is
> > happening and reflects the NVMe specification, which I was aiming
> > to
> > push the envelope a bit and help educate and accelerate the
> > learning
> > curve for people new to these features (map more accurately what is
> > being described here to the NVMe specification(s).
> 
> While Get Log Page is technicaly correct I don't really think it
> serves the user much - it's the way the discovery is implemented,
> the important part is that we perform discovery.

I think it does serve the user, it educates the user a bit faster on
the NVMe Specification and what is really happening without spending
the time sorting through the spec, important for things like debugging
and diagnosis if something wonky happens.
