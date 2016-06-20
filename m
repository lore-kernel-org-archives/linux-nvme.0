From: keith.busch@intel.com (Keith Busch)
Date: Mon, 20 Jun 2016 11:26:39 -0400
Subject: [PATCH 0/3] nvme: Don't add namespaces for locked drives
In-Reply-To: <20160619230634.17229-1-kernel@jbeekman.nl>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
Message-ID: <20160620152639.GD12936@localhost.localdomain>

On Sun, Jun 19, 2016@04:06:31PM -0700, Jethro Beekman wrote:
> If an NVMe drive is locked with ATA Security, most commands sent to the drive 
> will fail. This includes commands sent by the kernel upon discovery to probe 
> for partitions. The failing happens in such a way that trying to do anything 
> with the drive (e.g. sending an unlock command; unloading the nvme module) is 
> basically impossible with the high default command timeout.

Why is the timeout a factor here? Is it because the error your drive
returns does not have DNR set and goes through 30 seconds of retries?

If so, I think we should probably have a limited retry count instead of
unlimited retries within the command timeout.
 
> This patch adds a check to see if the drive is locked, and if it is, its 
> namespaces are not initialized. It is expected that userspace will send the 
> proper "security send/unlock" command and then reset the controller. Userspace 
> tools are available at [1].

Aren't these security settings per-namespace rather than the entire device?
 
> I intend to also submit a future patch that tracks ATA Security commands sent 
> from userspace and remembers the password so it can be submitted to a locked 
> drive upon pm_resume. (still WIP)

This subjects the system to various attacks like cold boot or hotswap,
but that's what users want!

This is ATA security, though, so wouldn't ATA also benefit from this? The
payload setup/decoding should then go in a generic library for everyone.

Similar was said about the patch adding OPAL security to the NVMe driver:

  http://lists.infradead.org/pipermail/linux-nvme/2016-April/004428.html
