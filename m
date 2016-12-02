From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Dec 2016 15:13:33 +0100
Subject: [PATCH v6 5/7] nvme-fabrics: Add host support for FC transport
In-Reply-To: <20161202085531.nsqx3y5bbcyyhhae@linux-x5ow.site>
References: <584130ba.pS5C8UHrYs5M3Vzp%jsmart2021@gmail.com>
 <20161202085531.nsqx3y5bbcyyhhae@linux-x5ow.site>
Message-ID: <20161202141333.GA12485@infradead.org>

On Fri, Dec 02, 2016@09:55:31AM +0100, Johannes Thumshirn wrote:
> ^^ there's a stray newline, someone should probably fix this up when applying.
> > +	 *    be "in order" for the nvme layer. As the nvme layer in
> > +	 *    linux doesn't care about sqhd, there's no need to return
> > +	 *    them in order.

I think the whole comment is a little overblown as we don't even pass the
CQE up anymore.  I've just fixed up the empty line for now, though.

> Jens, Keith, Sagi, Christoph, how are the chances to get this in for v4.10?

I've applied the patches after editing the changelogs and pushed the code
out to the nvmf-4.10 branch.  But I'd really like a promise from James
that we'll get working controller reset code in the next weeks before
we're sending the code on to Jens.
