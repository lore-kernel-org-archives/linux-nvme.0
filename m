From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 16 Oct 2017 05:46:21 -0700
Subject: [PATCH 4.14-rc] nvme-rdma: stop controller reset if the
 controller is deleting
In-Reply-To: <1507715391-430-1-git-send-email-sagi@grimberg.me>
References: <1507715391-430-1-git-send-email-sagi@grimberg.me>
Message-ID: <20171016124621.GA26833@infradead.org>

On Wed, Oct 11, 2017@12:49:51PM +0300, Sagi Grimberg wrote:
> If the controller is deleting (in case the user decided to delete
> it), we have no point to continue reset sequence.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks good and mirrors what we do in reconnect.

I'll apply it to nvme-4.14.
