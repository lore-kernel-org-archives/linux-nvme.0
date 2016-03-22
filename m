From: hch@lst.de (Christoph Hellwig)
Date: Tue, 22 Mar 2016 08:38:58 +0100
Subject: [PATCH v2 4/4] nvme: add helper nvme_setup_cmd()
In-Reply-To: <1458631486-14120-5-git-send-email-mlin@kernel.org>
References: <1458631486-14120-1-git-send-email-mlin@kernel.org>
 <1458631486-14120-5-git-send-email-mlin@kernel.org>
Message-ID: <20160322073858.GB23403@lst.de>

Great!  This is exactly how I wanted the interface to the I/O
command set specific setup to look like.

Reviewed-by: Christoph Hellwig <hch at lst.de>
