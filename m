From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 31 Mar 2017 00:01:28 -0700
Subject: [PATCH v7 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <1490895961-28828-1-git-send-email-helen.koike@collabora.com>
References: <20170330173324.GH20181@localhost.localdomain>
 <1490895961-28828-1-git-send-email-helen.koike@collabora.com>
Message-ID: <20170331070128.GA28852@infradead.org>

I'd still prefer to not hide the MMIO path behind nvme_write_doorbell,
but except for that this looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
