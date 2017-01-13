From: hch@lst.de (Christoph Hellwig)
Date: Fri, 13 Jan 2017 08:21:45 +0100
Subject: [PATCH 4/5] nvmet: cancel fatal error and flush async work
 before free controller
In-Reply-To: <1484217079-9259-5-git-send-email-sagi@grimberg.me>
References: <1484217079-9259-1-git-send-email-sagi@grimberg.me>
 <1484217079-9259-5-git-send-email-sagi@grimberg.me>
Message-ID: <20170113072145.GA25355@lst.de>

On Thu, Jan 12, 2017@12:31:18PM +0200, Sagi Grimberg wrote:
> Make sure they are not running and we can free the controller
> safely.
> 
> Signed-off-by: Roy Shterman <roys at lightbitslabs.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
