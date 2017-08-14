From: keith.busch@intel.com (Keith Busch)
Date: Mon, 14 Aug 2017 16:24:15 -0400
Subject: Bug Report: can't unload nvme module in case of disabled device
In-Reply-To: <b4c07a4b-de93-ef0c-d3d4-79baaa01d0c6@mellanox.com>
References: <f28ebc80-0e67-8af7-79b2-a4b368e4bd83@mellanox.com>
 <20170810085950.GB12494@infradead.org>
 <6e1797d9-3b2c-6f9b-a5a8-d23aed778d8b@mellanox.com>
 <20170810193615.GB1180@localhost.localdomain>
 <b4c07a4b-de93-ef0c-d3d4-79baaa01d0c6@mellanox.com>
Message-ID: <20170814202414.GH7233@localhost.localdomain>

On Sun, Aug 13, 2017@11:29:59AM +0300, Max Gurtovoy wrote:
> 
> After bisecting I found that the following commit caused the simple
> load/unload nvme driver failure:
> 
> commit 1ad43c0078b79a76accd0fe64062e47b3430dc6b
> Author: Ming Lei <minlei at redhat.com>
> Date:   Wed Aug 2 08:01:45 2017 +0800
> 
>     blk-mq: don't leak preempt counter/q_usage_counter when allocating rq
> failed
> 
> Adding Ming to this thread.
> 
> I'm continuing with the debug of the new scenario (load nvme && sleep 10 &&
> unload nvme).
 
I'm reviewing that commit, and it looks wrong to me. It is only pairing
the blk_queue_exit if request allocation was successful. That will get
the q_usage_counter off when request allocation fails, making a queue
freeze impossible. I'll send a patch.
