From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 13 Feb 2018 16:50:13 +0100
Subject: [PATCH 4.4.y] nvme: Fix managing degraded controllers
In-Reply-To: <20180209213922.12644-1-keith.busch@intel.com>
References: <20180209213922.12644-1-keith.busch@intel.com>
Message-ID: <20180213155013.GE14300@kroah.com>

On Fri, Feb 09, 2018@02:39:22PM -0700, Keith Busch wrote:
> commit 3e1e21c7bfcf upstream

That's not a commit, that is a merge point :(

> Upstream is a near rewrite of the async nvme probe that ultimately didn't
> even cleanly merge in 4.5. This patch is a much smaller change targeted
> to the regression introduced in 4.4.
> 
> If a controller is in a degraded mode that needs admin assistence to
> recover, we need to leave the controller running. We just want to disable
> namespace access without shuting the controller down.
> 
> Fixes: 3cf519b5a8d4("nvme: merge nvme_dev_start, nvme_dev_resume and nvme_async_probe")
> 
> Cc: <stable at vger.kernel.org> # 4.4.x
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Can I get a better commit id to match this up with?

thanks,

greg k-h
