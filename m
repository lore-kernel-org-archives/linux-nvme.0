From: fengguang.wu@intel.com (Fengguang Wu)
Date: Sat, 23 Feb 2019 21:27:48 +0800
Subject: [LSF/MM ATTEND ] memory reclaim with NUMA rebalancing
In-Reply-To: <87h8dpnwxg.fsf@linux.ibm.com>
References: <20190130174847.GD18811@dhcp22.suse.cz>
 <87h8dpnwxg.fsf@linux.ibm.com>
Message-ID: <20190223132748.awedzeybi6bjz3c5@wfg-t540p.sh.intel.com>

On Thu, Jan 31, 2019@12:19:47PM +0530, Aneesh Kumar K.V wrote:
>Michal Hocko <mhocko at kernel.org> writes:
>
>> Hi,
>> I would like to propose the following topic for the MM track. Different
>> group of people would like to use NVIDMMs as a low cost & slower memory
>> which is presented to the system as a NUMA node. We do have a NUMA API
>> but it doesn't really fit to "balance the memory between nodes" needs.
>> People would like to have hot pages in the regular RAM while cold pages
>> might be at lower speed NUMA nodes. We do have NUMA balancing for
>> promotion path but there is notIhing for the other direction. Can we
>> start considering memory reclaim to move pages to more distant and idle
>> NUMA nodes rather than reclaim them? There are certainly details that
>> will get quite complicated but I guess it is time to start discussing
>> this at least.
>
>I would be interested in this topic too. I would like to understand

So do me. I'd be glad to take in the discussions if can attend the slot.

>the API and how it can help exploit the different type of devices we
>have on OpenCAPI.
>
>IMHO there are few proposals related to this which we could discuss together
>
>1. HMAT series which want to expose these devices as Numa nodes
>2. The patch series from Dave Hansen which just uses Pmem as Numa node.
>3. The patch series from Fengguang Wu which does prevent default
>allocation from these numa nodes by excluding them from zone list.
>4. The patch series from Jerome Glisse which doesn't expose these as
>numa nodes.
>
>IMHO (3) is suggesting that we really don't want them as numa nodes. But
>since Numa is the only interface we currently have to present them as
>memory and control the allocation and migration we are forcing
>ourselves to Numa nodes and then excluding them from default allocation.

Regarding (3), we actually made a default policy choice for
"separating fallback zonelists for PMEM/DRAM nodes" for the
typical use scenarios.

In long term, it's better to not build such assumption into kernel.
There may well be workloads that are cost sensitive rather than
performance sensitive. Suppose people buy a machine with tiny DRAM
and large PMEM. In which case the suitable policy may be to

1) prefer (but not bind) slab etc. kernel pages in DRAM
2) allocate LRU etc. pages from either DRAM or PMEM node

In summary, kernel may offer flexibility for different policies for
use by different users. PMEM has different characteristics comparing
to DRAM, users may or may not be treated differently than DRAM through
policies.

Thanks,
Fengguang
