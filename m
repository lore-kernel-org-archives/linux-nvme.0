From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 8 Nov 2018 01:50:39 -0800
Subject: [PATCH v2 02/11] nvmet: Change aen mask functions to use bit
 numbers
In-Reply-To: <1539709883-12424-3-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
 <1539709883-12424-3-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <20181108095039.GB29432@infradead.org>

On Tue, Oct 16, 2018@10:11:14AM -0700, Jay Sternberg wrote:
> Functions nvmet_aen_disabled and nvmet_clear_aen were using
> values not bit numbers ie 1 << 9 not 9 for bit function clear_bit
> and test_and_set_bit.
> 
> Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
> Reviewed-by: Phil Cayton <phil.cayton at intel.com>

Can you please explace the usage of the weird BIT() macro with the
much more obvious 1 << bit as in the rest of the nvme code?

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
