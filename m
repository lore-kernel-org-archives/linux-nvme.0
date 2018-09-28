From: hch@lst.de (Christoph Hellwig)
Date: Fri, 28 Sep 2018 17:16:18 +0200
Subject: [PATCH 1/2 for-4.19] nvmet: handle bio allocation failure
In-Reply-To: <20180928004056.22968-1-sagi@grimberg.me>
References: <20180928004056.22968-1-sagi@grimberg.me>
Message-ID: <20180928151618.GA8079@lst.de>

On Thu, Sep 27, 2018@05:40:56PM -0700, Sagi Grimberg wrote:
> We cannot rely on bio_alloc to succeed,

Yes, we can (unless it is an atomic allocation or it exceeds
BIO_MAX_PAGES, neither of which we do here).
