From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Mon, 05 Oct 2015 10:52:48 -0700
Subject: [PATCH 0/5] Modify ida_* users to use ida_simple_*
In-Reply-To: <20151005174426.GB11164@htj.duckdns.org>
References: <cover.1443723136.git.lduncan@suse.com>
 <20151005174426.GB11164@htj.duckdns.org>
Message-ID: <1444067568.2238.25.camel@HansenPartnership.com>

On Mon, 2015-10-05@13:44 -0400, Tejun Heo wrote:
> On Thu, Oct 01, 2015@11:59:04AM -0700, Lee Duncan wrote:
> > The ida index management routines are used in several
> > driver modules to manage allocation and release of
> > index values. Reviewing the way in which the
> > ida routines were called, together with the small
> > number of such clients, led to the belief that
> > these users should all be able to share a simple
> > built-in lock in the ida module by calling the
> > ida_simple_*() functions instead of the non-simple
> > versions. This means that ida does all the
> > required locking so that clients don't have to
> > manage that.
> 
> The whole series looks good to me.  Please feel free to add

Since they're all independent, they can go via the correct trees without
adverse consequences.  It's probably me: 1/5; Jens 2-4/5; Greg 5/5

James
