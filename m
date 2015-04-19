From: keith.busch@intel.com (Keith Busch)
Date: Sun, 19 Apr 2015 16:01:14 +0000 (UTC)
Subject: Latency of sequential vs. random small writes
In-Reply-To: <1429382376563.7463@ren.systems>
References: <1429382376563.7463@ren.systems>
Message-ID: <alpine.LNX.2.00.1504191549240.32385@localhost.lm.intel.com>

On Sat, 18 Apr 2015, Jinglei Ren wrote:
> I am trying NVMe user utilities (http://git.infradead.org/users/kbusch/nvme-user.git) on Intel SSD DC P3600, but find some counterintuitive results.
>
> Why individual latency of sequential 512-bytes writes is much larger than that of random ones?
>
> In my program, I issue 100 writes via ioctl(), whose "nblocks" is set to 0, i.e., 512 bytes. "Sequential" writes mean their "slba" (starting logical block address) is from 0 to 100 in order, while "random" writes mean their "slba" is a random number (below 1000 in my case). I calculate the average time to complete each ioctl() call. As a result, sequential writes each see whopping 1500+ usec latency, while random ones see only around 80 usec each.

This drive has a 4k physical sector. Writing less than or unaligned to
that takes a slower path that you've found with your sequential write
workload. The most recent f/w on downloadcenter.intel.com has improvements,
though 4k writes will always be faster.

Unless you have a reason to use 512b sectors, I usually recommend
formatting namespaces to the native 4k sector for best performance.
