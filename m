From: axboe@fb.com (Jens Axboe)
Date: Thu, 11 Feb 2016 08:07:54 -0700
Subject: [PATCH v3 0/4] split pci module out of core module
In-Reply-To: <1455127412-23940-1-git-send-email-mlin@kernel.org>
References: <1455127412-23940-1-git-send-email-mlin@kernel.org>
Message-ID: <56BCA3CA.4020808@fb.com>

On 02/10/2016 11:03 AM, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
>
> We'll have nvme over fabrics dirver soon.
> This series split nvme pci module out of nvme core module.
>
> nvme.ko is split into 2 modules:
> nvme-core.ko: the core part
> nvme.ko: the PCI driver

Applied for 4.6.

-- 
Jens Axboe
