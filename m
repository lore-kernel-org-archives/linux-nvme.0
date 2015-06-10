From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 Jun 2015 12:08:12 -0700
Subject: [PATCHv2] NVMe: Stripe queue IRQ vector assignments
In-Reply-To: <1433954490-22939-1-git-send-email-jonathan.derrick@intel.com>
References: <1433954490-22939-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20150610190812.GA6200@infradead.org>

On Wed, Jun 10, 2015@10:41:30AM -0600, Jon Derrick wrote:
> a) There is a known issue in one controller where irq coalescing cannot
> occur on vectors to which the admin queue is assigned. This patch assigns
> the admin queue its own vector, as long as there are enough vectors
> available to assign one to each io queue and the admin queue.

I think this should be a quirk for that particular PCI ID, and needs
a comment int the code explaining the reason.
