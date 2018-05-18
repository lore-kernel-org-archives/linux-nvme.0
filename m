From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 18 May 2018 15:25:03 -0600
Subject: [PATCH 5/7] nvme-pci: handle completions outside of the queue lock
In-Reply-To: <93585ba6-32a3-d8aa-ad5c-ee22be3e8e8e@kernel.dk>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
 <1526655155-4006-6-git-send-email-axboe@kernel.dk>
 <20180518210630.GD27795@localhost.localdomain>
 <93585ba6-32a3-d8aa-ad5c-ee22be3e8e8e@kernel.dk>
Message-ID: <20180518212503.GA31490@localhost.localdomain>

On Fri, May 18, 2018@03:11:21PM -0600, Jens Axboe wrote:
> Gah, I didn't manage to trigger any of that. What was your test case?
> I'll see if I can come up with a nice cqe_seen replacement.

Runing the following profile on the is lowest latency drive I have in my
"big" server (112 CPUs, type Xeon Platinum 8180), in pure polling
(io_poll_delay is -1), sustaining 190k IOPs:

[global]
ioengine=pvsync2
cpus_allowed=29
direct=1
rw=randread
norandommap
bs=4k
hipri
ramp_time=1
runtime=10
gtod_reduce=1
clocksource=cpu

[test]
filename=/dev/nvme1n1
