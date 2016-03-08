From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 8 Mar 2016 11:02:59 -0700
Subject: [PATCH 1/2] Block: Disable polling stats when iostats are disabled
In-Reply-To: <56DF0E9E.8030302@fb.com>
References: <1457458494-10550-1-git-send-email-jonathan.derrick@intel.com>
 <1457458494-10550-2-git-send-email-jonathan.derrick@intel.com>
 <56DF0E9E.8030302@fb.com>
Message-ID: <20160308180259.GB8867@localhost.localdomain>

> Not sure this is a great idea. First of all, the poll stats are per hardware
> queue. How many submission queues and CPUs do you have in your setup? For

31 hq, 64 cpus (so actually just 31 sq)- but the test I ran was:
taskset -c 1 fio --name=global --gtod_reduce=1 --filename=/dev/nvme0n1 --bs=4k --rw=read --ioengine=sync --iodepth=1 --numjobs=1 --direct=1 --name=job 

I was a bit surprised at the delta I saw, but it may have been coincidental

> most cases, I'd assume there'd be a 1:1 mapping between the two, which makes
> the stats essentially free. And secondly, even for a less optimal mapping,
> the poll stats are a lot cheaper than the io stats. So bundling them
> together might not make a ton of sense.

Fair enough :)
