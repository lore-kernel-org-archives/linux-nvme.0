From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 9 Aug 2018 14:35:53 -0500
Subject: [PATCH v3 3/3] PCI: Intel DC P3700 NVMe delay after FLR quirk
In-Reply-To: <20180724101849.36f635eb@t450s.home>
References: <20180724160440.2729.75178.stgit@gimli.home>
 <20180724161446.2729.78211.stgit@gimli.home>
 <20180724101849.36f635eb@t450s.home>
Message-ID: <20180809193553.GD113140@bhelgaas-glaptop.roam.corp.google.com>

On Tue, Jul 24, 2018@10:18:48AM -0600, Alex Williamson wrote:
> On Tue, 24 Jul 2018 10:14:46 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > Add a device specific reset for Intel DC P3700 NVMe device which
> > exhibits a timeout failure in drivers waiting for the ready status to
> > update after NVMe enable if the driver interacts with the device too
> > quickly after FLR.  As this has been observed in device assignment
> > scenarios, resolve this with a device specific reset quirk to add an
> > additional, heuristically determined, delay after the FLR completes.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson at redhat.com>
> > ---
> >  drivers/pci/quirks.c |   22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> 
> I forgot to link the bz in this one, if this somehow becomes the final
> version, please add:
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=159265

Corrected link to: https://bugzilla.redhat.com/show_bug.cgi?id=1592654
