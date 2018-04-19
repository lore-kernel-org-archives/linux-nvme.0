From: roland@purestorage.com (roland)
Date: Thu, 19 Apr 2018 14:11:09 -0700
Subject: [PATCH 1/2] IB/mlx5: posting klm/mtt list inline in the send
 queue for reg_wr
In-Reply-To: <1509295101-14081-2-git-send-email-idanb@mellanox.com>
References: <1509295101-14081-1-git-send-email-idanb@mellanox.com>
 <1509295101-14081-2-git-send-email-idanb@mellanox.com>
Message-ID: <CAL1RGDXbUXcrRyEtHWpBmWpbbCB6nuQVfWC1bi+4K_yp3pB0LQ@mail.gmail.com>

> The fetch of the MTT/KLM list becomes the bottleneck in
> number of IO operation could be done by NVMe over Fabrics
> host driver on a single adapter as shown below.
>
> This patch is adding the support for inline registration
> work request upon MTT/KLM list of size <=64B.

It looks like this patch never made it upstream, and I don't see any
discussion or reason why it might have been dropped.

This still seems like a good idea - should we respin it against the latest tree?

 - R.
