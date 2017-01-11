From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 11 Jan 2017 09:47:14 -0800
Subject: [PATCH v4 2/6] block: Add Sed-opal library
In-Reply-To: <20170108140507.GA32432@infradead.org>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-3-git-send-email-scott.bauer@intel.com>
 <20170108140507.GA32432@infradead.org>
Message-ID: <1484156834.2793.9.camel@linux.intel.com>

[Snip...]


> > 
> > +	if(!suspend)
> 
> missing whitespace before the (
> 
> > 
> > +	list_for_each_entry(suspend, &dev->unlk_lst, node) {
> > +			dev->state = 0;
> > +			dev->func_data[1] = &suspend->unlk.session;
> 
> doube indentation.
> 

Is checkpatch.pl being used before the patches are sent to the list? ?That tool
should have flagged these problems to fix.

While you are at it, it would be good to run the code thru sparse if you
haven't already.

Jay

> >?
