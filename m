From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Nov 2018 23:54:27 -0800
Subject: Two M.2 NVMe drives with same NQN, one gets removed
In-Reply-To: <20181126153110.GM26707@localhost.localdomain>
References: <20181126133839.GA4348@dingwall.me.uk>
 <20181126153110.GM26707@localhost.localdomain>
Message-ID: <20181127075426.GA4173@infradead.org>

On Mon, Nov 26, 2018@08:31:11AM -0700, Keith Busch wrote:
> According to the resolution discussion here:
> 
>   https://downloadcenter.intel.com/download/28320/Known-Issue-Intel-SSD-760p-Pro-7600p-Series-SubNQN-Conflict-on-Linux
> 
>   "
>   If you purchased your Intel? SSD from an OEM, your firmware version may
>   have a different naming. Contact your local OEM representative for
>   latest firmware revisions.
>   "
> 
> Sounds like Lenovo will need to merge the Intel update into their
> specific firmware if they haven't already done so.

OEMs are notoriously bad in picking up firmware fixes.  If the problems
with this drive persist we should probably add a quick that ignores the
drive provided NQN and build up one from based on the legacy
model/serial number algorithm instead.
