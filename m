From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Nov 2018 15:58:06 +0100
Subject: [PATCH] nvme-rdma: Don't fail the controller if only part of
 the queues fail to connect
In-Reply-To: <f8983f0a-dcb5-7075-1ba3-275f40771068@mellanox.com>
References: <1541349434-31640-1-git-send-email-israelr@mellanox.com>
 <fa4ec36d-29e5-3cbd-742e-33c617d0f82e@broadcom.com>
 <67c9a957-1b61-2632-396c-3c410f6729fa@mellanox.com>
 <20181107090751.GA25759@lst.de>
 <0c0b1ada-c1b2-2f27-098b-ca1859fcd485@mellanox.com>
 <20181108083751.GA3465@lst.de>
 <f8983f0a-dcb5-7075-1ba3-275f40771068@mellanox.com>
Message-ID: <20181108145806.GA11496@lst.de>

On Thu, Nov 08, 2018@04:46:52PM +0200, Max Gurtovoy wrote:
> well we can continue with all or nothing approach. By I'm worried about 
> older kernels and distros that may not have all the needed fixes in the 
> block layer regarding offline CPU mappings.

Well, feel free to keep your patch around for backports then.
