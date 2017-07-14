From: mwilck@suse.de (Martin Wilck)
Date: Fri, 14 Jul 2017 23:21:20 +0200
Subject: [dm-devel] [PATCH 1/4] libmultipath: get_udev_uid: make sure
 pp->wwid is 0-terminated
In-Reply-To: <1500063703.2662.9.camel@wdc.com>
References: <20170714113209.17177-1-mwilck@suse.com>
 <20170714113209.17177-2-mwilck@suse.com> <1500044188.2662.4.camel@wdc.com>
 <1500060099.4808.21.camel@suse.de> <1500063703.2662.9.camel@wdc.com>
Message-ID: <1500067280.4808.27.camel@suse.de>

On Fri, 2017-07-14@20:21 +0000, Bart Van Assche wrote:
> On Fri, 2017-07-14@21:21 +0200, Martin Wilck wrote:
> > 
> > Let's have a strncpy vs. strlcpy discussion :D !
> > 
> > I can do this if you insist, but I don't see a big benefit. We've
> > tested with the patch I submitted.
> 
> My comments were not intended as an invitation to open a strncpy()
> vs. strlcpy()
> discussion. What I wanted to illustrate with the above patch is that
> when using
> strlcpy() it is not necessary to explicitly zero-terminate a string
> because
> strlcpy() guarantees zero-termination. Compact code that is as
> readable as more
> verbose code is always better because compact code is easier to
> verify.

OK. I'll wait for comments on the other patches, and change v2 of this
patch to your version.

Martin
