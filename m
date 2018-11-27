From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 26 Nov 2018 23:45:01 -0800
Subject: [PATCH nvme-cli v3 15/13] nvme: Add TCP transport
In-Reply-To: <20181126154723.GP26707@localhost.localdomain>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-16-sagi@grimberg.me>
 <20181126154723.GP26707@localhost.localdomain>
Message-ID: <d7f154bc-d9ab-bbc6-b85d-5a96034c552e@grimberg.me>

> The cli parts good to me. Is there any forseeable issue if I apply these
> ahead of the kernel integration? I don't see any, but just want to
> confirm since its all in one series.

I don't see an issue, note that its on top of the sqflow patch [1]
that I've been meaning to ping you on.

[PATCH nvme-cli 5/4 v4] fabrics: support fabrics sq flow control disable
from series: Support SQ flow control disabled mode (TP 8005)
