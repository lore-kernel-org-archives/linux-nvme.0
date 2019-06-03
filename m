From: minwoo.im@samsung.com (Minwoo Im)
Date: Mon, 03 Jun 2019 13:27:44 +0900
Subject: [PATCH] nvme-cli: add default value for nsid of write-zeroes
In-Reply-To: <bfac4b78-937c-42e8-1be1-f9a81ad22ab7@grimberg.me>
References: <bfac4b78-937c-42e8-1be1-f9a81ad22ab7@grimberg.me>
 <20190601070003.20142-1-minwoo.im.dev@gmail.com>
 <CGME20190602071216epcas3p254daea15ecd90e3ddbfa3ac7c530bd1f@epcms2p8>
Message-ID: <20190603042744epcms2p820c9606f5f6cc97f621d060a8bedc926@epcms2p8>

> This is implicitly set to 0. You should mention that you add this just
> for clarification, and its not fixing a bug.

Hi Sagi,

Thanks for pointing it out.  I should have made the commit more in detail.
As you mentioned, the ommitted field members are implicitly initialized to
zero by the C99.

I think it can be ignored here.

Thanks :)
