From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 13 Feb 2016 01:59:24 -0800
Subject: [PATCH 2/2] NVMe: NULL pointer check for admin queues
In-Reply-To: <1455231626-7166-2-git-send-email-keith.busch@intel.com>
References: <1455231626-7166-1-git-send-email-keith.busch@intel.com>
 <1455231626-7166-2-git-send-email-keith.busch@intel.com>
Message-ID: <20160213095924.GB15206@infradead.org>

On Thu, Feb 11, 2016@04:00:26PM -0700, Keith Busch wrote:
> Admin commands don't have a namespace, so don't check the state when
> there isn't one.
> 
> An admin command that does happen to make it to a disabled queue can
> failed immediatly: Initialization commands should not be requeued
> across resets as they would mess up the controller if/when it is
> reinitialized. If a user command made hits this condition, it should
> be able to handle this error as that's the existing result for commands
> when the controller is reset with outstanding admin commands.

Looks fine, but I'd say fold this directly into the respin of the patch
introducing the check.
