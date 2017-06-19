From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 14:41:38 +0200
Subject: [PATCH rfc 10/30] nvme: Add admin_tagset pointer to nvme_ctrl
In-Reply-To: <1497799324-19598-11-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-11-git-send-email-sagi@grimberg.me>
Message-ID: <20170619124138.GJ29061@lst.de>

On Sun, Jun 18, 2017@06:21:44PM +0300, Sagi Grimberg wrote:
> Will be used when we centralize control flows. only
> rdma for now.

Should we at some point move the tag_sets themselves to the generic
ctrl instead of just pointers?
