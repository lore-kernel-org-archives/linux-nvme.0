From: hch@lst.de (Christoph Hellwig)
Date: Tue, 30 Aug 2016 18:00:25 +0200
Subject: [PATCH WIP/RFC v2 6/6] nvme-rdma: use ib_client API to detect
 device removal
In-Reply-To: <d0bf0b9b-8f81-4d6b-4534-1fccb146e328@grimberg.me>
References: <cover.1472506505.git.swise@opengridcomputing.com>
 <a78624bcccd2262cf54d8db4aa7da753bd6b499a.1472506505.git.swise@opengridcomputing.com>
 <b0f1740f-bcf7-d508-7a64-223202d6c063@grimberg.me>
 <00e601d202d6$00fc0920$02f41b60$@opengridcomputing.com>
 <d0bf0b9b-8f81-4d6b-4534-1fccb146e328@grimberg.me>
Message-ID: <20160830160025.GA17779@lst.de>

On Tue, Aug 30, 2016@06:56:13PM +0300, Sagi Grimberg wrote:
> I'm still not sure if it's a real must. This will only save us the
> condition (as we'll get the device in the client data)

We can skip it for now.
