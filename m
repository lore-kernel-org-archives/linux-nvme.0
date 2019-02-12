From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 12 Feb 2019 19:17:40 +0800
Subject: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's
 affinity
In-Reply-To: <alpine.DEB.2.21.1902112322470.1654@nanos.tec.linutronix.de>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-3-ming.lei@redhat.com>
 <alpine.DEB.2.21.1902101723400.8784@nanos.tec.linutronix.de>
 <20190211035358.GA8638@ming.t460p>
 <20190211143950.GA151039@google.com>
 <alpine.DEB.2.21.1902112322470.1654@nanos.tec.linutronix.de>
Message-ID: <20190212111738.GE24251@ming.t460p>

Hi Thomas,

On Mon, Feb 11, 2019@11:38:07PM +0100, Thomas Gleixner wrote:
> Ming,
> 
> On Mon, 11 Feb 2019, Bjorn Helgaas wrote:
> 
> > On Mon, Feb 11, 2019@11:54:00AM +0800, Ming Lei wrote:
> > > On Sun, Feb 10, 2019@05:30:41PM +0100, Thomas Gleixner wrote:
> > > > On Fri, 25 Jan 2019, Ming Lei wrote:
> > > > 
> > > > > This patch introduces callback of .setup_affinity into 'struct
> > > > > irq_affinity', so that:
> > > > 
> > > > Please see Documentation/process/submitting-patches.rst. Search for 'This
> > > > patch' ....
> > > 
> > > Sorry for that, because I am not a native English speaker and it looks a bit
> > > difficult for me to understand the subtle difference.
> 
> Sorry I was a bit terse.
> 
> > I think Thomas is saying that instead of "This patch introduces
> > callback ...", you could say "Introduce callback of ...".
> > 
> > The changelog is *part* of the patch, so the context is obvious and
> > there's no need to include the words "This patch".
> > 
> > I make the same changes to patches I receive.  In fact, I would go
> > even further and say "Add callback .setup_affinity() ..." because "add"
> > means the same as "introduce" but is shorter and simpler.
> 
> Thanks for the explanation, Bjorn!
> 
> There is another point here. It's not only the 'This patch introduces ...'
> part. It's also good practice to structure the changelog so it provides
> context and reasoning first and then tells what the change is, e.g.:
> 
>    The current handling of multiple interrupt sets in the core interrupt
>    affinity logic, requires the driver to do .......  This is necessary
>    because ....
> 
>    This handling should be in the core code, but the core implementation
>    has no way to recompute the interrupt sets for a given number of
>    vectors.
> 
>    Add an optional callback to struct affd, which lets the driver recompute
>    the interrupt set before the interrupt affinity spreading takes place.
> 
> The first paragraph provides context, i.e. the status quo, The second
> paragraph provides reasoning what is missing and the last one tells what's
> done to solve it.
> 
> That's pretty much the same for all changelogs, even if you fix a bug. Just
> in the bug case, the second paragraph describes the details of the bug and
> the possible consequences.
> 
> You really need to look at the changelog as a stand alone information
> source. That's important when you look at a commit as an outsider or even
> if you look at your own patch 6 month down the road when you already paged
> out all the details.
> 
> Hope that clarifies it.

Your description about how to write changelog is really helpful and useful
for me, thanks!

Maybe you can add it into Documentation/SubmittingPatches, so that lots
of people can benefit from the guide.


Thanks,
Ming
