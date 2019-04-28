From: liu.song.a23@gmail.com (Song Liu)
Date: Sun, 28 Apr 2019 13:08:05 -0700
Subject: Read-only Mapping of Program Text using Large THP Pages
In-Reply-To: <B53C9F2D-966C-4DFD-8151-0A7255ACA9AD@oracle.com>
References: <379F21DD-006F-4E33-9BD5-F81F9BA75C10@oracle.com>
 <20190220134454.GF12668@bombadil.infradead.org>
 <07B3B085-C844-4A13-96B1-3DB0F1AF26F5@oracle.com>
 <20190220144345.GG12668@bombadil.infradead.org>
 <20190220163921.GA4451@localhost.localdomain>
 <20190220171905.GJ12668@bombadil.infradead.org>
 <B53C9F2D-966C-4DFD-8151-0A7255ACA9AD@oracle.com>
Message-ID: <CAPhsuW6uDeXrRU9pd-kPOzjJn3DVdx0O5Lny_hpyQ=Fpbhg4gw@mail.gmail.com>

Hi William,

On Mon, Apr 8, 2019 at 4:37 AM William Kucharski
<william.kucharski@oracle.com> wrote:
>
>
>
> > On Feb 20, 2019,@10:19 AM, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Yes, on reflection, NVMe is probably an example where we'd want to send
> > three commands (one for the critical page, one for the part before and one
> > for the part after); it has low per-command overhead so it should be fine.
> >
> > Thinking about William's example of a 1GB page, with a x4 link running
> > at 8Gbps, a 1GB transfer would take approximately a quarter of a second.
> > If we do end up wanting to support 1GB pages, I think we'll want that
> > low-priority queue support ... and to qualify drives which actually have
> > the ability to handle multiple commands in parallel.
>
> I just got my denial for LSF/MM, so I was hopeful someone who will
> be attending can talk to the filesystem folks in an effort to determine what
> the best approach may be going forward for filling a PMD sized page to satisfy
> a page fault.
>
> The two obvious solutions are to either read the full content of the PMD
> sized page before the fault can be satisfied, or as Matthew suggested
> perhaps satisfy the fault temporarily with a single PAGESIZE page and use a
> readahead to populate the other 511 pages. The next page fault would then
> be satisfied by replacing the PAGESIZE page already mapped with a mapping for
> the full PMD page.
>
> The latter approach seems like it could be a performance win at the sake of some
> complexity. However, with the advent of faster storage arrays and more SSD, let
> alone NVMe, just reading the full contents of a PMD sized page may ultimately be
> the cleanest way to go as slow physical media becomes less of a concern in the
> future.
>
> Thanks in advance to anyone who wants to take this issue up.

We will bring this proposal up in THP discussions. Would you like to share more
thoughts on pros and cons of the two solutions? Or in other words, do you have
strong reasons to dislike either of them?

Thanks,
Song
