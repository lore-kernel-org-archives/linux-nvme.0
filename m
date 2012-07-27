From: jgarzik@pobox.com (Jeff Garzik)
Date: Fri, 27 Jul 2012 16:42:01 -0400
Subject: [PATCH] NVMe: Add a character device for each nvme device
In-Reply-To: <20120727202655.GP22985@linux.intel.com>
References: <1343407458-29909-1-git-send-email-keith.busch@intel.com>
 <20120727181212.GM22985@linux.intel.com> <5012EBD9.8010602@pobox.com>
 <20120727202655.GP22985@linux.intel.com>
Message-ID: <5012FD19.5090100@pobox.com>

On 07/27/2012 04:26 PM, Matthew Wilcox wrote:
> Maybe we should design such a mechanism, but maybe we shouldn't ... as we
> find common things to do, we tend to move those to sysfs, not ioctls,
> and the kinds of commands that are being sent here are essentially
> vendor-specific NVMe commands; it's not clear they'd fit neatly into a
> generic mechanism.

You're delivering arbitrary packets to the device from userspace, and it 
is returning arbitrary packets to userspace.

This is a familiar pattern...  It is quite analagous to "send 
vendor-specific commands from userspace to a drive"

	Jeff
