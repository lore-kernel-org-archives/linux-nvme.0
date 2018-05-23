From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 23 May 2018 16:49:46 -0600
Subject: [PATCHv2 0/8] nvme timeout fixes v2
In-Reply-To: <20180523161614.GE11037@localhost.localdomain>
References: <20180522220332.9244-1-keith.busch@intel.com>
 <20180523030057.GF31196@ming.t460p>
 <20180523161614.GE11037@localhost.localdomain>
Message-ID: <20180523224946.GF11037@localhost.localdomain>

On Wed, May 23, 2018@10:16:14AM -0600, Keith Busch wrote:
> On Wed, May 23, 2018@11:00:59AM +0800, Ming Lei wrote:
> > Looks V2 still may trigger IO hang warning:
> 
> Anything in particular that triggered this?
> 
> I'm running IO with io-timeout fault injection, with resets and rescans
> randomly running in the background, so I'm guessing that's not enough.

At the very least, I can see allowing CONNECTING->RESETTING transitions
was a terrible idea. I can get other failures because of that, but not
quite what you're seeing.
