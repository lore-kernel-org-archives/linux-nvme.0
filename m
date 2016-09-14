From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Sep 2016 16:23:06 +0200
Subject: [PATCH, RFC] nvme: Do not test the read-ahead flag in cmd_flags
In-Reply-To: <30c2c70d-ec2d-607b-3f2f-5b3daa1754cd@sandisk.com>
References: <30c2c70d-ec2d-607b-3f2f-5b3daa1754cd@sandisk.com>
Message-ID: <20160914142306.GA28616@lst.de>

On Wed, Sep 14, 2016@12:02:22PM +0200, Bart Van Assche wrote:
> REQ_RAHEAD is a bio-only flag (bio.bi_opf) and hence is never set in
> request.cmd_flags. Hence remove the cmd_flags & REQ_RAHEAD tests.
> Compile-tested only.

It's indeed a bug, but the questions is if why we shouldn't pass
REQ_RAHEAD down to the request layer.  It's a useful attribute,
and NVMe devices could make use of it.
