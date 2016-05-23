From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 May 2016 03:55:32 -0700
Subject: [PATCH 1/2] pci: Error disabling SR-IOV if in VFs assigned
In-Reply-To: <20160517160832.51fc0304@t450s.home>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <20160517160832.51fc0304@t450s.home>
Message-ID: <20160523105532.GB26331@infradead.org>

On Tue, May 17, 2016@04:08:32PM -0600, Alex Williamson wrote:
> On Tue, 17 May 2016 15:39:58 -0600
> Keith Busch <keith.busch@intel.com> wrote:
> 
> > Every sriov capable driver has to check if any guest is using a virtual
> > function prior to disabling, so let's make it common code.
> 
> This is not true, the PCI_DEV_FLAGS_ASSIGNED flag is inherently racy,
> so checking it is really only a courtesy for broken drivers that
> still make use of it.  I don't object to adding it here, though I
> wish the entire interface was deprecated, but it's only a minimal amount
> of insurance as a VF might get assigned immediately following your added
> test or might not participate in the assigned device flagging at all.

Si should we just kill it? As far as I can tell it's only used in these
kinds of boilerplate checks.

> I
> believe the better way to handle this is with proper host drivers for
> assigned devices that manage the driver .remove callback properly while
> devices are in use.  The only reason to handle assigned devices
> specially in this case is when they don't have proper host drivers
> managing them, which is a problem that we've fixed.  Thanks,

We always use pci-stub now, don't we?
