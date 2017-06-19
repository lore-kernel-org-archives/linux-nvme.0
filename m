From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 14:42:50 +0200
Subject: [PATCH rfc 11/30] nvme: move controller cap to struct nvme_ctrl
In-Reply-To: <1497799324-19598-12-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-12-git-send-email-sagi@grimberg.me>
Message-ID: <20170619124250.GK29061@lst.de>

On Sun, Jun 18, 2017@06:21:45PM +0300, Sagi Grimberg wrote:
> Will be used in centralized code later. only rdma
> for now.

It would be great to initialize it early on for all transports, and
then just use the stored field instead of re-reading CAP in various
places.
