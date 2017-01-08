From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 8 Jan 2017 05:32:51 -0800
Subject: [PATCH v4 2/6] block: Add Sed-opal library
In-Reply-To: <20161230210255.GA4148@localhost.localdomain>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-3-git-send-email-scott.bauer@intel.com>
 <20161230210255.GA4148@localhost.localdomain>
Message-ID: <20170108133251.GA19514@infradead.org>

On Fri, Dec 30, 2016@02:02:56PM -0700, Jon Derrick wrote:
> It's a bit nontraditional to lock and unlock in different functions, but
> I see why you're doing it this way.
> 
> Can we move the mutex locking/unlocking to the callers of these
> functions, such that they are both in the same function; then we can use
> lockdep_assert_held(..) on the in-between?

Yes, that sounds like a good idea to me.  Note that sparse would warn
about these unbalanced locks/unlocks without annotations, so I'll use
this opportunity to run sparse over it.  Documentation for it used to
be trivial to find in Documentation/sparse.txt but somehow has
disappeared in the latest kernel tree unfortunately.
