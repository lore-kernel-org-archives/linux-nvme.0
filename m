From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 01:13:47 +0300
Subject: [PATCH v3 3/3] nvmet-rdma: support 16K inline data
In-Reply-To: <eed2676a-a190-6362-1cc7-767ba481c4ae@opengridcomputing.com>
References: <cover.1527618402.git.swise@opengridcomputing.com>
 <55c82aa5730c05017a58641ad9550b6c0f0e16b2.1527618402.git.swise@opengridcomputing.com>
 <01000163b1bd094e-8a191404-8725-40c0-9af5-c4b69f324a1d-000000@email.amazonses.com>
 <2d10d67d-9504-b66b-b795-b69d536e39ad@grimberg.me>
 <eed2676a-a190-6362-1cc7-767ba481c4ae@opengridcomputing.com>
Message-ID: <6200a1e0-08d0-7bbe-18dd-c39dd1c80dda@grimberg.me>


> Its ugly because registering an MR for the inline pages requires a
> connected QP to use the REG_MR WR.

No, why MR?

> Maybe I'll just split the needed
> pages across the remaining recv sge entries available?? IE if the device
> supports 5 recv sges, then 4 can be used for inline, and thus 4
> non-contiguous pages could be used.

That's what I had in mind...

> cxgb4, however, only support 4 recv
> sges, so it would only support 12K of inline with this implementation.

:(

> And perhaps there are rdma devices with even fewer recv sges?
> 
> Do you have any other idea on how to avoid higher-order allocations?

Not really. I guess that we should be able to recv the user
inline_data_size. So maybe it would be ok if the we'd do that only if
we must?
