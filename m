From: keith.busch@intel.com (Keith Busch)
Date: Fri, 5 Dec 2014 00:30:42 +0000 (UTC)
Subject: NVM Express 1.2 - Controller Memory Buffer Functionality.
In-Reply-To: <75526C13-EF09-4050-855B-CA71DD60A290@pmcs.com>
References: <36F6EBABA23FEF4391AF72944D2289016EC8C680@BBYEXM01.pmc-sierra.internal>,
 <alpine.LNX.2.00.1412042256430.4225@localhost.lm.intel.com>
 <75526C13-EF09-4050-855B-CA71DD60A290@pmcs.com>
Message-ID: <alpine.LNX.2.00.1412050022300.4225@localhost.lm.intel.com>

On Thu, 4 Dec 2014, Stephen Bates wrote:
> Keith
>
> Ah, very much a case of "be careful what you ask for" ;-). OK I will start to look at this soon.  One issue I can forsee is lack of 1.2 compliant drives to do testing on. Does anyone have any ideas how best to handle that?

I often implement h/w features on a virtual device if real h/w is not
available. If you're interested, I'll add CMB to my QEMU tree sometime
in the next week.

> Cheers
> Stephen
