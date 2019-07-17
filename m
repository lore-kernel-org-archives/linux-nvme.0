From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 17 Jul 2019 10:15:00 +1000
Subject: nvme-5.3 ssd performance regression
In-Reply-To: <CACVXFVP8w3mzQ8XVgeif=Nq3kyiZopS0XDB+-c2x5CcT9V3djA@mail.gmail.com>
References: <798a3907573b910fbb102036afe3dfc1405fb353.camel@kernel.crashing.org>
 <CACVXFVP8w3mzQ8XVgeif=Nq3kyiZopS0XDB+-c2x5CcT9V3djA@mail.gmail.com>
Message-ID: <6863e5fa43409c370395cc66e7499dd7c150c497.camel@kernel.crashing.org>

On Tue, 2019-07-16@15:12 +0800, Ming Lei wrote:
> I feel we might need the max segment size limit too.
> 
> commit 7637de311bd2124b298a072852448b940d8a34b9
> Author: Christoph Hellwig <hch at lst.de>
> Date:   Wed Jul 3 09:54:44 2019 -0700
> 
>     nvme-pci: limit max_hw_sectors based on the DMA max mapping size

Yes. Reverting this brings the speed back to 2GB/s

Cheers,
Ben.
