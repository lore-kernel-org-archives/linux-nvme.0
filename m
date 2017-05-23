From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 23 May 2017 02:42:55 -0700
Subject: NVMe APST high latency power states being skipped
In-Reply-To: <CAAd53p6uX1pKGAaNhYfT0VSRYD8A2e2Ykacak-pqW4GOXFJPug@mail.gmail.com>
References: <CAAd53p5pxgO-n0K4khAsYAcWw64tNJwtPwbMHaPksVQMLeXJmA@mail.gmail.com>
 <20170523071705.GD16776@infradead.org>
 <CAAd53p6uX1pKGAaNhYfT0VSRYD8A2e2Ykacak-pqW4GOXFJPug@mail.gmail.com>
Message-ID: <20170523094255.GA12958@infradead.org>

On Tue, May 23, 2017@04:06:27PM +0800, Kai-Heng Feng wrote:
> I have no idea about the performance impact though. Is there any
> benchmark test storage power management latency?

Mostly I want to verify this using some normal workloads - e.g. kernel
compiles are always the kernel hackers favourite, and some application
runs that are easily verifyable, e.g. video playback might be an
interesting one.
