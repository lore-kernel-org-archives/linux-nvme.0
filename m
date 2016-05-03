From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 3 May 2016 01:05:52 -0700
Subject: [PATCH v2 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <1461262295.4797.11.camel@ssi>
References: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
 <5718D697.3050800@collabora.co.uk>
 <20160421133823.GA13563@infradead.org>
 <1461262295.4797.11.camel@ssi>
Message-ID: <20160503080552.GA13239@infradead.org>

On Thu, Apr 21, 2016@11:11:35AM -0700, Ming Lin wrote:
> >    agreement on it, although once the basic agreement is there it
> >    shouldn't be too hard to also support the older google specific
> >    version.  And this is no new feedback, a couple of people including
> >    me said that a long time ago, and we've seen zero action on it.
> 
> For "action", did you mean the "agreement" or the spec extension
> proposal?
> 
> I think you'll make the proposal, right?

No, we really need Google to bring it in.

> I made the mess :)
> 
> I thought this before.
> Probably add a new file ext.c and move these code into it.
> 
> Then add a nvme_ext_ops ...

Uh, no.  Just have some inline helpers that do the right thing
for the right "hardware".
