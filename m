From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 16 Feb 2017 19:46:15 +0000
Subject: hch's native NVMe multipathing [was: Re: [PATCH 1/2] Don't
 blacklist nvme]
In-Reply-To: <20170216123702.GA12047@redhat.com>
References: <1487107154-24883-1-git-send-email-keith.busch@intel.com>
 <20170215145617.GA4241@infradead.org> <20170216025357.GA9241@redhat.com>
 <d1f39bbd-d5fe-06d7-34a7-484b723886c9@sandisk.com>
 <20170216123702.GA12047@redhat.com>
Message-ID: <1487274356.2612.5.camel@sandisk.com>

On Thu, 2017-02-16@07:37 -0500, Mike Snitzer wrote:
> Weird.  I did push back on those changes initially (just felt like
> churn) but I ultimately did take them:
> 
> $ git log --oneline --author=bart drivers/md/dm-mpath.c
> 6599c84 dm mpath: do not modify *__clone if blk_mq_alloc_request() fails
> 4813577 dm mpath: change return type of pg_init_all_paths() from int to void
> 9f4c3f8 dm: convert wait loops to use autoremove_wake_function()
> 
> Did I miss any?

Hello Mike,

Thank you for having accepted these patches. However, I was not referring
to these patches but to the eight patches available at
https://github.com/bvanassche/linux/tree/dm-mpath

Bart.
