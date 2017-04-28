From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 28 Apr 2017 07:30:07 -0700
Subject: [PATCH] nvme-fabrics: keep track of nvmet connect error status
In-Reply-To: <1493356530-8224-1-git-send-email-guanjunxiong@huawei.com>
References: <1493356530-8224-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170428143007.GB30820@infradead.org>

On Fri, Apr 28, 2017@01:15:30PM +0800, Guan Junxiong wrote:
> nvmf target shall return NVME_SC_CONNECT_INVALID_HOST instead of
> the general code INVALID_PARAM. Also, to let the host know what
> happends to the connection establishment, adjust the behavior of
> nvmf_log_connect_error to make more connect specific error codes
> human-readble.
> ---
>  drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
>  drivers/nvme/target/core.c  |  1 +

Please split this into a host and a target side patch.
