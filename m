From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 13 Jan 2017 22:01:23 +0200
Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <CAG53R5XGW-up2JtB_X29nPwbEGW14mvRBjnao8yOHczYUvvPgg@mail.gmail.com>
References: <1484261109-3316-1-git-send-email-parav@mellanox.com>
 <20170113074420.GA25814@lst.de>
 <VI1PR0502MB30086F641A07262801C02A28D1780@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <1f8d3db6-03b7-6c8f-8010-4ab964a87f3c@grimberg.me>
 <CAG53R5XGW-up2JtB_X29nPwbEGW14mvRBjnao8yOHczYUvvPgg@mail.gmail.com>
Message-ID: <45c8815c-d9a1-4a74-8a70-0a0ea11d8201@grimberg.me>

> Hi Sagi,

> If we keep the patch as it is in 4.10-rc, than I think IB/rxe will
> break with plays with virtual addresses.

I've been seeing reports that nvme-rdma is not
useable with rxe as it crashes pretty consistently.

In any event, we can either add this with 'ib_' prefix
into 4.10-rc and add a patch to Bart's series or
we can send a dedicated patch for stable.

Christoph, whats your preference?
