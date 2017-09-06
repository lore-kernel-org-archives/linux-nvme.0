From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 6 Sep 2017 17:40:33 +0300
Subject: [PATCH 0/3] nvmet-rdma: SRQ per completion vector
In-Reply-To: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
References: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
Message-ID: <3011f136-cf5b-6bed-7326-1a179d3e420e@grimberg.me>

Hi Max,

> This is a new feature for NVMEoF RDMA target, that is intended to save resource allocation
> (by sharing them) and utilize the locality (completions and memory) to get the best
> performance with Shared Receive Queues (SRQs). We'll create a SRQ per completion vector
> (and not per device) and assosiate each created QP/CQ with an appropriate SRQ. This will
> also reduce the lock contention on the single SRQ per device (today's solution).

I have a similar patch set which I've been using for some time now, I've
been reluctant to submit it because I think we need the rdma core to
create an API that helps everyone to get it right rather than adding
features to A subsystem we are focused on at a given time.

Couple of thoughts:

First of all, allocating num_comp_vectors srqs and pre-posted buffers
on the first connection establishment has a big impact on the time it
takes to establish it (with enough cpu cores the host might give up).
We should look into allocate lazily as we grow.

Second, the application might not want to run on all completion vectors
that the device has (I am working on modifying the CQ pool API to
accommodate that).

Third, given that SRQ is an optional feature, I'd be happy if we can
hide the this information from the application and implement a fallback
mechanism in the rdma core.

What I had in mind was to add srq_pool that the application can
allocate, and pass it to qp creation with a proper hint on the affinity
(both cq and srq can be selected from this hint).

Having said that, I'm not convinced it will be easy to come up with the
API in one shot, so maybe its worth moving forward with this, not sure..

Thoughts?

> We can see the perf improvement between Case 2 and Case 4 (same order of resource).

Yea, srq in its current form is a giant performance hit on a multi-core
system (more suitable for a processing power constrained targets).

> We can see the benefit in resource consumption (mem and CPU) with a small perf loss
> between cases 2 and 3.
> There is still an open question between the perf differance for 1k between Case 1 and
> Case 3, but I guess we can investigate and improve it incrementaly.

Where is this loss coming from? Is this a HW limitation? if its SW then
its a good place to analyze where we can improve (I have a couple of
ideas).
