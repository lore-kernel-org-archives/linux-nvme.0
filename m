From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 8 Nov 2018 01:55:30 -0800
Subject: [PATCH v2 07/11] nvmet: Add parent to nvmet_referral_disable
In-Reply-To: <1539709883-12424-8-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
 <1539709883-12424-8-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <20181108095530.GH29432@infradead.org>

On Tue, Oct 16, 2018@10:11:19AM -0700, Jay Sternberg wrote:
> To be used when Discovery Change notifications occur

Looks fine, but I'd be tempted to just merge this into the patch
actually using it.
