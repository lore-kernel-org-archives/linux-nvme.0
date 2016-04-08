From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 8 Apr 2016 16:11:17 -0700
Subject: [PATCH] NVMe: Skip async events for degraded controllers
In-Reply-To: <1460153396-5070-1-git-send-email-keith.busch@intel.com>
References: <1460153396-5070-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160408231117.GA9149@infradead.org>

On Fri, Apr 08, 2016@04:09:56PM -0600, Keith Busch wrote:
> If the controller is degraded, the driver should stay out of the way so
> the user can recover the drive. This patch skips driver initiated async
> event requests when the drive is in this state.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> This is to fix communication with a specific controller, but I thought
> this was generally applicable anyway. If anyone really wants to see async
> events on degraded controllers, I can provide this as a quirk instead.

Hah, I was going to prepare something fairly similar for Fabrics
enablement, so I'm fine with it.  But a comment on why we're doing
this would be really nice.  I wonder if we should simply have a
wrapper function for the queue_count check that has a descriptive
and has the detailed description might be useful.
