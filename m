From: pandit.parav@gmail.com (Parav Pandit)
Date: Fri, 13 Jan 2017 13:50:36 -0600
Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <1f8d3db6-03b7-6c8f-8010-4ab964a87f3c@grimberg.me>
References: <1484261109-3316-1-git-send-email-parav@mellanox.com>
 <20170113074420.GA25814@lst.de>
 <VI1PR0502MB30086F641A07262801C02A28D1780@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <1f8d3db6-03b7-6c8f-8010-4ab964a87f3c@grimberg.me>
Message-ID: <CAG53R5XGW-up2JtB_X29nPwbEGW14mvRBjnao8yOHczYUvvPgg@mail.gmail.com>

Hi Sagi,

On Fri, Jan 13, 2017@1:42 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>
>> Doug needs to rebase to above git tree.
>> Followed by Bart's patches, followed by my changes in his tree.
>> Without that, Linux-next will get compile error because ib_dma_xx won't be
>> defined.
>> Let me know, I have 4.10-rc patch also tested.
>
>
> No need, we'll jest keep the patch as is, no compile error
> will generate.
> --

If we keep the patch as it is in 4.10-rc, than I think IB/rxe will
break with plays with virtual addresses.
