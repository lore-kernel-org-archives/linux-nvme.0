From: shy828301@gmail.com (Yang Shi)
Date: Wed, 30 Jan 2019 15:53:13 -0800
Subject: [LSF/MM TOPIC] memory reclaim with NUMA rebalancing
In-Reply-To: <20190130174847.GD18811@dhcp22.suse.cz>
References: <20190130174847.GD18811@dhcp22.suse.cz>
Message-ID: <CAHbLzkpbWEVpeH9YsbBNy-Etfe0Pza5rPAe3b50sXq4rV4C+xQ@mail.gmail.com>

On Wed, Jan 30, 2019@9:48 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> Hi,
> I would like to propose the following topic for the MM track. Different
> group of people would like to use NVIDMMs as a low cost & slower memory
> which is presented to the system as a NUMA node. We do have a NUMA API
> but it doesn't really fit to "balance the memory between nodes" needs.
> People would like to have hot pages in the regular RAM while cold pages
> might be at lower speed NUMA nodes. We do have NUMA balancing for
> promotion path but there is notIhing for the other direction. Can we
> start considering memory reclaim to move pages to more distant and idle
> NUMA nodes rather than reclaim them? There are certainly details that
> will get quite complicated but I guess it is time to start discussing
> this at least.

I would be interested in this topic too.  We (Alibaba) do have some
usecases with using NVDIMM as NUMA node.  The node balancing (or
cold/hot data migration) is one of our needs to achieve optimal
performance for some workloads.  I also proposed a related topic.

Regards,
Yang

> --
> Michal Hocko
> SUSE Labs
>
