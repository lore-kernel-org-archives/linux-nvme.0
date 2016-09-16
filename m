From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Sep 2016 17:04:48 -0400
Subject: [PATCH RFC 00/21] blk-mq: Introduce combined hardware queues
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <20160916210448.GA1178@localhost.localdomain>

On Fri, Sep 16, 2016@10:51:11AM +0200, Alexander Gordeev wrote:
> Linux block device layer limits number of hardware contexts queues
> to number of CPUs in the system. That looks like suboptimal hardware
> utilization in systems where number of CPUs is (significantly) less
> than number of hardware queues.
> 
> In addition, there is a need to deal with tag starvation (see commit
> 0d2602ca "blk-mq: improve support for shared tags maps"). While unused
> hardware queues stay idle, extra efforts are taken to maintain a notion
> of fairness between queue users. Deeper queue depth could probably
> mitigate the whole issue sometimes.
> 
> That all brings a straightforward idea that hardware queues provided by
> a device should be utilized as much as possible.

Hi Alex,

I'm not sure I see how this helps. That probably means I'm not considering
the right scenario. Could you elaborate on when having multiple hardware
queues to choose from a given CPU will provide a benefit?

If we're out of avaliable h/w tags, having more queues shouldn't
improve performance. The tag depth on each nvme hw context is already
deep enough that it should mean even one full queue has saturated the
device capabilities.

Having a 1:1 already seemed like the ideal solution since you can't
simultaneously utilize more than that from the host, so there's no more
h/w parallelisms from we can exploit. On the controller side, fetching
commands is serialized memory reads, so I don't think spreading IO
among more h/w queues helps the target over posting more commands to a
single queue.

If a CPU has more than one to choose from, a command sent to a less
used queue would be serviced ahead of previously issued commands on a
more heavily used one from the same CPU thread due to how NVMe command
arbitraration works, so it sounds like this would create odd latency
outliers.

Thanks,
Keith
