From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Sep 2017 22:05:02 +0200
Subject: [PATCH 2/2] nvme-pci: use appropriate initial chunk size for
 HMB allocation
In-Reply-To: <1504538610-15670-3-git-send-email-akinobu.mita@gmail.com>
References: <1504538610-15670-1-git-send-email-akinobu.mita@gmail.com>
 <1504538610-15670-3-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20170904200502.GB16423@lst.de>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>

(It might need some context changes depending on the fate of the
previous patch, but I'll resend it together with other HMB bits if
needed)
