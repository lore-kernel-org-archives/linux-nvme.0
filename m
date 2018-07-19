From: hch@lst.de (hch@lst.de)
Date: Thu, 19 Jul 2018 15:22:25 +0200
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <20180718205321.GA32160@localhost.localdomain>
References: <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
 <20180712192437.GA16839@localhost.localdomain>
 <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
 <20180713154346.GA18955@localhost.localdomain>
 <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
 <20180713184712.GA19419@localhost.localdomain>
 <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
 <20180713235807.GA19967@localhost.localdomain>
 <20180718195650.GA20336@lst.de>
 <20180718205321.GA32160@localhost.localdomain>
Message-ID: <20180719132225.GC13129@lst.de>

On Wed, Jul 18, 2018@02:53:21PM -0600, Keith Busch wrote:
> If scsi needs this behavior, why not just put that behavior in scsi? It
> can set the state to complete and then everything can play out as
> before.

I think even with this we are missing handling for the somewhat
degenerate blk_abort_request case.

But most importantly we'll need some good test coverage.  Please
do some basic testing (e.g. with a version of the hack from
Jianchao (who seems to keep getting dropped from this thread for
some reason) and send it out to the block and scsi lists.
