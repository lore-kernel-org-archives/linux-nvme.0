From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 13 Jul 2016 12:49:46 +0300
Subject: NVMe over RDMA latency
In-Reply-To: <1467921342.24395.12.camel@ssi>
References: <1467921342.24395.12.camel@ssi>
Message-ID: <57860EBA.5010103@grimberg.me>

> Hi list,

Hey Ming,

> I'm trying to understand the NVMe over RDMA latency.
>
> Test hardware:
> A real NVMe PCI drive on target
> Host and target back-to-back connected by Mellanox ConnectX-3
>
> [global]
> ioengine=libaio
> direct=1
> runtime=10
> time_based
> norandommap
> group_reporting
>
> [job1]
> filename=/dev/nvme0n1
> rw=randread
> bs=4k
>
>
> fio latency data on host side(test nvmeof device)
>      slat (usec): min=2, max=213, avg= 6.34, stdev= 3.47
>      clat (usec): min=1, max=2470, avg=39.56, stdev=13.04
>       lat (usec): min=30, max=2476, avg=46.14, stdev=15.50
>
> fio latency data on target side(test NVMe pci device locally)
>      slat (usec): min=1, max=36, avg= 1.92, stdev= 0.42
>      clat (usec): min=1, max=68, avg=20.35, stdev= 1.11
>       lat (usec): min=19, max=101, avg=22.35, stdev= 1.21
>
> So I picked up this sample from blktrace which seems matches the fio avg latency data.
>
> Host(/dev/nvme0n1)
> 259,0    0       86     0.015768739  3241  Q   R 1272199648 + 8 [fio]
> 259,0    0       87     0.015769674  3241  G   R 1272199648 + 8 [fio]
> 259,0    0       88     0.015771628  3241  U   N [fio] 1
> 259,0    0       89     0.015771901  3241  I  RS 1272199648 + 8 (    2227) [fio]
> 259,0    0       90     0.015772863  3241  D  RS 1272199648 + 8 (     962) [fio]
> 259,0    1       85     0.015819257     0  C  RS 1272199648 + 8 (   46394) [0]
>
> Target(/dev/nvme0n1)
> 259,0    0      141     0.015675637  2197  Q   R 1272199648 + 8 [kworker/u17:0]
> 259,0    0      142     0.015676033  2197  G   R 1272199648 + 8 [kworker/u17:0]
> 259,0    0      143     0.015676915  2197  D  RS 1272199648 + 8 (15676915) [kworker/u17:0]
> 259,0    0      144     0.015694992     0  C  RS 1272199648 + 8 (   18077) [0]
>
> So host completed IO in about 50usec and target completed IO in about 20usec.
> Does that mean the 30usec delta comes from RDMA write(host read means target RDMA write)?


Couple of things that come to mind:

0. Are you using iodepth=1 correct?

1. I imagine you are not polling in the host but rather interrupt
    driven correct? thats a latency source.

2. the target code is polling if the block device supports it. can you
    confirm that is indeed the case?

3. mlx4 has a strong fencing policy for memory registration, which we
    always do. thats a latency source. can you try with
    register_always=0?

4. IRQ affinity assignments. if the sqe is submitted on cpu core X and
    the completion comes to cpu core Y, we will consume some latency
    with the context-switch of waiking up fio on cpu core X. Is this
    a possible case?

5. What happens if you test against a null_blk (which has a latency of
    < 1us)? back when I ran some tryouts I saw ~10-11us added latency
    from the fabric under similar conditions.
