From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Feb 2016 10:26:50 +0100
Subject: [PATCH 4/4] nvme: split pci module out of core module
In-Reply-To: <1454970284-29543-5-git-send-email-mlin@kernel.org>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-5-git-send-email-mlin@kernel.org>
Message-ID: <20160209092650.GE21250@lst.de>

Looks fine,

but as Johannes poined out we'll probably need some Kconfig magic
to keep existing configfs working.
