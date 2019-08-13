From: dwagner@suse.de (Daniel Wagner)
Date: Tue, 13 Aug 2019 11:34:27 +0200
Subject: [PATCH V3 3/3] genirq/affinity: Spread vectors on node according
 to nr_cpu ratio
In-Reply-To: <20190813081447.1396-4-ming.lei@redhat.com>
References: <20190813081447.1396-1-ming.lei@redhat.com>
 <20190813081447.1396-4-ming.lei@redhat.com>
Message-ID: <7579c5b8-3992-e685-d559-98e9b0f7baad@suse.de>

Hi,

On 8/13/19 10:14 AM, Ming Lei wrote:
> Now __irq_build_affinity_masks() spreads vectors evenly per node, and
> all vectors may not be spread in case that each numa node has different
> CPU number, then the following warning in irq_build_affinity_masks() can
> be triggered:
> 
> 	if (nr_present < numvecs)
> 		WARN_ON(nr_present + nr_others < numvecs);

Is this the warning which is changed in patch #1?

Thanks,
Daniel
