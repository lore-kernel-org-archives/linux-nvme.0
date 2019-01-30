From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Jan 2019 11:12:22 -0700
Subject: [LSF/MM TOPIC] memory reclaim with NUMA rebalancing
In-Reply-To: <20190130174847.GD18811@dhcp22.suse.cz>
References: <20190130174847.GD18811@dhcp22.suse.cz>
Message-ID: <20190130181221.GA19525@localhost.localdomain>

On Wed, Jan 30, 2019@06:48:47PM +0100, Michal Hocko wrote:
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

Yes, thanks for the proposal. I would be very interested in this
discussion for MM. I think some of the details for determining such a
migration path are related to the heterogeneous memory attributes I'm
currently trying to export.
