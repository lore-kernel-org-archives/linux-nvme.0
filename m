From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 7 Apr 2017 00:27:29 -0700
Subject: [PATCH v2] nvme_fc: avoid double kfree(), don't call
 nvme_cleanup_cmd() in nvme_fc_unmap_data()
In-Reply-To: <1491497276-15944-1-git-send-email-emilne@redhat.com>
References: <1491497276-15944-1-git-send-email-emilne@redhat.com>
Message-ID: <20170407072729.GA2574@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
