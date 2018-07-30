From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 30 Jul 2018 08:54:44 -0700
Subject: [PATCH V2 2/3] nvme-core: set gendisk read only based on nsattr
In-Reply-To: <20180727025656.9334-3-chaitanya.kulkarni@wdc.com>
References: <20180727025656.9334-1-chaitanya.kulkarni@wdc.com>
 <20180727025656.9334-3-chaitanya.kulkarni@wdc.com>
Message-ID: <20180730155444.GB29445@infradead.org>

On Thu, Jul 26, 2018@07:56:55PM -0700, Chaitanya Kulkarni wrote:
> NVMe 1.3 TP 4005 introduces new filed (NSATTR). This field indicates
> whether given namespace is write protected or not. This patch sets the
> gendisk associated with the namespace to read only based on the identify
> namespace nsattr field structure to set the.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
