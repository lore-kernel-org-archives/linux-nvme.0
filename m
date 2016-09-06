From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 6 Sep 2016 06:36:18 -0700
Subject: [PATCH] nvme: add back dependency on CONFIG_BLOCK
In-Reply-To: <d7099c1b-730f-1617-f683-2447bedd3e6d@grimberg.me>
References: <20160906125827.1595094-1-arnd@arndb.de>
 <d7099c1b-730f-1617-f683-2447bedd3e6d@grimberg.me>
Message-ID: <20160906133618.GA30548@infradead.org>

On Tue, Sep 06, 2016@04:09:26PM +0300, Sagi Grimberg wrote:
> Thanks Arnd, queued for the next round of rc fixes.
> 
> With a slight modification to the component in the subject line
> (nvme-rdma).

Shouldn't we just have a if BLOCK around all the entries in the Kconfig?
