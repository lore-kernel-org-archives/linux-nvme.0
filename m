From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 26 Jul 2012 12:24:55 -0400
Subject: [PATCH] NVMe: replace nvme_ns with nvme_dev for user admin
In-Reply-To: <1343254075-439-1-git-send-email-keith.busch@intel.com>
References: <1343254075-439-1-git-send-email-keith.busch@intel.com>
Message-ID: <20120726162455.GF22985@linux.intel.com>

On Wed, Jul 25, 2012@04:07:55PM -0600, Keith Busch wrote:
> The function nvme_user_admin_command does not require a namespace to proceed.
> Replace with the nvme_dev structure so that it can be called from contexts that
> do not have a namespace.

Thanks, applied.
