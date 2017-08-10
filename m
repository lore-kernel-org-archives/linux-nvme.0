From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 10 Aug 2017 01:59:50 -0700
Subject: Bug Report: can't unload nvme module in case of disabled device
In-Reply-To: <f28ebc80-0e67-8af7-79b2-a4b368e4bd83@mellanox.com>
References: <f28ebc80-0e67-8af7-79b2-a4b368e4bd83@mellanox.com>
Message-ID: <20170810085950.GB12494@infradead.org>

Is this a PCIe or fabrics controller?  Did you get a chance to bisect
where this behavior appeared?
