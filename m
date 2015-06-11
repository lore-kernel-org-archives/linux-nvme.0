From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Jun 2015 18:22:14 +0000 (UTC)
Subject: [PATCHv2] NVMe: Stripe queue IRQ vector assignments
In-Reply-To: <1433954490-22939-1-git-send-email-jonathan.derrick@intel.com>
References: <1433954490-22939-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <alpine.LNX.2.00.1506111812470.15930@localhost.lm.intel.com>

On Wed, 10 Jun 2015, Jon Derrick wrote:
> This patch will stripe io queue IRQ vector assignments across the
> available vector resources. This also changes the current implementation
> which reduces the number of io queues to the number of vectors enabled.
> This fixes another issue where the admin queue and io queue 0 were
> unnecessarily sharing an vector.

Just want to make a couple points, but these concerns shouldn't hold
up acceptance since this is still better than what we had before, and
I don't see an obvious solution to either problem.

1, This will break the irq affinity hints.

2, We don't control or know which CPUs share the h/w queues when you assign
the queue's vector, so we could create sub-optimal sharing.
