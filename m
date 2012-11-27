From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 27 Nov 2012 16:39:43 -0500
Subject: Alignment Issue with Direct IO to NVMe Drive
In-Reply-To: <CAMi7pMb7Ln02hLfa_i-7ucWZBDGzQLUOoQTeFp70=yGix_gojA@mail.gmail.com>
References: <CAMi7pMamJK079wQs+5Kaz=zdYGAPS+BFg2xCRKJMqPFMrQvQPQ@mail.gmail.com>
 <50B4AD8A.7020208@kernel.dk>
 <20121127170509.GA5100@linux.intel.com>
 <CAMi7pMb7Ln02hLfa_i-7ucWZBDGzQLUOoQTeFp70=yGix_gojA@mail.gmail.com>
Message-ID: <20121127213943.GB5100@linux.intel.com>

On Tue, Nov 27, 2012@09:47:48AM -0800, Laine Walker-Avina wrote:
> On Tue, Nov 27, 2012@9:05 AM, Matthew Wilcox <willy@linux.intel.com> wrote:
> > Laine, when this occurs, what is the alignment of 'offset' in the sg
> > entry you're looking at?  If userspace is passing in an unaligned address,
> > I don't think there's anything we do to try to align it.
> 
> I thought this was the case as well, but it appears to be aligned
> looking at the request in the user space program (fio using libaio in
> this case) before the IO is submitted.

OK, so we have an aligned virtual address being translated into an
unaligned DMA address.  I have a suspicion ... are you using the swiotlb,
or are you using a real IOMMU?  Grep dmesg for 'IOMMU' if you're not sure.
