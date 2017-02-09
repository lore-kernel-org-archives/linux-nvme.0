From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 8 Feb 2017 23:18:19 -0800
Subject: [PATCH v2] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
In-Reply-To: <1486594815-2427-1-git-send-email-scott.bauer@intel.com>
References: <1486594815-2427-1-git-send-email-scott.bauer@intel.com>
Message-ID: <20170209071819.GA20996@infradead.org>

I'm really not a fan of adding a global synchronization point for
no good reason.  Arnd's original patch looks fine to me, but if you
really don't want it I'd suggest to use memdup_user and just
dynamically allocate the structure.
