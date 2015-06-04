From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 4 Jun 2015 08:39:09 -0700
Subject: [PATCH] NVMe: Add reset controller sysfs entry
In-Reply-To: <alpine.LNX.2.00.1506041518030.15930@localhost.lm.intel.com>
References: <D195D453.84EA%brandon.schulz@hgst.com>
 <alpine.LNX.2.00.1506041518030.15930@localhost.lm.intel.com>
Message-ID: <20150604153909.GA18137@infradead.org>

On Thu, Jun 04, 2015@03:26:03PM +0000, Keith Busch wrote:
> On Thu, 4 Jun 2015, Brandon Schulz wrote:
> >Do you plan to merge this into your legacy tree somewhere that we can
> >reference in Bugzillas/etc. with the Linux distro vendors?
> 
> There is a strong preference with vendors to see fixes upstream prior
> to backporting but this is a long-standing percieved weakness in Linux
> vs. other operating systems; no one wants to reboot their machine for
> a f/w upgrade ... so, okay, I'll apply it to legacy and see if I can
> lobby OSVs to take out-of-stream fixes.

Eww.  Jens, can you please just apply this patch so that we're not
having such a mess?
