From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 4 Jun 2017 14:46:09 +0300
Subject: [PATCH v4 4/8] nvmet: add uuid field to nvme_ns and populate via
 configfs
In-Reply-To: <20170604103649.22130-5-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-5-jthumshirn@suse.de>
Message-ID: <8e0d4531-cc61-8f8a-116d-d0df6946a541@mellanox.com>



On 6/4/2017 1:36 PM, Johannes Thumshirn wrote:
> Add the UUID field from the NVMe Namespace Identification Descriptor
> to the nvmet_ns structure and allow it's population via configfs.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>


Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
