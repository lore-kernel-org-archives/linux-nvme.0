From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 6 Nov 2012 11:54:13 -0500
Subject: [PATCH] NVMe: Define SMART log
In-Reply-To: <1348685367-29949-1-git-send-email-keith.busch@intel.com>
References: <1348685367-29949-1-git-send-email-keith.busch@intel.com>
Message-ID: <20121106165413.GF1736@linux.intel.com>

On Wed, Sep 26, 2012@12:49:27PM -0600, Keith Busch wrote:
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---

> +	NVME_SMART_CRIT_VOLITILE_MEMORY	= 1 << 4,

Thanks, applied.  I corrected the spelling of 'Volatile'.
