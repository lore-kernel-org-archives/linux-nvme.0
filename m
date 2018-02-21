From: javier@cnexlabs.com (Javier Gonzalez)
Date: Wed, 21 Feb 2018 09:35:04 +0000
Subject: [PATCH v2 0/6] lightnvm: base 2.0 implementation
In-Reply-To: <20180215131200.3354-1-mb@lightnvm.io>
References: <20180215131200.3354-1-mb@lightnvm.io>
Message-ID: <A2E4F5B5-2545-48CC-9514-A5BCDF9A9D02@cnexlabs.com>

> On 15 Feb 2018,@14.11, Matias Bj?rling <mb@lightnvm.io> wrote:
> 
> A couple of patches for 2.0 support for the lightnvm subsystem. They
> form the foundation for the integration.
> 
> The first two patches is preparation for the 2.0 work. The third patch
> implements the 2.0 data structures, the geometry command, and exposes
> the sysfs attributes that comes with the 2.0 specification. Note that
> the attributes between 1.2 and 2.0 are different, and it is expected
> that user-space shall use the version sysfs attribute to know which
> attributes will be available.
> 
> The next two patches removes max_phys_sect and max_rq_size, as they
> not used.
> 
> The last patch implements support for using the nvme namespace logical
> block and metadata fields and sync it with the internal lightnvm
> identify structures.
> 
> Changes since v2:
> 
> - Removed blk_queue_block_size() setup in nvm_init and made sure
>   to only update csecs and sos in on the late setup path. No reason
>   to set it twice. From discussion with Javier.
> - Added two extra patches, that removes max_phys_sect and
>   max_rq_size.
> 
> Changes since v1:
> 
> - pr_err fix from Randy.
> - Address type fix from Javier.
> - Also CC the nvme mailing list.
> 
> Matias Bj?rling (6):
>  lightnvm: make 1.2 data structures explicit
>  lightnvm: flatten nvm_id_group into nvm_id
>  lightnvm: add 2.0 geometry identification
>  lightnvm: remove max_rq_size
>  lightnvm: remove nvm_dev_ops->max_phys_sect
>  nvme: lightnvm: add late setup of block size and metadata
> 
> drivers/lightnvm/core.c          |  61 ++---
> drivers/lightnvm/pblk-init.c     |   9 +-
> drivers/lightnvm/pblk-recovery.c |   8 +-
> drivers/nvme/host/core.c         |   2 +
> drivers/nvme/host/lightnvm.c     | 513 ++++++++++++++++++++++++++++-----------
> drivers/nvme/host/nvme.h         |   2 +
> include/linux/lightnvm.h         |  71 +++---
> 7 files changed, 442 insertions(+), 224 deletions(-)
> 
> --
> 2.11.0
> 

The patches look good. I tested them together with pblk's 2.0 support
and all works as it should.

Reviewed-by: Javier Gonz?lez <javier at cnexlabs.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180221/ab00a287/attachment-0001.sig>
