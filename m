From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 25 Apr 2019 07:45:31 +0200
Subject: [PATCH v2 0/2] Adding per-controller timeout support to nvme
In-Reply-To: <db034829-7140-1374-0132-7d27240b8b3b@grimberg.me>
References: <20190403123506.122904-1-mheyne@amazon.de>
 <fb33a464-af65-abec-5ff1-15925e7669a4@grimberg.me>
 <20190424200706.GB15412@localhost.localdomain>
 <983e5d039dce9de1d32c71d28fd59bbc01c3fee5.camel@infradead.org>
 <db034829-7140-1374-0132-7d27240b8b3b@grimberg.me>
Message-ID: <df0c4a9cce5928fdc8ba3a1858e4c6611edb4474.camel@infradead.org>

On Wed, 2019-04-24@13:58 -0700, Sagi Grimberg wrote:
> > It isn't that the media is slow; the max timeout is based on the SLA
> > for certain classes of "fabric" outages. Linux copes *really* badly
> > with I/O errors, and if we can make the timeout last long enough to
> > cover the switch restart worst case, then users are a lot happier.
> 
> Well, what is usually done to handle fabric outages is having multiple
> paths to the storage device, not sure if that is applicable for you or
> not...

Yeah, that turns out to be impractical in this case.

> What do you mean by "Linux copes *really* badly with I/O errors"? What
> can be done better?

There's not a lot that can be done here in the short term. If file
systems get errors on certain I/O, then graceful recovery would be
complicated to achieve.

Better for the I/O timeout to be set higher than the known worst case
time for successful completion.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5174 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190425/8cda76e9/attachment-0001.bin>
