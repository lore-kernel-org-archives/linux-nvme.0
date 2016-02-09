From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Feb 2016 14:07:21 +0100
Subject: [PATCH 2/4] nvme: export more symbols
In-Reply-To: <56B9E204.4080702@bjorling.me>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-3-git-send-email-mlin@kernel.org>
 <56B9E204.4080702@bjorling.me>
Message-ID: <20160209130721.GA25715@lst.de>

> Can these be exported without _GPL?

No way.  I consider every Linux module a derivative work, but anything
poking into the NVMe internals surely is much as it can.  We better
keep this clear warning sign.
