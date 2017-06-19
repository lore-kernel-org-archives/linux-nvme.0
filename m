From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 14:40:42 +0200
Subject: [PATCH rfc 08/30] nvme-rdma: cleanup error path in controller
 reset
In-Reply-To: <1497799324-19598-9-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-9-git-send-email-sagi@grimberg.me>
Message-ID: <20170619124042.GH29061@lst.de>

On Sun, Jun 18, 2017@06:21:42PM +0300, Sagi Grimberg wrote:
> No need to queue an extra work to indirect controller
> uninit and put the final reference.

Maybe my memory is a little vague, but didn't we need the work_struct
for something?  At least it would serialize all the removals for example.
