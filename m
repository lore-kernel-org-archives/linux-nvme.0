From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 22 Jan 2015 23:57:08 -0800
Subject: [PATCH 1/1] NVMe: Do not take nsid while a passthrough IO
 command is being issued via a block device file descriptor
In-Reply-To: <1421971328-5065-1-git-send-email-yan@purestorage.com>
References: <1421971328-5065-1-git-send-email-yan@purestorage.com>
Message-ID: <20150123075708.GA17232@infradead.org>

On Thu, Jan 22, 2015@04:02:08PM -0800, Yan Liu wrote:
> When a passthrough IO command is issued with a specific block device file descriptor. It should be applied at
> the namespace which is associated with that block device file descriptor. This patch makes such passthrough
> command ignore nsid in nvme_passthru_cmd structure. Instead it takes the namespace ID asscoiated with the
> block device descriptor.
> 
> Signed-off-by: Yan Liu <yan at purestorage.com>

Please move the code to find the ns into the caller, or even better a
seaprate helper used by the caller. instead of adding another argument to
nvme_user_cmd.
