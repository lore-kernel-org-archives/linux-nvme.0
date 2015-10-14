From: keith.busch@intel.com (Keith Busch)
Date: Wed, 14 Oct 2015 16:38:50 +0000 (UTC)
Subject: [PATCH v6 05/11] block: remove split code in
 blkdev_issue_{discard,write_same}B
In-Reply-To: <20151014132700.GA19401@infradead.org>
References: <1439363241-31772-1-git-send-email-mlin@kernel.org>
 <1439363241-31772-6-git-send-email-mlin@kernel.org>
 <20151013115011.GA6546@infradead.org>
 <CAF1ivSbsH7JsduHE+a2d+BEbZL6Fo7uJWS2NCTTMNTSAUMt0UA@mail.gmail.com>
 <20151014132700.GA19401@infradead.org>
Message-ID: <alpine.LNX.2.00.1510141620500.27742@localhost.lm.intel.com>

On Wed, 14 Oct 2015, Christoph Hellwig wrote:
> Analsys and tentativ fix below:
>
> blktrace for before the commit:
>
> 259,0    1        2     0.000002543  2394  G   D 0 + 8388607 [mkfs.xfs]
> 259,0    1        3     0.000008230  2394  I   D 0 + 8388607 [mkfs.xfs]
> 259,0    1        4     0.000031090   207  D   D 0 + 8388607 [kworker/1:1H]
> 259,0    1        5     0.000044869  2394  Q   D 8388607 + 8388607 [mkfs.xfs]
> 259,0    1        6     0.000045992  2394  G   D 8388607 + 8388607 [mkfs.xfs]
> 259,0    1        7     0.000049559  2394  I   D 8388607 + 8388607 [mkfs.xfs]
> 259,0    1        8     0.000061551   207  D   D 8388607 + 8388607 [kworker/1:1H]
>
> .. and so on.
>
> blktrace with the commit:
>
> 259,0    2        1     0.000000000  1228  Q   D 0 + 4194304 [mkfs.xfs]
> 259,0    2        2     0.000002543  1228  G   D 0 + 4194304 [mkfs.xfs]
> 259,0    2        3     0.000010080  1228  I   D 0 + 4194304 [mkfs.xfs]
> 259,0    2        4     0.000082187   267  D   D 0 + 4194304 [kworker/2:1H]
> 259,0    2        5     0.000224869  1228  Q   D 4194304 + 4194304 [mkfs.xfs]
> 259,0    2        6     0.000225835  1228  G   D 4194304 + 4194304 [mkfs.xfs]
> 259,0    2        7     0.000229457  1228  I   D 4194304 + 4194304 [mkfs.xfs]
> 259,0    2        8     0.000238507   267  D   D 4194304 + 4194304 [kworker/2:1H]
>
> So discards are smaller, but better aligned.  Now if I tweak a single
> line in blk-lib.c to be able to use all of bi_size I get the old I/O
> pattern back and everything works fine again:

I see why the proposal is an improvement, but I don't understand why the
current situation results in a hang. Are we missing some kind of error
recovery in the driver?
