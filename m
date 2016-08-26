From: hch@lst.de (Christoph Hellwig)
Date: Fri, 26 Aug 2016 08:27:45 +0200
Subject: [PATCH 1/2] nvme-rdma: Get rid of duplicate variable
In-Reply-To: <1472161275-6642-2-git-send-email-sagi@grimberg.me>
References: <1472161275-6642-1-git-send-email-sagi@grimberg.me>
 <1472161275-6642-2-git-send-email-sagi@grimberg.me>
Message-ID: <20160826062745.GA11696@lst.de>

On Fri, Aug 26, 2016@12:41:14AM +0300, Sagi Grimberg wrote:
> We already have need_inval in ib_mr, lets use
> that instead.

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
