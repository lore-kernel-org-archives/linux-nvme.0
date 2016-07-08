From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 8 Jul 2016 08:47:35 -0500
Subject: [PATCH 2/5] nvme: add new reconnecting controller state
In-Reply-To: <1467809752-31320-3-git-send-email-hch@lst.de>
References: <1467809752-31320-1-git-send-email-hch@lst.de>
 <1467809752-31320-3-git-send-email-hch@lst.de>
Message-ID: <003601d1d91f$48a34c10$d9e9e430$@opengridcomputing.com>

> 
> The nvme fabric (RDMA, FC, etc...) can introduce port, link or node
> failures that may require a reconnect to re-establish the connection.
> 
> Add a new reconnecting state that will initially be used by the RDMA
> driver.
> 
> Reviewed-by: Jay Freyensee <james.p.freyensee at intel.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
>

Looks good.

Reviewed-by: Steve Wise <swise at opengridcomputing.com>
