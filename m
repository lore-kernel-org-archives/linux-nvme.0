From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 20 Jun 2018 00:20:18 +0300
Subject: [PATCH v5 0/2] NVMF/RDMA 16K Inline Support
In-Reply-To: <cover.1529435395.git.swise@opengridcomputing.com>
References: <cover.1529435395.git.swise@opengridcomputing.com>
Message-ID: <544f27d3-3b9c-8a93-7d92-fcde84caaaab@mellanox.com>



On 6/19/2018 10:09 PM, Steve Wise wrote:
> Hey,
> 
> For small nvmf write IO over the rdma transport, it is advantagous to
> make use of inline mode to avoid the latency of the target issuing an
> rdma read to fetch the data.  Currently inline is used for <= 4K writes.
> 8K, though, requires the rdma read.  For iWARP transports additional
> latency is incurred because the target mr of the read must be registered
> with remote write access.  By allowing 2 pages worth of inline payload,
> I see a reduction in 8K nvmf write latency of anywhere from 2-7 usecs
> depending on the RDMA transport..
> 
> This series is a respin of a series floated last year by Parav and Max
> [1].  I'm continuing it now and have addressed some of the comments from
> their submission [2].
> 
> The below performance improvements are achieved.  Applications doing
> 8K or 16K WRITEs will benefit most from this enhancement.
> 
> WRITE IOPS:
> 8 nullb devices, 16 connections/device,
> 16 cores, 1 host, 1 target,
> fio randwrite, direct io, ioqdepth=256, jobs=16
> 
>               %CPU Idle                   KIOPS
> inline size  4K        8K        16K     4K        8K        16K
> io size
> 4K            9.36     10.47     10.44   1707      1662      1704
> 8K           39.07     43.66     46.84    894      1000      1002
> 16K          64.15     64.79     71.1     566      569        607
> 32K          78.84     79.5      79.89    326      329        327
> 
> WRITE Latency:
> 1 nullb device, 1 connection/device,
> fio randwrite, direct io, ioqdepth=1, jobs=1
> 
>               Usecs
> inline size  4K        8K        16K
> io size
> 4K           12.4      12.4      12.5
> 8K           18.3      13        13.1
> 16K          20.3      20.2      14.2
> 32K          23.2      23.2      23.4

The code looks good to me.
I'll run some benchmarks tomorrow hopefully using Mellanox adapters and 
share result before/after the patches.
