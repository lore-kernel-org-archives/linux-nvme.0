From: keith.busch@intel.com (Keith Busch)
Date: Mon, 25 Sep 2017 10:47:27 -0600
Subject: [PATCH] nvme: use menu Kconfig interface
In-Reply-To: <1c39a10d-6782-3737-80f7-e29fe0d12980@infradead.org>
References: <1c39a10d-6782-3737-80f7-e29fe0d12980@infradead.org>
Message-ID: <20170925164727.GF8463@localhost.localdomain>

On Fri, Sep 22, 2017@06:04:43PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap at infradead.org>
> 
> Add a menu interface for NVME host and target support so that it is
> presented to users more like other Kconfig symbols.
> This makes the Device Driver menu less cluttered (easier to read)
> and keeps all of these symbols grouped together.
> 
> Signed-off-by: Randy Dunlap <rdunlap at infradead.org>

Thanks, looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
