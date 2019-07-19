From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 19 Jul 2019 15:15:14 +1000
Subject: [PATCH v2] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
In-Reply-To: <BYAPR04MB58166CED3126757BEC56D3A8E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <f19ac710b4dc28fb3b59ef11bd06d341bc939f3d.camel@kernel.crashing.org>
 <BYAPR04MB58168C42A68712287F734242E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <bc856389e6b09f7c545144be0f370f7ad3b05784.camel@kernel.crashing.org>
 <BYAPR04MB58166CED3126757BEC56D3A8E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
Message-ID: <448cfd6b3e798dfbef45fa72e0819b1cb39cf68d.camel@kernel.crashing.org>

On Fri, 2019-07-19@05:01 +0000, Damien Le Moal wrote:
> > I suppose that would work and be simpler. I honestly don't know much
> > about the block layer and tag allocation so I stayed away from it :-)
> > 
> > I'll dig, but a hint would be welcome :)
> 
> Uuuh.. Never played with the tag management code directly myself either. A quick
> look seem to indicate that blk_mq_get/put_tag() is what you should be using. But
> further looking, struct blk_mq_tags has the field nr_reserved_tags which is used
> as an offset start point for searching free tags, which is exactly what you
> would need.

Yup. I was getting there, it's just that we use the tagset mess which I
had to untangle a bit first :-)

Cheers,
Ben.
