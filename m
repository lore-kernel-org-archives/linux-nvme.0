From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 11 Feb 2019 08:39:50 -0600
Subject: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's
 affinity
In-Reply-To: <20190211035358.GA8638@ming.t460p>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-3-ming.lei@redhat.com>
 <alpine.DEB.2.21.1902101723400.8784@nanos.tec.linutronix.de>
 <20190211035358.GA8638@ming.t460p>
Message-ID: <20190211143950.GA151039@google.com>

On Mon, Feb 11, 2019@11:54:00AM +0800, Ming Lei wrote:
> On Sun, Feb 10, 2019@05:30:41PM +0100, Thomas Gleixner wrote:
> > On Fri, 25 Jan 2019, Ming Lei wrote:
> > 
> > > This patch introduces callback of .setup_affinity into 'struct
> > > irq_affinity', so that:
> > 
> > Please see Documentation/process/submitting-patches.rst. Search for 'This
> > patch' ....
> 
> Sorry for that, because I am not a native English speaker and it looks a bit
> difficult for me to understand the subtle difference.

I think Thomas is saying that instead of "This patch introduces
callback ...", you could say "Introduce callback of ...".

The changelog is *part* of the patch, so the context is obvious and
there's no need to include the words "This patch".

I make the same changes to patches I receive.  In fact, I would go
even further and say "Add callback .setup_affinity() ..." because "add"
means the same as "introduce" but is shorter and simpler.

Bjorn
