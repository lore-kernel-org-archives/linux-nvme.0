From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Feb 2017 09:27:43 +0100
Subject: [PATCH] nvme-rdma: Support 2 inline data SGEs for write commands.
In-Reply-To: <1486507170-23285-1-git-send-email-parav@mellanox.com>
References: <1486507170-23285-1-git-send-email-parav@mellanox.com>
Message-ID: <20170208082743.GB7629@lst.de>

This looks fine to me in general, but I'm a little curious how
your arrived at that 2 number.  Why not 4 or 8?
