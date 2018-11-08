From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 8 Nov 2018 01:56:04 -0800
Subject: [PATCH v2 08/11] nvmet: Maintain a global list of ports
In-Reply-To: <1539709883-12424-9-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
 <1539709883-12424-9-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <20181108095604.GI29432@infradead.org>

On Tue, Oct 16, 2018@10:11:20AM -0700, Jay Sternberg wrote:
> To be used when Discovery Change notifications occur

Looks fine, but again I'm tempted to move this into the patch
actually using the information.
