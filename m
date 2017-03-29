From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 29 Mar 2017 20:50:14 +0300
Subject: [PATCH] irq/affinity: Assign all CPUs a vector
In-Reply-To: <20170329175415.GD20181@localhost.localdomain>
References: <1490743277-14139-1-git-send-email-keith.busch@intel.com>
 <6e7a93a7-b0bb-8835-6c49-3eaa3203e1d8@grimberg.me>
 <20170329175415.GD20181@localhost.localdomain>
Message-ID: <3129d8ee-4942-cf6a-8089-15ef5a838f21@grimberg.me>


> Sure, I have a 2-socket server with 16 threads each. I take one CPU
> offline in socket 2, so I've 16 threads on socket 1, 15 in socket 2. In
> total, 31 threads so requesting 31 vectors.
>
> Currently, vecs_per_node is calculated in the first iteration as 31 / 2, so 15.
>
> ncpus of socket 1 is 16. cpus_per_vec = 16 / 15, so 1 CPU per vector
> with one extra.
>
> When iterating the second socket, though, vecs_per_node is incremented
> from 15 to 16 (to account for the "extra" from before). However, the
> ncpus is only 15, so that iteration calculates:
>
>   cpus_per_vec = 15 / 16
>
> And since that's zero, the remaining 16 vectors are not assigned to any
> CPU, and the second socket has no vectors assigned to their CPUs.

Thanks for the clarification, makes sense...

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
