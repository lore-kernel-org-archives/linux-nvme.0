From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 29 Mar 2017 20:15:50 +0300
Subject: [PATCH] irq/affinity: Assign all CPUs a vector
In-Reply-To: <1490743277-14139-1-git-send-email-keith.busch@intel.com>
References: <1490743277-14139-1-git-send-email-keith.busch@intel.com>
Message-ID: <6e7a93a7-b0bb-8835-6c49-3eaa3203e1d8@grimberg.me>


> The number of vectors to assign needs to be adjusted for each node such
> that it doesn't exceed the number of CPUs in that node. This patch
> recalculates the vector assignment per-node so that we don't try to
> assign more vectors than there are CPUs. When that previously happened,
> the cpus_per_vec was calculated to be 0, so many vectors had no CPUs
> assigned. This then goes on to fail to allocate descriptors due to
> empty masks, leading to an unoptimal spread.

Can you give a specific (numeric) example where this happens? I'm having
a little trouble following the logical change here.
