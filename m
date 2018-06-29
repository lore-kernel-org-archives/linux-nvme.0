From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Jun 2018 14:03:03 +0200
Subject: Q: Status of ANA patches
In-Reply-To: <0426d517-4c6e-022d-5d42-d1f22053ed1a@suse.de>
References: <0426d517-4c6e-022d-5d42-d1f22053ed1a@suse.de>
Message-ID: <20180629120303.GA22270@lst.de>

On Fri, Jun 29, 2018@01:42:49PM +0200, Hannes Reinecke wrote:
> Hi Christoph,
>
> do you have any timeline for the ANA patches?
> From my last testing they look good so far; the only missing bit is a 
> missing configfs entry for the actual ANATT value.
> For that we could easily resurrect my original patch.
>
> Is there anything else which is holding it up?

An automated test suite to actually test the code reliably is the
important missing bit.
