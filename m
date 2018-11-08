From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 8 Nov 2018 01:58:26 -0800
Subject: [PATCH v2 10/11] nvmet: Provide adding AENs for multiple
 controller types
In-Reply-To: <1539709883-12424-11-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
 <1539709883-12424-11-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <20181108095826.GK29432@infradead.org>

On Tue, Oct 16, 2018@10:11:22AM -0700, Jay Sternberg wrote:
> From: Phil Cayton <phil.cayton at intel.com>
> 
> Make nvmet_add_async_event a non-static function in preparation
> for use by other controllers, initally the discovery controller.

Looks fine, but please merge it into the patch actually using the
feature.
