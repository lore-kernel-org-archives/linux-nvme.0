From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 8 Nov 2018 01:54:56 -0800
Subject: [PATCH v2 06/11] nvmet: Add support to Discovery controllers for
 commands
In-Reply-To: <1539709883-12424-7-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
 <1539709883-12424-7-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <20181108095456.GG29432@infradead.org>

On Tue, Oct 16, 2018@10:11:18AM -0700, Jay Sternberg wrote:
> Add custom get/set features to restrict commands allowed by Discovery
> controllers.

This does't restrict anything, but actually adds the previously
unimplemented commands, doesn't it?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>
