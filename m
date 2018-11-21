From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 14:06:24 +0100
Subject: [PATCH v2 11/14] nvme-fabrics: allow user passing data digest
In-Reply-To: <20181120030019.31738-13-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-13-sagi@grimberg.me>
Message-ID: <20181121130624.GF1373@lst.de>

On Mon, Nov 19, 2018@07:00:13PM -0800, Sagi Grimberg wrote:
> From: Sagi Grimberg <sagi at lightbitslabs.com>
> 
> Data digest is a nvme-tcp specific feature, but nothing prevents other
> transports reusing the concept so do not associate with tcp transport
> solely.
> 
> Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
