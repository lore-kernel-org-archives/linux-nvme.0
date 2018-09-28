From: hch@lst.de (Christoph Hellwig)
Date: Fri, 28 Sep 2018 17:19:00 +0200
Subject: [PATCH 2/2] nvmet: don't split large I/Os unconditionally
In-Reply-To: <20180928004407.25237-1-sagi@grimberg.me>
References: <20180928004407.25237-1-sagi@grimberg.me>
Message-ID: <20180928151900.GA8279@lst.de>

On Thu, Sep 27, 2018@05:44:07PM -0700, Sagi Grimberg wrote:
> If we know that the I/O size exceeds our inline bio vec, no
> point using it and split the rest to begin with.

In theory there would be a point if the I/O size did exactly fit
the inline bio + a maximum size allocated bio.  Probably not worth
optimizing for, but maybe worth an updated changelog.
