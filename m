From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Jun 2017 08:33:54 +0200
Subject: [PATCH v1 1/7] nvme: rename uuid to nguid in nvme_ns
In-Reply-To: <7e97c34f8ab586615cb57b22a36db2eeb0ccc57f.1496237370.git.jthumshirn@suse.de>
References: <cover.1496237370.git.jthumshirn@suse.de>
 <7e97c34f8ab586615cb57b22a36db2eeb0ccc57f.1496237370.git.jthumshirn@suse.de>
Message-ID: <20170601063354.GA16778@lst.de>

On Wed, May 31, 2017@03:32:11PM +0200, Johannes Thumshirn wrote:
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

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
