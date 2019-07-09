From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Jul 2019 23:21:53 +0200
Subject: [PATCH v2 2/2] nvme-tcp: don't use sendpage for SLAB pages
In-Reply-To: <3206ec8102d4dae933f4638652e84349dcc50ee4.1562586804.git.mskorzhinskiy@solarflare.com>
References: <cover.1562586804.git.mskorzhinskiy@solarflare.com>
 <3206ec8102d4dae933f4638652e84349dcc50ee4.1562586804.git.mskorzhinskiy@solarflare.com>
Message-ID: <20190709212153.GD9518@lst.de>

On Mon, Jul 08, 2019@12:31:29PM +0200, Mikhail Skorzhinskii wrote:
> This change prevents sendpage calls for payload sending too, although this
> is true only for admin commands, so actual data transfer performance
> should be untouched.

XFS can also send slab pages for data.

I've applied to patch to nvme-5.3, but removed the above sentence
from the commit log.
