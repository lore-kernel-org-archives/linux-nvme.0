From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 6 May 2019 12:57:12 -0700
Subject: [PATCH] blktests: Use old variable check for Bash <4.2
In-Reply-To: <f2126a9f56ad65c58300b8b2216da7fcec081018.camel@intel.com>
References: <1556908108-16475-1-git-send-email-jonathan.derrick@intel.com>
 <20190506194239.GB20450@vader>
 <f2126a9f56ad65c58300b8b2216da7fcec081018.camel@intel.com>
Message-ID: <20190506195712.GC20450@vader>

On Mon, May 06, 2019@07:50:04PM +0000, Derrick, Jonathan wrote:
> On Mon, 2019-05-06@12:42 -0700, Omar Sandoval wrote:
> > On Fri, May 03, 2019@12:28:28PM -0600, Jon Derrick wrote:
> > > Bash 4.2 and above supports -v variable checks, which returns true
> > > for
> > > set or null. Instead use an older bashism that is compatible with
> > > bash
> > > 4.1 and earlier but only returns true if the variable is set non-
> > > null.
> > > This inherently adds a sanity check in case of null variables.
> > 
> > Bart previous sent a patch for supporting bash 4.1, and according to
> > him, there were some further changes required:
> > 
> > https://github.com/osandov/blktests/pull/42
> > 
> > Either Bart's list of missing features was too big, or this patch
> > isn't
> > enough to support 4.1. If it's the latter, then this is a no-go,
> > because
> > Bart's change was too intrusive to be worth the hassle. If it's the
> > former, then this change isn't quite as bad, but I'm still not
> > excited
> > about supporting a 10 year old version of Bash.
> 
> 
> Mine is more than likely some franken-bash. I tested my changes alone
> on a 4.1.2 from RHEL 6.7. RHEL 6.10 is recently released so this
> version of Bash is certainly still in use.

Ah, I didn't realize RHEL was using that version. In that case, I'm
alright with this patch, since it's not quite as nasty as Bart's change.
Thanks!
