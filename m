From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 15 Jun 2017 09:36:54 -0700
Subject: [PATCH 2/2] nvme-core: change commas to semicolons in
 nvme_get_log_page
In-Reply-To: <1497544496-25134-2-git-send-email-sagi@grimberg.me>
References: <1497544496-25134-1-git-send-email-sagi@grimberg.me>
 <1497544496-25134-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170615163654.GB31576@infradead.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>

(although if we kill off the scsi emulation this function will just go
away)
