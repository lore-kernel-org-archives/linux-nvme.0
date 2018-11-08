From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 8 Nov 2018 01:53:41 -0800
Subject: [PATCH v2 04/11] nvmet: Make kato and AEN processing for use by
 other controllers
In-Reply-To: <1539709883-12424-5-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
 <1539709883-12424-5-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <20181108095341.GD29432@infradead.org>

On Tue, Oct 16, 2018@10:11:16AM -0700, Jay Sternberg wrote:
> Make common process of get/set features available to other controllers by
> making simple functions static inline and others not static and prototypes
> in nvmet.h file
> 
> Also remove static from nvmet_execute_async_event and add prototype to
> nvmet.h to allow used by other controllers

I'd move nvmet_get_feat_kato and nvmet_get_feat_async_event out of
line, just to not bloat the header with too much random sprinkled
implementation bits, given none of this is timing critical.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>
