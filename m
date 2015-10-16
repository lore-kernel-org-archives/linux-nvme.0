From: keith.busch@intel.com (Busch, Keith)
Date: Fri, 16 Oct 2015 23:47:01 +0000
Subject: [PATCH] Update target repo for nvme patch contributions
In-Reply-To: <1445017711-4371-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1445017711-4371-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <20151016234700.GA13234@localhost.localdomain>

Since willy has taken a spectator role on linux-nvme in favor of
new storage developments, it seems prudent to set the tree to a more
active one.

This is not in drivers/block anymore, so question to Jens: do you want
to take on maintenance for driver/nvme? We've been doing it this way
de-facto for the past year, so if you're okay with listing your tree
for nvme, that's definitely okay with me too.

I'll just throw out for the next merge window that I'm happy to herd all
the nvme patches out there into a pull request in a public tree if that
would help.

I've started this one, so far just with Christoph's latest, plus a fix
from me from the fallout:

  http://git.infradead.org/users/kbusch/linux-nvme.git

I'll be happy to add patches from other developers that appear to have
been left behind as well.

On Fri, Oct 16, 2015@10:48:31AM -0700, Jay Freyensee wrote:
> Per http://www.nvmexpress.org/resources/linux-driver-information/, the
> old nvme git repo is stale.  Updating MAINTAINERS to the Supported
> target currently used by the community.
> 
> Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 601d766..578563b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7441,7 +7441,8 @@ F:	drivers/video/fbdev/nvidia/
>  NVM EXPRESS DRIVER
>  M:	Matthew Wilcox <willy at linux.intel.com>
>  L:	linux-nvme at lists.infradead.org
> -T:	git git://git.infradead.org/users/willy/linux-nvme.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> +W:	https://kernel.googlesource.com/pub/scm/linux/kernel/git/axboe/linux-block/
>  S:	Supported
>  F:	drivers/nvme/host/
>  F:	include/linux/nvme.h
