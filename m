From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 15 Aug 2017 12:15:22 +0300
Subject: [PATCH 1/1] nvme-rdma: Use unlikely macro in the fast path
In-Reply-To: <407fda2c-b54d-a4a6-7504-a7fc51a416f5@grimberg.me>
References: <1502713766-10055-1-git-send-email-maxg@mellanox.com>
 <407fda2c-b54d-a4a6-7504-a7fc51a416f5@grimberg.me>
Message-ID: <c7105632-b69e-7a7c-d700-dfb224e32ebc@mellanox.com>



On 8/15/2017 12:08 PM, Sagi Grimberg wrote:
>> This patch slightly improves performance (mainly for small block sizes).
>
> This looks fine,
>
> Looks fine,
>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
>
> Since you mentioned it, can you quantify what that bought us?

1 subsystem, 1 ns (null blk backing device)


bs      (w/w.o)
---    ---------
512:    912k/900k
1k:     912k/900k
2k :    911k/901k
4k:     922k/906k
8k:     568k/569k
16k:    288k/288k

-Max
