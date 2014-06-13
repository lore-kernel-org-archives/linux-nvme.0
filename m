From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 13 Jun 2014 09:55:52 -0400
Subject: [PATCH v8] convert nvme driver to blk-mq
In-Reply-To: <20140613132704.GA26689@infradead.org>
References: <1402661396-19207-1-git-send-email-m@bjorling.me>
 <20140613132704.GA26689@infradead.org>
Message-ID: <20140613135552.GC12025@linux.intel.com>

On Fri, Jun 13, 2014@06:27:04AM -0700, Christoph Hellwig wrote:
> On Fri, Jun 13, 2014@02:09:55PM +0200, Matias Bj??rling wrote:
> > Matthew master up to:
> > 
> >   bd67608a6127c994e897c49cc4f72d9095925301
> >   NVMe: Rename io_timeout to nvme_io_timeout
> 
> Willy, is do you plan to send these updates to Linus for 3.16?

The ones in my tree, yes.  Matias' mq conversion, no.
