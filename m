From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 20 Feb 2019 06:43:46 -0800
Subject: Read-only Mapping of Program Text using Large THP Pages
In-Reply-To: <07B3B085-C844-4A13-96B1-3DB0F1AF26F5@oracle.com>
References: <379F21DD-006F-4E33-9BD5-F81F9BA75C10@oracle.com>
 <20190220134454.GF12668@bombadil.infradead.org>
 <07B3B085-C844-4A13-96B1-3DB0F1AF26F5@oracle.com>
Message-ID: <20190220144345.GG12668@bombadil.infradead.org>


[adding linux-nvme and linux-block for opinions on the critical-page-first
idea in the second and third paragraphs below]

On Wed, Feb 20, 2019@07:07:29AM -0700, William Kucharski wrote:
> > On Feb 20, 2019,@6:44 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > That interface would need to have some hint from the VFS as to what
> > range of file offsets it's looking for, and which page is the critical
> > one.  Maybe that's as simple as passing in pgoff and order, where pgoff is
> > not necessarily aligned to 1<<order.  Or maybe we want to explicitly
> > pass in start, end, critical.
> 
> The order is especially important, as I think it's vital that the FS can
> tell the difference between a caller wanting 2M in PAGESIZE pages
> (something that could be satisfied by taking multiple trips through the
> existing readahead) or needing to transfer ALL the content for a 2M page
> as the fault can't be satisfied until the operation is complete.

There's an open question here (at least in my mind) whether it's worth
transferring the critical page first and creating a temporary PTE mapping
for just that one page, then filling in the other 511 pages around it
and replacing it with a PMD-sized mapping.  We've had similar discussions
around this with zeroing freshly-allocated PMD pages, but I'm not aware
of anyone showing any numbers.  The only reason this might be a win
is that we wouldn't have to flush remote CPUs when replacing the PTE
mapping with a PMD mapping because they would both map to the same page.

It might be a complete loss because IO systems are generally set up for
working well with large contiguous IOs rather than returning a page here,
12 pages there and then 499 pages there.  To a certain extent we fixed
that in NVMe; where SCSI required transferring bytes in order across the
wire, an NVMe device is provided with a list of pages and can transfer
bytes in whatever way makes most sense for it.  What NVMe doesn't have
is a way for the host to tell the controller "Here's a 2MB sized I/O;
bytes 40960 to 45056 are most important to me; please give me a completion
event once those bytes are valid and then another completion event once
the entire I/O is finished".

I have no idea if hardware designers would be interested in adding that
kind of complexity, but this is why we also have I/O people at the same
meeting, so we can get these kinds of whole-stack discussions going.

> It also
> won't be long before reading 1G at a time to map PUD-sized pages becomes
> more important, plus the need to support various sizes in-between for
> architectures like ARM that support them (see the non-standard size THP
> discussion for more on that.)

The critical-page-first notion becomes even more interesting at these
larger sizes.  If a memory system is capable of, say, 40GB/s, it can
only handle 40 1GB page faults per second, and each individual page
fault takes 25ms.  That's rotating rust latencies ;-)

> I'm also hoping the conference would have enough "mixer" time that MM folks
> can have a nice discussion with the FS folks to get their input - or at the
> very least these mail threads will get that ball rolling.

Yes, there are both joint sessions (sometimes plenary with all three
streams, sometimes two streams) and plenty of time allocated to
inter-session discussions.  There's usually substantial on-site meal
and coffee breaks during which many important unscheduled discussions
take place.
