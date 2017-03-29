From: keith.busch@intel.com (Keith Busch)
Date: Wed, 29 Mar 2017 13:54:15 -0400
Subject: [PATCH] irq/affinity: Assign all CPUs a vector
In-Reply-To: <6e7a93a7-b0bb-8835-6c49-3eaa3203e1d8@grimberg.me>
References: <1490743277-14139-1-git-send-email-keith.busch@intel.com>
 <6e7a93a7-b0bb-8835-6c49-3eaa3203e1d8@grimberg.me>
Message-ID: <20170329175415.GD20181@localhost.localdomain>

On Wed, Mar 29, 2017@08:15:50PM +0300, Sagi Grimberg wrote:
> 
> > The number of vectors to assign needs to be adjusted for each node such
> > that it doesn't exceed the number of CPUs in that node. This patch
> > recalculates the vector assignment per-node so that we don't try to
> > assign more vectors than there are CPUs. When that previously happened,
> > the cpus_per_vec was calculated to be 0, so many vectors had no CPUs
> > assigned. This then goes on to fail to allocate descriptors due to
> > empty masks, leading to an unoptimal spread.
> 
> Can you give a specific (numeric) example where this happens? I'm having
> a little trouble following the logical change here.

Sure, I have a 2-socket server with 16 threads each. I take one CPU
offline in socket 2, so I've 16 threads on socket 1, 15 in socket 2. In
total, 31 threads so requesting 31 vectors.

Currently, vecs_per_node is calculated in the first iteration as 31 / 2, so 15.

ncpus of socket 1 is 16. cpus_per_vec = 16 / 15, so 1 CPU per vector
with one extra.

When iterating the second socket, though, vecs_per_node is incremented
from 15 to 16 (to account for the "extra" from before). However, the
ncpus is only 15, so that iteration calculates:

  cpus_per_vec = 15 / 16

And since that's zero, the remaining 16 vectors are not assigned to any
CPU, and the second socket has no vectors assigned to their CPUs.
