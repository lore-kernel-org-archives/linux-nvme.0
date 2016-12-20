From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 19 Dec 2016 22:07:48 -0800
Subject: [PATCH v3 2/5] lib: Add Sed-opal library
In-Reply-To: <20161219213415.GA10634@localhost.localdomain>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
 <20161219213415.GA10634@localhost.localdomain>
Message-ID: <20161220060748.GA4765@infradead.org>

On Mon, Dec 19, 2016@04:34:15PM -0500, Keith Busch wrote:
> This seems like an optional library that some environments may wish to
> opt-out of building into the kernel. Any reason not to add an entry into
> the Kconfig to turn this on/off?

This needs to be a CONFIG_BLOCK_SED / CONFIG_BLOCK_SED_OPAL and
should move to block/.
