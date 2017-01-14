From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 14 Jan 2017 23:00:36 +0200
Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <VI1PR0502MB3008E00F1FC094A35496C6DBD17B0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <1484261109-3316-1-git-send-email-parav@mellanox.com>
 <20170113074420.GA25814@lst.de>
 <VI1PR0502MB30086F641A07262801C02A28D1780@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <1f8d3db6-03b7-6c8f-8010-4ab964a87f3c@grimberg.me>
 <CAG53R5XGW-up2JtB_X29nPwbEGW14mvRBjnao8yOHczYUvvPgg@mail.gmail.com>
 <45c8815c-d9a1-4a74-8a70-0a0ea11d8201@grimberg.me>
 <VI1PR0502MB3008E00F1FC094A35496C6DBD17B0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Message-ID: <e8064999-c6a5-1820-2caa-7850ce24fb1c@grimberg.me>


> I see there is some discussion with Bart's patch with respect to SDMA.
> So I guess it might take a while to merge his patchset.
>
> How about doing this?
> - add this with 'ib_' prefix into 4.10-rc.
> - followed by cherry pick this commit in linux-rdma tree.
>
> When Bart rebase it, changes of this fix will automatically get converted from ib_ to dma_.
> So shall I send patch for 4.10-rc with 'ib_' prefix?

Sounds good,

Thanks Parav.
