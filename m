From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Nov 2018 08:01:16 +0100
Subject: [PATCH v4 00/13] TCP transport binding for NVMe over Fabrics
In-Reply-To: <20181127231615.9446-1-sagi@grimberg.me>
References: <20181127231615.9446-1-sagi@grimberg.me>
Message-ID: <20181128070116.GB20369@lst.de>

What is the plan ahead here?  I think the nvme code looks pretty
reasonable now (I'll do another pass at nitpicking), but we need the
networking stuff sorted out with at least ACKs, or a merge through
the networking tree and then a shared branch we can pull in.
