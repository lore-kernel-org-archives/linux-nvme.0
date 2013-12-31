From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 31 Dec 2013 12:17:16 -0500
Subject: [PATCH RFC 2/5] NVMe: Basic NVMe device hotplug support
In-Reply-To: <20131231133540.GL4945@linux.intel.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
 <1388399240-13828-3-git-send-email-santoshsy@gmail.com>
 <20131231133540.GL4945@linux.intel.com>
Message-ID: <20131231171716.GM4945@linux.intel.com>

On Tue, Dec 31, 2013@08:35:40AM -0500, Matthew Wilcox wrote:
> 	NVME_SC_MASK			= 0xbff

uhh .. 7ff.  Don't know what I was thinking.

Oh, and then we should convert the code in nvme-scsi.c to use the new
macro or constant instead of the bare 7ff that it currently uses.
