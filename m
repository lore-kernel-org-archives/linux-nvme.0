From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Dec 2018 09:10:53 +0100
Subject: [PATCH 1/2] nvme: Introduce nvme_is_aen_req function
In-Reply-To: <1e347e83-1f06-3e43-7dfe-fe7b0e6f264f@grimberg.me>
References: <20181212065501.21580-1-nitzanc@mellanox.com>
 <1e347e83-1f06-3e43-7dfe-fe7b0e6f264f@grimberg.me>
Message-ID: <20181212081053.GB29679@lst.de>

On Tue, Dec 11, 2018@11:46:04PM -0800, Sagi Grimberg wrote:
> Don't really see the point of this wrapper... But if
> you are going to introduce it, you need to have others
> use it as well...

I have to say I kinda like the helper.  But yes, we should convert
all the transports over to it.
