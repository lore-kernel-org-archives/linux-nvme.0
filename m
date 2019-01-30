From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 30 Jan 2019 18:48:47 +0100
Subject: [LSF/MM TOPIC] memory reclaim with NUMA rebalancing
Message-ID: <20190130174847.GD18811@dhcp22.suse.cz>

Hi,
I would like to propose the following topic for the MM track. Different
group of people would like to use NVIDMMs as a low cost & slower memory
which is presented to the system as a NUMA node. We do have a NUMA API
but it doesn't really fit to "balance the memory between nodes" needs.
People would like to have hot pages in the regular RAM while cold pages
might be at lower speed NUMA nodes. We do have NUMA balancing for
promotion path but there is notIhing for the other direction. Can we
start considering memory reclaim to move pages to more distant and idle
NUMA nodes rather than reclaim them? There are certainly details that
will get quite complicated but I guess it is time to start discussing
this at least.
-- 
Michal Hocko
SUSE Labs
