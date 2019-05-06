From: jonathan.derrick@intel.com (Derrick, Jonathan)
Date: Mon, 6 May 2019 19:50:04 +0000
Subject: [PATCH] blktests: Use old variable check for Bash <4.2
In-Reply-To: <20190506194239.GB20450@vader>
References: <1556908108-16475-1-git-send-email-jonathan.derrick@intel.com>
 <20190506194239.GB20450@vader>
Message-ID: <f2126a9f56ad65c58300b8b2216da7fcec081018.camel@intel.com>

On Mon, 2019-05-06@12:42 -0700, Omar Sandoval wrote:
> On Fri, May 03, 2019@12:28:28PM -0600, Jon Derrick wrote:
> > Bash 4.2 and above supports -v variable checks, which returns true
> > for
> > set or null. Instead use an older bashism that is compatible with
> > bash
> > 4.1 and earlier but only returns true if the variable is set non-
> > null.
> > This inherently adds a sanity check in case of null variables.
> 
> Bart previous sent a patch for supporting bash 4.1, and according to
> him, there were some further changes required:
> 
> https://github.com/osandov/blktests/pull/42
> 
> Either Bart's list of missing features was too big, or this patch
> isn't
> enough to support 4.1. If it's the latter, then this is a no-go,
> because
> Bart's change was too intrusive to be worth the hassle. If it's the
> former, then this change isn't quite as bad, but I'm still not
> excited
> about supporting a 10 year old version of Bash.


Mine is more than likely some franken-bash. I tested my changes alone
on a 4.1.2 from RHEL 6.7. RHEL 6.10 is recently released so this
version of Bash is certainly still in use.

I also understand about supporting old bash, so I'm perfectly fine
keeping it out-of-tree and patching in as needed.

Regards
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3278 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190506/d2fc7c26/attachment.bin>
