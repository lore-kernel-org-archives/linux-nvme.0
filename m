From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 May 2018 11:00:39 -0600
Subject: [PATCH] nvme-pci: Avoid use of goto in nvme_reset_work()
In-Reply-To: <20180510164645.19559-1-mr.nuke.me@gmail.com>
References: <20180510164645.19559-1-mr.nuke.me@gmail.com>
Message-ID: <20180510170038.GA4556@localhost.localdomain>

On Thu, May 10, 2018@11:46:33AM -0500, Alexandru Gagniuc wrote:
> This patch started as a challenge from Keith relating to code
> structuring with goto vs return. I think the final result improves
> readability on two counts:
> First, it clarifies the separation between work struct and nvme_dev.
> Second, it makes it clearer what error is being passed on:
> 'return -ENODEV' vs 'goto out', where 'result' happens to be -ENODEV
> 
> CC: Keith Busch <keith.busch at intel.com>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me at gmail.com>

Ah, that's just wrapping a function that has a single out. The challenge
is to find a better mechanism than 'goto' to unwind a failure that has
multiple outs, like nvme_probe().
