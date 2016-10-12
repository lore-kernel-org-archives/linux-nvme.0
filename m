From: keith.busch@intel.com (Keith Busch)
Date: Wed, 12 Oct 2016 11:16:22 -0400
Subject: [PATCH] nvme: Stop probing a removed device
In-Reply-To: <01aeea30-b515-6d9d-0676-2fa00743bc32@fb.com>
References: <1476207118-10113-1-git-send-email-keith.busch@intel.com>
 <01aeea30-b515-6d9d-0676-2fa00743bc32@fb.com>
Message-ID: <20161012151622.GB12429@localhost.localdomain>

On Wed, Oct 12, 2016@08:40:57AM -0600, Jens Axboe wrote:
> On 10/11/2016 11:31 AM, Keith Busch wrote:
> > There is no reason the nvme controller can ever return all 1's from
> > reading the CSTS register. This patch returns an error if we observe
> > that status. Without this, we may incorrectly proceed with controller
> > initialization and unnecessarilly rely on error handling to clean this.
> 
> Applied for this series.
> 
> Due to being away for a bit, I'm currently a bit behind on patches. I'll
> be going over those today. But if you, or anyone else, have things
> pending that I haven't picked up yet, do send me a ping.

Thanks! From me, I have two small patches I think are good to go, with
reviews from Christoph and others:

IO queue deltion fix:

  http://lists.infradead.org/pipermail/linux-nvme/2016-October/006549.html

Double reset fix:

  http://lists.infradead.org/pipermail/linux-nvme/2016-October/006524.html

I've been trying to catch up on everything else, and haven't finished
reviewing the latest proposals either. I do like Bart's block quiesce
patch series and lightly tested it, but haven't had time to provide any
feedback. I don't want to be in the way if everyone else is okay with it,
or I'll have time next week if it's not hoping to go in this merge window.
