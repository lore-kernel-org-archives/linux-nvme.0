From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 2 May 2017 01:17:33 -0700
Subject: [PATCH 2/2] nvmf: keep track of nvmet connect error status
In-Reply-To: <1493687595-11088-2-git-send-email-guanjunxiong@huawei.com>
References: <1493687595-11088-1-git-send-email-guanjunxiong@huawei.com>
 <1493687595-11088-2-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170502081733.GB30105@infradead.org>

On Tue, May 02, 2017@09:13:15AM +0800, Guan Junxiong wrote:
> To let the host know what happends to the connection establishment,
> adjust the behavior of nvmf_log_connect_error to make more connect
> specifig error codes human-readble.

Looks fine (module a few indentation issue that can easily be fixed up
when applying).

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
