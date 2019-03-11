From: sgruszka@redhat.com (Stanislaw Gruszka)
Date: Mon, 11 Mar 2019 09:43:20 +0100
Subject: MT76x2U crashes XHCI driver on AMD Ryzen system
In-Reply-To: <CAKxU2N-k-9DCYBv6W3CohL963dr3AeY3VHyt8FrUuo=BfacDsw@mail.gmail.com>
References: <20190226100535.GA20740@8bytes.org>
 <20190226103450.GA2989@redhat.com>
 <20190226104413.GH20740@8bytes.org>
 <20190226112407.GB2989@redhat.com>
 <20190228090411.GA24938@redhat.com>
 <20190228104223.GA2749@redhat.com>
 <20190228121948.GD6072@redhat.com>
 <20190228134029.GC1594@8bytes.org>
 <20190304071037.GA2787@redhat.com>
 <CAKxU2N-k-9DCYBv6W3CohL963dr3AeY3VHyt8FrUuo=BfacDsw@mail.gmail.com>
Message-ID: <20190311084319.GA3310@redhat.com>

On Sun, Mar 03, 2019@11:20:45PM -0800, Rosen Penev wrote:
> On Sun, Mar 3, 2019@11:10 PM Stanislaw Gruszka <sgruszka@redhat.com> wrote:
> >
> > On Thu, Feb 28, 2019@02:40:29PM +0100, Joerg Roedel wrote:
> > > On Thu, Feb 28, 2019@01:19:48PM +0100, Stanislaw Gruszka wrote:
> > > > Nevermind, the patch is wrong, s->dma_address is initalized in sg_num_pages().
> > >
> > > Yes, it is. In sg_num_pages() the offset into the IOMMU mapping is
> > > stored in s->dma_address, taking also the segment boundary mask into
> > > account. map_sg() later only adds the base-address to that.
> >
> > I have some more info about the issues in
> > https://bugzilla.kernel.org/show_bug.cgi?id=202673
> >
> > We have some bugs in mt76. Apparently we should not use
> > page_frag_alloc() with size bigger than PAGE_SIZE as page_frag_alloc()
> > can fallback to single page allocation. And also we should not make
> > sizes unaligned as pointed in commit:
> > 3bed3cc4156e ("net: Do not allocate page fragments that are not skb aligned"
> As a small and totally unrelated note, page_frag_alloc is only used in
> mt76 and the nvme driver ;)

And there is nvme problem on AMD IOMMU:
https://bugzilla.kernel.org/show_bug.cgi?id=202665

While page_frag_alloc() should be used with cautious, at least care of
size alignment with ARCH_DMA_MINALIGN (not for IOMMU, but standard arch
dma), at this point I think some of those issues are AMD IOMMU problems.

> > However after fixing that mt76usb still did not work. To make things
> > work we had to change rx frag size from 2048 to PAGE_SIZE and change
> > virt_to_head_page() to virt_to_page() when setting SG's.
>
> > I think I understand why first change was needed. If we do 2 separate
> > dma maps of 2 different buffers in single page i.e (PAGE + off=0
> > and PAGE + off=2048) it causes problem. So either map_sg() return
> > error which mt76usb does not handle correctly or there is issue
> > in AMD IOMMU because two dma maps use the same page.

Any comment on that? Is fine or not to do 2 or more dma mappings
within the same single page on AMD IOMMU? If not, is there any
mechanism for drivers to find out about this limitation to prevent
to prepare wrong SG buffers?

> > But I don't understand why the second change was needed. Without
> > it we have issue with incorrect page->_refcount . It is somehow
> > related with AMD IOMMU, because on different platforms we do not
> > have such problems.

I think I found a bug in amd iommu code when setting sg->dma_address
with sg->offset > PAGE_SIZE. Will post fix shortly. 

Stanislaw
