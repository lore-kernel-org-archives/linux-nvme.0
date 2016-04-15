From: keith.busch@intel.com (Keith Busch)
Date: Fri, 15 Apr 2016 16:22:42 +0000
Subject: I/O 0 QID 0 timeout, disable controller - kernel 4.4 / 4.5
 NVMe controller dropouts
In-Reply-To: <9EB299CB-C271-4F3D-A91A-5D3F5BD7C120@fastmail.com>
References: <1DC99E13-F6CB-4B7F-AFD7-187825DEE523@fastmail.com>
 <20160414132113.GA21794@localhost.localdomain>
 <570FA450.7080105@fb.com> <20160414152326.GA12458@infradead.org>
 <570FF797.2000109@fb.com>
 <9EB299CB-C271-4F3D-A91A-5D3F5BD7C120@fastmail.com>
Message-ID: <20160415162242.GC30635@localhost.localdomain>

On Fri, Apr 15, 2016@09:38:45AM +1000, Sam McLeod wrote:
> Thank you all involved, is there anything we can set in the mean time to prevent this or do you suggest rolling back to a much older kernel?

Hi Sam,

Until we get the fix submitted to stable, you'll unfortunately have
to use kernels older than 4.4 or use 4.6 when the fix is applied to
mainline. There's no viable work-around without changing the driver.

If you want to apply a kernel patch to your own tree in the meantime,
a possible work-around patch is provided here:

  http://lists.infradead.org/pipermail/linux-nvme/2016-March/004277.html
