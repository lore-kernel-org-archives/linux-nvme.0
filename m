From: keith.busch@intel.com (Keith Busch)
Date: Thu, 3 Jan 2019 14:51:50 -0700
Subject: [PATCH 3/4] pci/irq: Handle vector reduce and retry
In-Reply-To: <20190103213900.GB168876@google.com>
References: <20190103210954.11129-1-keith.busch@intel.com>
 <20190103210954.11129-3-keith.busch@intel.com>
 <20190103213900.GB168876@google.com>
Message-ID: <20190103215149.GA10822@localhost.localdomain>

On Thu, Jan 03, 2019@03:39:01PM -0600, Bjorn Helgaas wrote:
> Hi Keith,
> 
> Thanks a lot for jumping on this.
> 
> I know I'm a broken record.  Please run "git log --oneline
> drivers/pci/msi.c" and make your subject match.

Sure thing, my mistake.
 
> On Thu, Jan 03, 2019@02:09:53PM -0700, Keith Busch wrote:
> Can you also add some explanation to Documentation/PCI/MSI-HOWTO.txt
> about the concept of "sets" and how to use
> nr_sets/sets/recalc_sets/priv?

Yes, will do. Do you prefer documentation in a separate patch or the same
one?

> > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > index c672f34235e7..326c9bd05f62 100644
> > --- a/include/linux/interrupt.h
> > +++ b/include/linux/interrupt.h
> > @@ -249,12 +249,16 @@ struct irq_affinity_notify {
> >   *			the MSI(-X) vector space
> >   * @nr_sets:		Length of passed in *sets array
> >   * @sets:		Number of affinitized sets
> > + * @recalc_sets:	Recalculate sets original requested allocation failed
> 
> This sentence is missing something and doesn't parse quite right.
> "if"?  Is "original" superfluous?

Yikes, that was a very poor merge of two different thought streams. I'll
fix that up.
