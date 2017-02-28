From: hch@lst.de (Christoph Hellwig)
Date: Tue, 28 Feb 2017 15:09:37 +0100
Subject: [PATCH 2/2] nvme-loop: fix a possible use-after-free when
 destroying the admin queue
In-Reply-To: <1488214820-3578-2-git-send-email-sagi@grimberg.me>
References: <1488214820-3578-1-git-send-email-sagi@grimberg.me>
 <1488214820-3578-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170228140937.GB20317@lst.de>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
