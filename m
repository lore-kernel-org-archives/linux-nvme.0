From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 28 Jul 2016 14:21:54 -0700
Subject: [PATCH] nvme-cli: user-defined hostnqn option for discover
In-Reply-To: <20160728203534.GB2420@localhost.localdomain>
References: <1469736200-6618-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1469736200-6618-2-git-send-email-james_p_freyensee@linux.intel.com>
 <c6c9f9d8-7e02-70da-5972-28f8f9c6550c@mellanox.com>
 <20160728203534.GB2420@localhost.localdomain>
Message-ID: <1469740914.9209.3.camel@linux.intel.com>

On Thu, 2016-07-28@16:35 -0400, Keith Busch wrote:
> On Thu, Jul 28, 2016@11:20:15PM +0300, Roy Shterman wrote:
> > Hi Jay,
> > 
> > Actually I planned to send the same patch tomorrow,
> > 
> > I think we should add user-defined hostnqn parameter into 'connect'
> > command.
> 
> Is it okay to apply this as-is, or should I wait for the patch for
> connect?

I think we should break up the patches as one for discover, and one for
connect.  Each patch can show a usage for each of the commands (one for
'discover', one for 'connect'.

How about apply my discover patch as-is, then Roy re-submit his patch
for connect?  And in the connect patch, supply an example usage (which
I think this will be useful as there is currently no man pages for
these new fabrics commands).


> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
