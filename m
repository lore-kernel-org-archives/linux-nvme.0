From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 8 Dec 2015 12:25:57 -0700
Subject: [PATCH] NVMe: Expose namespace unique identifier to sysfs
In-Reply-To: <20151208191555.GB16241@localhost.localdomain>
References: <1449595605-20735-1-git-send-email-keith.busch@intel.com>
 <20151208185325.GC2457@linux.intel.com>
 <20151208191555.GB16241@localhost.localdomain>
Message-ID: <20151208192557.GA3890@localhost.localdomain>

> > I'm a bit reluctant to use bitmap_empty here, because it's not actually
> > a bitmap.  We almost want the inverse of memchr ("find me the first
> > byte that is non-zero").  Maybe somebody else knows a better functoin
> > to call here?
> 
> Better methods are learned all the time! It was nearly a year ago today
> you suggested bitmap_empty for checking the very same fields. :)
> 

How about memchr_inv? I think Matthew was alluding to that one
