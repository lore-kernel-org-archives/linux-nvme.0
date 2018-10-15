From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 15 Oct 2018 00:55:13 -0700
Subject: bad IOPS when running multiple btest/fio in parallel
In-Reply-To: <93eb0e1c47434c6db5f5d97797b01e61@SC-EXCH03.marvell.com>
References: <93eb0e1c47434c6db5f5d97797b01e61@SC-EXCH03.marvell.com>
Message-ID: <c11da8f6-d66d-e49d-3f2c-42c69d0476c4@grimberg.me>


> Host: Ubuntu 18.04 (4.15 kernel). I9-7940X (14C/28T) with 32G DRAM. Has a single-port 100G rNIC. No OFED driver is installed.
> 
> 1.	When I insert 4 Intel Optane 905P into that host and run 4 btest in parallel (one btest for each Optane, random read, bs=4K, 6 thread, qd = 32), I am able to get aggregated IOPS of 2380K.
> 2.	Then I move those 4 Optane into 4 NVMeOF targets (RoCEv2). Each target has a 25G rNIC. All 4 25G rNICs and that 100G rNIC are connected to a switch.
> 3.	Start iperf from all 4 targets toward the host, the aggregated throughput is 92Gbps. So this means the data path between the host and the targets is clean.
> 4.	From the host, use "nvme connect" to link up with all 4 targets.
> 5.	Run non-overlapping btest against each target, IOPS is around 595K each. So this is good.
> 6.	Run 4 btest in parallel (one btest for each target). This is basically the same as #1, except it's now over the fabric. But the aggregate IOPS is only 1500K. Assign CPU affinity so that each btest uses exclusive 3C/6T doesn't help. Replacing btest by fio doesn't help either.
> 7.	Replace that 100G rNIC by a model from a different vendor and repeat test #6. The aggregated IOPS is better, but it's still nowhere close to the expected 2380K IOPS.
> 
> So I am wondering if there is any known limitation with Linux inbox NVMeOF driver regarding support of multiple sessions in parallel. Any tuning?

Does setting modparam register_always=Y make a difference?
