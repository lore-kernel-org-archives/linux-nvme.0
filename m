From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 29 Mar 2016 10:42:41 -0400
Subject: nvme device timeout
In-Reply-To: <20160329110659.GA10015@infradead.org>
References: <CAHOCc18wCgprYh1k0m0ow1FhU51J-1JN-X2Fj-8VKHDVi-Zo9Q@mail.gmail.com>
 <20160328172423.GA22481@localhost.localdomain>
 <36E8D38D6B771A4BBDB1C0D800158A51865EF73D@SSIEXCH-MB3.ssi.samsung.com>
 <20160328225411.GB27195@localhost.localdomain>
 <20160329070328.GA8910@infradead.org>
 <36E8D38D6B771A4BBDB1C0D800158A51865EFB85@SSIEXCH-MB3.ssi.samsung.com>
 <20160329110659.GA10015@infradead.org>
Message-ID: <20160329144241.GA2396@linux.intel.com>

On Tue, Mar 29, 2016@04:06:59AM -0700, Christoph Hellwig wrote:
> On Tue, Mar 29, 2016@11:04:51AM +0000, Judy Brock-SSI wrote:
> > I think controllers that need it won't know they need it (like Keith hypothesized, will have an unknowing reliance on polling for completions during probe) and so a quirk flag won't do a lot of good.
> > Seems like it makes sense to put it back in to avoid breaking HW that do need it if there is not a compelling functional reason not to do so. Since 4.6 is still in RC stage, maybe it could be put back into 4.6.
> 
> It's not about not knowing - these controllers are broken plain and
> simple and need to be fixed.  It's the same as we do for all kinds of
> USB crap in SCSI - we don't simple tolerate broken behavior but instead
> require a quirk for it.

I doubt it's the controller.  Usually it's ACPI or how the PCI bridge
got wired up.
