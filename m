From: keith.busch@intel.com (Keith Busch)
Date: Mon, 20 Nov 2017 13:21:28 -0700
Subject: parse_and_open without closing the fd
In-Reply-To: <13087d0e-c7e7-521b-e029-6f6a71e153ba@oracle.com>
References: <1c333ba1-5371-fa03-12fa-72ae42c7cc52@oracle.com>
 <20171120201333.GB12587@localhost.localdomain>
 <13087d0e-c7e7-521b-e029-6f6a71e153ba@oracle.com>
Message-ID: <20171120202128.GC12587@localhost.localdomain>

On Mon, Nov 20, 2017@03:11:28PM -0500, Thomas Tai wrote:
> > It's implicitly closed on exit. This is a short-lived one-shot program,
> > so there is some laziness with accounting for all resources that are
> > automatically reclaimed. That said, it's still nice to clean this up as
> > we find such examples.
> > 
> 
> I see. Thanks Keith for your quick response.

Fixed now. :)
