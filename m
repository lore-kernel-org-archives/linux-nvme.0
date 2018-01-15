From: keith.busch@intel.com (Keith Busch)
Date: Sun, 14 Jan 2018 19:08:46 -0700
Subject: [PATCH 1/2] nvme: pci: replace magic number with readable size
 macro in hmb code
In-Reply-To: <1515930040-20561-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1515930040-20561-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <20180115020846.GD13580@localhost.localdomain>

On Sun, Jan 14, 2018@08:40:40PM +0900, Minwoo Im wrote:
> Those three identify fields(hmpre, hmmin, hmminds) have size in 4KB
> units.
> 
> Replace magic numbers with human-readable size macro.
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>

Looks fine, though I thought an explicit #include <linux/sizes.h> is
in order since it's not obvious how we're pulling in these defines, but
there's already other SZ_* macro uses in this file, so it must be safe!

Reviewed-by: Keith Busch <keith.busch at intel.com>
