From: keith.busch@intel.com (Keith Busch)
Date: Thu, 16 Apr 2015 14:27:21 +0000 (UTC)
Subject: [PATCHv3] NVMe: write_long SCSI to NVMe translation implementation
In-Reply-To: <00aa01d0783d$712a4c40$537ee4c0$@samsung.com>
References: <1427118493-29227-1-git-send-email-sunad.s@samsung.com>
 <006501d06629$b8397550$28ac5ff0$@samsung.com>
 <alpine.LNX.2.00.1503241353070.32385@localhost.lm.intel.com>
 <00aa01d0783d$712a4c40$537ee4c0$@samsung.com>
Message-ID: <alpine.LNX.2.00.1504161417330.32385@localhost.lm.intel.com>

On Thu, 16 Apr 2015, Sunad Bhandary wrote:
> Hi Keith,
>
> I see that this has not been committed yet. Are any changes needed to the
> patch from my side ?

I don't know, I'm not a maintainer. I can only provide acks and reviews.

Honestly I don't see scarring a single block at a time through SG_IO as a
particularly useful feature when NVMe can do entire ranges in one command
with a native passthrough, but it doesn't appear to break anything so
I won't stand in the way.
