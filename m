From: hch@lst.de (Christoph Hellwig)
Date: Wed, 17 Oct 2018 18:37:44 +0200
Subject: [PATCH v2] block: fix rdma queue mapping
In-Reply-To: <c14b6091-781d-580e-833f-d2c6db54a5d2@grimberg.me>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
 <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
 <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
 <66c41a1a-e57d-8526-366c-e15dcded7cec@grimberg.me>
 <c14b6091-781d-580e-833f-d2c6db54a5d2@grimberg.me>
Message-ID: <20181017163744.GB23798@lst.de>

On Mon, Oct 15, 2018@06:04:46PM -0700, Sagi Grimberg wrote:
> Would you prefer we fallback to the naive mapping if the device is not
> using manged affinity?

Yes.
