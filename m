From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Oct 2016 19:18:09 -0400
Subject: Weirdness with discard cmd and get log pages
In-Reply-To: <CAG3=cOmGVdQXDvNuzeW2hgfYi7nASGvfgirU__hE5VJnSWue4w@mail.gmail.com>
References: <CAG3=cOkxyNq3heevOOpOMcezTsEktPfsoWAEVjWdTA28KgVwAg@mail.gmail.com>
 <20161013161519.GE17823@localhost.localdomain>
 <CAG3=cOmGVdQXDvNuzeW2hgfYi7nASGvfgirU__hE5VJnSWue4w@mail.gmail.com>
Message-ID: <20161013231808.GG17823@localhost.localdomain>

On Thu, Oct 13, 2016@11:18:43AM -0700, Nisha Miller wrote:
> Yes, that is what I noticed too. I used the nvme-cli command like this:
> 
> nvme dsm /dev/nvme0n1 -a 0,0,0,0 --blocks=4,5,6,7 --slbs=100,200,300,400 --ad
> 
> This turns up as nvme_user_cmd in the driver, which calls
> nvme_map_user_pages to setup the SG list.

Okay, that's what I use too. I'm not observing any issues on a 4.8 kernel
or back to 4.4 either. I've not tested 3.19 though, and the mechanism
it uses to map user buffers is completely different. Could you verify if
your observation exists in a more current stable release?
