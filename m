From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 7 May 2013 17:05:48 -0400
Subject: [PATCH] NVMe: Use user defined admin ioctl timeout
In-Reply-To: <1367957874-20763-1-git-send-email-keith.busch@intel.com>
References: <1367957874-20763-1-git-send-email-keith.busch@intel.com>
Message-ID: <20130507210548.GH6057@linux.intel.com>

On Tue, May 07, 2013@02:17:54PM -0600, Keith Busch wrote:
> +	timeout = cmd.timeout_ms ? DIV_ROUND_UP(cmd.timeout_ms * HZ, 1000):

We have a fine function called msecs_to_jiffies(), which I'd prefer you to
use instead :-)
