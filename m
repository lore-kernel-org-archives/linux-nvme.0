From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 14:49:10 +0200
Subject: [PATCH rfc 20/30] nvme: add err, reconnect and delete work
 items to nvme core
In-Reply-To: <1497799324-19598-21-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-21-git-send-email-sagi@grimberg.me>
Message-ID: <20170619124910.GR29061@lst.de>

On Sun, Jun 18, 2017@06:21:54PM +0300, Sagi Grimberg wrote:
> We intent for these handlers to become generic, thus, add them to
> the nvme core controller struct.

Do you remember why we actually need all the different work items?

We need err_work to recover from RDMA QP-level errors.  But how
is it so different from a reset in that respect?  Similarly why
do we need reset to be different from reconnect?  Especially as
reconnect sort of is the reset of fabrics.
