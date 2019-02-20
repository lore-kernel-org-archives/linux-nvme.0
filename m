From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 20 Feb 2019 09:19:05 -0800
Subject: Read-only Mapping of Program Text using Large THP Pages
In-Reply-To: <20190220163921.GA4451@localhost.localdomain>
References: <379F21DD-006F-4E33-9BD5-F81F9BA75C10@oracle.com>
 <20190220134454.GF12668@bombadil.infradead.org>
 <07B3B085-C844-4A13-96B1-3DB0F1AF26F5@oracle.com>
 <20190220144345.GG12668@bombadil.infradead.org>
 <20190220163921.GA4451@localhost.localdomain>
Message-ID: <20190220171905.GJ12668@bombadil.infradead.org>

On Wed, Feb 20, 2019@09:39:22AM -0700, Keith Busch wrote:
> On Wed, Feb 20, 2019@06:43:46AM -0800, Matthew Wilcox wrote:
> > What NVMe doesn't have is a way for the host to tell the controller
> > "Here's a 2MB sized I/O; bytes 40960 to 45056 are most important to
> > me; please give me a completion event once those bytes are valid and
> > then another completion event once the entire I/O is finished".
> > 
> > I have no idea if hardware designers would be interested in adding that
> > kind of complexity, but this is why we also have I/O people at the same
> > meeting, so we can get these kinds of whole-stack discussions going.
> 
> We have two unused PRP bits, so I guess there's room to define something
> like a "me first" flag. I am skeptical we'd get committee approval for
> that or partial completion events, though.
> 
> I think the host should just split the more important part of the transfer
> into a separate command. The only hardware support we have to prioritize
> that command ahead of others is with weighted priority queues, but we're
> missing driver support for that at the moment.

Yes, on reflection, NVMe is probably an example where we'd want to send
three commands (one for the critical page, one for the part before and one
for the part after); it has low per-command overhead so it should be fine.

Thinking about William's example of a 1GB page, with a x4 link running
at 8Gbps, a 1GB transfer would take approximately a quarter of a second.
If we do end up wanting to support 1GB pages, I think we'll want that
low-priority queue support ... and to qualify drives which actually have
the ability to handle multiple commands in parallel.
