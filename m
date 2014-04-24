From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 24 Apr 2014 13:43:31 -0400
Subject: Cmd - comp write
In-Reply-To: <CAP8+hKW_GcTMv=ifM_D5ifhnV5cRo8dba3Uc4KzYHDtvXvxpWA@mail.gmail.com>
References: <7212DDF9-6821-4D7E-BD4D-655031AD03F7@gmail.com>
 <20140424135805.GA5886@linux.intel.com>
 <CAP8+hKW_GcTMv=ifM_D5ifhnV5cRo8dba3Uc4KzYHDtvXvxpWA@mail.gmail.com>
Message-ID: <20140424174331.GC5886@linux.intel.com>

On Thu, Apr 24, 2014@10:03:30AM -0700, Learner Study wrote:
> Thanks. So its not really used to optimize SSD write operation
> per-se...correct? Its only used for locking purpose mainly. I'm not
> too familiar with the upper application layers...is "locking" a very
> common operation used in storage work? I would think so - for eg. to
> coordinate writes to namespaces and its accesses, this could be
> used...is that understanding correct?

Locking is almost never used.  Usually one entity controls exclusive
access to the media and coordinates all accesses to it.  The use case
is multipath environments like dual-ported drives or NAS where there may
be multiple independent entities competing for access to the same media.
