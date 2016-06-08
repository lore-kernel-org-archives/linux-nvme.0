From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Jun 2016 16:09:46 +0200
Subject: [PATCH 11/11] nvme-fabrics: pass non-blocking flag to connect
 request allocation
In-Reply-To: <575823DD.8080000@gmail.com>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
 <1465389066-19119-12-git-send-email-hch@lst.de> <575823DD.8080000@gmail.com>
Message-ID: <20160608140946.GA1020@lst.de>

On Wed, Jun 08, 2016@04:55:41PM +0300, Sagi Grimberg wrote:
> Looks fine,
>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
>
> Would be nice to reduce the number of arguments
> passed to __nvme_submit_sync_cmd() at some point..

We're only adding them in our series..  But I agree that the number
of arguments is a bit of a mess, but I couldn't really come up with
something better.
