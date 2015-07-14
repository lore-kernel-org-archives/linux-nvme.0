From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 14 Jul 2015 11:43:44 -0700
Subject: Partitions and end-to-end protection
In-Reply-To: <yq1a8uyshso.fsf@sermon.lab.mkp.net>
References: <55A40881.5000108@ranbarg.com>
 <alpine.LNX.2.00.1507131909210.15930@localhost.lm.intel.com>
 <20150714180634.GB10203@infradead.org>
 <yq1a8uyshso.fsf@sermon.lab.mkp.net>
Message-ID: <20150714184344.GA29437@infradead.org>

On Tue, Jul 14, 2015@02:41:43PM -0400, Martin K. Petersen wrote:
> >>>>> "Christoph" == Christoph Hellwig <hch at infradead.org> writes:
> 
> >> The driver did it this way because we need a disk allocated before we
> >> can subscribe to block integrity extensions.
> 
> The gendisk is a prerequisite by virtue of the integrity profile hanging
> off of it.

Having one allocated is.  But why do we need to have it added (at which
point it is live)?
