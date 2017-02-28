From: hch@lst.de (Christoph Hellwig)
Date: Tue, 28 Feb 2017 15:09:21 +0100
Subject: [PATCH 1/2] nvme-loop: retrieve iod from the cqe command_id
In-Reply-To: <1488214820-3578-1-git-send-email-sagi@grimberg.me>
References: <1488214820-3578-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170228140921.GA20317@lst.de>

On Mon, Feb 27, 2017@07:00:19PM +0200, Sagi Grimberg wrote:
> useful to validate that the we didn't mess up
> the command_id.

But also less efficient, so I don't really see a good reason for it.
