From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Sun, 07 Feb 2016 08:04:00 -0800
Subject: complete boot failure in 4.5-rc1 caused by nvme: make SG_IO
 support optional
In-Reply-To: <20160207092241.GA15331@lst.de>
References: <1454783624.2809.6.camel@HansenPartnership.com>
 <20160207092241.GA15331@lst.de>
Message-ID: <1454861040.2329.4.camel@HansenPartnership.com>

On Sun, 2016-02-07@10:22 +0100, Christoph Hellwig wrote:
> Keith said it should be on by default, and I promised him to change
> it once we run into problems, which I guess this counts as.
> 
> But just curious:  what distro are you using?  Upstream systemd
> explicitly rejected using scsi_id for NVMe here:
> 
> 	https://github.com/systemd/systemd/issues/1453
> 
> and all my test systems don't do this either.

This was SUSE (in my case, openSUSE Leap).  I just checked the source
package; they patch the by-id rules back in for NVME:

# PATCH-FIX-SUSE 1101-rules-persistent-device-names-for-NVMe-devices.patch (bsc#944132)
Patch1101:      1101-rules-persistent-device-names-for-NVMe-devices.patch

The bugzilla is giving access denied for bug id 944132, so it's likely
some proprietary vendor problem.  The patch has no preamble, so it's
hard to tell what they were thinking.

James
