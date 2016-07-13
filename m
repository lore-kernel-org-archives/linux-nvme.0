From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 13 Jul 2016 09:16:01 -0700
Subject: [PATCH] nvme-fabrics: add-remove ctrl repeat fix
In-Reply-To: <57857F6A.6000406@fb.com>
References: <1467400412-13052-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1468365306.14674.4.camel@linux.intel.com> <57857F6A.6000406@fb.com>
Message-ID: <1468426561.3223.0.camel@linux.intel.com>

On Tue, 2016-07-12@16:38 -0700, Jens Axboe wrote:
> On 07/12/2016 04:15 PM, J Freyensee wrote:
> > On Fri, 2016-07-01@12:13 -0700, Jay Freyensee wrote:
> > 
> > I haven't seen this patch get folded in on the list yet, though
> > Christoph OK'ed the fix, minus the 'Fix by:' I used instead of
> > 'From:'.
> > 
> > Has this been folded into 4.8?  Should I go ahead and re-spin the
> > patch
> > and make the tweak change?  Be nice to eliminate this kernel crash
> > with
> > fabrics being merged into 4.8 kernel.
> 
> It was added into for-4.8/drivers earlier today, with the author 
> attribution fixed.

Thanks Jens!!

> 
