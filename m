From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 Aug 2017 17:17:23 +0200
Subject: Centralize nvme controller reset, delete and fabrics periodic
 reconnects
In-Reply-To: <de413980-1382-7567-b0d4-3207a4476719@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
 <20170816104935.GA30525@lst.de>
 <de413980-1382-7567-b0d4-3207a4476719@grimberg.me>
Message-ID: <20170816151723.GA18932@lst.de>

On Wed, Aug 16, 2017@04:51:31PM +0300, Sagi Grimberg wrote:
> I think its a very desirable goal to have PCIe consolidate with fabrics
> here, so I'd like to shoot for that and backoff later (and change again
> where makes sense).
>
> Having said that, I'm very much open to suggestions if you have anything
> better in mind...

Not too many suggestions - you want to see it done before we go on
merging the code..
