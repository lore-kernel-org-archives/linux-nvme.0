From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 May 2017 13:51:33 +0300
Subject: [PATCH v2 2/2] IB/mlx5: set UMR wqe fence according to HCA cap
In-Reply-To: <20170529160609.GA17751@mtr-leonro.local>
References: <1495957991-19223-1-git-send-email-maxg@mellanox.com>
 <1495957991-19223-2-git-send-email-maxg@mellanox.com>
 <20170528090705.GM13083@lst.de>
 <19a1d347-91da-7e5f-8877-86772204a80a@mellanox.com>
 <20170529100504.GZ17751@mtr-leonro.local>
 <89409b6d-466d-070a-7082-1f7bbb9ad7c7@mellanox.com>
 <20170529160609.GA17751@mtr-leonro.local>
Message-ID: <d23a5a6f-bd9f-3b1a-34d5-25e8eb2a041c@grimberg.me>

Leon,

>> We don't fence those WR's.
>> Christoph just re-write it to be more intuitive code. I don't see logic
>> difference, am I wrong here ?
>
> A little bit, before Christoph's suggestion, we calculated fence for
> the paths which need such fence, after we will calculate for all paths.

Every WQE posted to a send queue must include a fence bit. All work
request posted on the send queue calculate the required fence, this
used to happen in finish_wqe call-sites with get_fence(), Christoph
just inlin'ed it.
