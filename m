From: mlin@kernel.org (Ming Lin)
Date: Wed, 10 Feb 2016 07:31:05 -0800
Subject: [PATCH 4/4] nvme: split pci module out of core module
In-Reply-To: <20160210151253.GB32064@localhost.localdomain>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-5-git-send-email-mlin@kernel.org>
 <20160210151253.GB32064@localhost.localdomain>
Message-ID: <CAF1ivSZ7SrjaFgvkbwNEQp_M3XfwdoC11ZMGQzjyzK-BeotXGA@mail.gmail.com>

On Wed, Feb 10, 2016@7:12 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, Feb 08, 2016@02:24:44PM -0800, Ming Lin wrote:
>> This splits nvme.ko into 2 modules:
>> nvme-core.ko: the core part
>> nvme.ko: the PCI driver
>
> Do we want to let PCI take the generic "nvme.ko" name? What will the
> other nvme transport modules be called?

Better name would be: nvme_pci.ko, but that may break, for example,
userspace scripts.

nvme_rdma.ko: IB/RoCE/iWARP
nvme_fc.ko: Fibre Channel
nvme_vhost.ko
....

>
> Otherwise, looks good to me.
