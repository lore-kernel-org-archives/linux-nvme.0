From: hch@lst.de (Christoph Hellwig)
Date: Tue, 30 May 2017 11:25:10 +0200
Subject: [PATCH 3/7] nvmet: add eui64 field to nvme_ns and populate via
 configfs
In-Reply-To: <fe6439add636d3fd31ef357230101819ae7f5090.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <fe6439add636d3fd31ef357230101819ae7f5090.1496131397.git.jthumshirn@suse.de>
Message-ID: <20170530092510.GB16736@lst.de>

On Tue, May 30, 2017@10:08:18AM +0200, Johannes Thumshirn wrote:
> Add the EUI-64 field from the NVMe Namespace Identification Descriptor
> to the nvmet_ns structure and allow it's population via configfs.

Is there any good use case for bothering with this identifier that's
too short to actually be useful?
