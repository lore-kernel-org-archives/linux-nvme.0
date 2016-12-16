From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Dec 2016 10:48:01 -0500
Subject: [PATCH] nvme: simplify stripe quirk
In-Reply-To: <20161216080753.GB22912@infradead.org>
References: <1481760655-25877-1-git-send-email-keith.busch@intel.com>
 <20161215083236.GA32244@infradead.org>
 <20161215155958.GA29688@localhost.localdomain>
 <20161216080753.GB22912@infradead.org>
Message-ID: <20161216154800.GB8888@localhost.localdomain>

On Fri, Dec 16, 2016@12:07:53AM -0800, Christoph Hellwig wrote:
> So an OEM can take the Intel Cards, and stuff their own values into the
> vendor specific fields?  This sounds bad as you can't rely on the
> existing quirks in any old Linux version (plus FreeBSD or spdk for that
> matter any more).

Yes, these are the same concerns I've raised, and a reason we're in the
process of standardizing the feature.

It's fortunately not common for an OEM to break the decoding assumptions
we were promised, but the problem exists. I think this patch is the best
I can do for these devices.
