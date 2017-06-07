From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 7 Jun 2017 16:47:51 +0300
Subject: [PATCH v2 2/8] nvme: rename uuid to nguid in nvme_ns
In-Reply-To: <20170601111750.20880-3-jthumshirn@suse.de>
References: <20170601111750.20880-1-jthumshirn@suse.de>
 <20170601111750.20880-3-jthumshirn@suse.de>
Message-ID: <CAHp75VfcXQNPjJd4-7okeifmEBdCtCVkJVR6hMb=jmDryt71oQ@mail.gmail.com>

On Thu, Jun 1, 2017@2:17 PM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> The uuid field in the nvme_ns structure represents the nguid field
> from the identify namespace command. And as NVMe 1.3 introduced an
> UUID in the NVMe Namespace Identification Descriptor this will
> collide.
>
> So rename the uuid to nguid to prevent any further
> confusion. Unfortunately we export the nguid to sysfs in the uuid
> sysfs attribute, but this can't be changed anymore without possibly
> breaking existing userspace.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Hannes Reinecke <hare at suse.com>

I suppose it should go through UUID tree?

-- 
With Best Regards,
Andy Shevchenko
