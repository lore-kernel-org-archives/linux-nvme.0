From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 14 Nov 2014 09:58:58 -0500
Subject: [PATCH] NVMe: Add rw_page support
In-Reply-To: <54655B01.9090206@kernel.dk>
References: <1415923538-18760-1-git-send-email-keith.busch@intel.com>
 <54655B01.9090206@kernel.dk>
Message-ID: <20141114145858.GF11522@wil.cx>

On Thu, Nov 13, 2014@06:29:37PM -0700, Jens Axboe wrote:
> The downside I see is that this is an OOB IO path. Once we start adding IO
> scheduling for those that need that, then this will completely bypass that.

The idea is that you would only enable it for devices that are based on
NVM that is of "near-DRAM" speeds, and can complete small I/Os as fast
as they are issued.  For those kinds of devices, there is absolutely no
value to any kind of IO scheduling.
