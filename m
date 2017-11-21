From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 21 Nov 2017 17:57:28 +0100
Subject: [PATCH-stable] nvme: Fix memory order on async queue deletion
In-Reply-To: <20171116235710.20224-1-keith.busch@intel.com>
References: <20171116235710.20224-1-keith.busch@intel.com>
Message-ID: <20171121165728.GB23027@kroah.com>

On Thu, Nov 16, 2017@04:57:10PM -0700, Keith Busch wrote:
> This patch is a fix specific to the 3.19 - 4.4 kernels. The 4.5 kernel
> inadvertently fixed this bug differently (db3cbfff5bcc0), but is not
> a stable candidate due it being a complicated re-write of the entire
> feature.

Thanks, now queued up for 4.4-stable.

greg k-h
