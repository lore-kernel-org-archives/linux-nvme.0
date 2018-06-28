From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 28 Jun 2018 14:55:59 -0600
Subject: [PATCH v5 2/2] nvme: trace: add disk name to tracepoints
In-Reply-To: <20180628074824.crqwgdlnrqt34s3d@linux-x5ow.site>
References: <20180627125324.22064-1-jthumshirn@suse.de>
 <20180627125324.22064-3-jthumshirn@suse.de>
 <20180627163706.GA9361@localhost.localdomain>
 <20180628074824.crqwgdlnrqt34s3d@linux-x5ow.site>
Message-ID: <20180628205559.GD12970@localhost.localdomain>

On Thu, Jun 28, 2018@09:48:24AM +0200, Johannes Thumshirn wrote:
> On Wed, Jun 27, 2018@10:37:06AM -0600, Keith Busch wrote:
> > It looks like you want the # assigned to /dev/nvme<#>. Do you want to
> > use ctrl->instance here instead?
> 
> Right.
> 
> As it'll conflict with your other trace patch do you want me to wait
> with the resend?

I tried to merge your disk names but it got substantially different
after I combined the two submission trace points into one (I sort of
prefer having only one). I'm about to send it out, and I hope I was able
to preserve your intention, but please have a look and let me know.
