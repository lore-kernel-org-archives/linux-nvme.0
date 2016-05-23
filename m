From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 May 2016 08:10:12 -0700
Subject: [PATCH 1/2] pci: Error disabling SR-IOV if in VFs assigned
In-Reply-To: <20160523090711.12fa34f9@ul30vt.home>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <20160517160832.51fc0304@t450s.home>
 <20160523105532.GB26331@infradead.org>
 <20160523090711.12fa34f9@ul30vt.home>
Message-ID: <20160523151011.GA31504@infradead.org>

On Mon, May 23, 2016@09:07:11AM -0600, Alex Williamson wrote:
> On Mon, 23 May 2016 03:55:32 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Tue, May 17, 2016@04:08:32PM -0600, Alex Williamson wrote:
> > > On Tue, 17 May 2016 15:39:58 -0600
> > > Keith Busch <keith.busch@intel.com> wrote:
> > >   
> > > > Every sriov capable driver has to check if any guest is using a virtual
> > > > function prior to disabling, so let's make it common code.  
> > > 
> > > This is not true, the PCI_DEV_FLAGS_ASSIGNED flag is inherently racy,
> > > so checking it is really only a courtesy for broken drivers that
> > > still make use of it.  I don't object to adding it here, though I
> > > wish the entire interface was deprecated, but it's only a minimal amount
> > > of insurance as a VF might get assigned immediately following your added
> > > test or might not participate in the assigned device flagging at all.  
> > 
> > Si should we just kill it? As far as I can tell it's only used in these
> > kinds of boilerplate checks.
> 
> Long term, yes, but perhaps KVM legacy PCI device assignment needs to
> be not only deprecated, but removed first.

Oh well.  In that case I'd like to at least move it to the PCI core
so that drivers don't have to care about it.
