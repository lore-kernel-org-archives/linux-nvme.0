From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jun 2015 17:18:33 +0000 (UTC)
Subject: [PATCH] NVMe: Use CMB for the SQ if available
In-Reply-To: <20150622150615.GD1971@linux.intel.com>
References: <1434750357-29162-1-git-send-email-jonathan.derrick@intel.com>
 <20150622150615.GD1971@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1506221518110.15930@localhost.lm.intel.com>

On Mon, 22 Jun 2015, Matthew Wilcox wrote:
> On Fri, Jun 19, 2015@03:45:57PM -0600, Jon Derrick wrote:
>>  	u32 __iomem *q_db;
>> +	bool cmb_mapped;
>> +	struct nvme_command cmb_cmd ____cacheline_aligned;
>>  	u16 q_depth;
>
> I don't like this.  Some of the places which submit commands today
> construct the command on the stack, and others construct them directly
> in the host-side queue memory.  I'd rather see them all construct on
> the stack, rather than in the nvme_queue.

We thought constructing directly in the queue's entry was a
micro-optimization for the fast path. I can measure a small (~1%)
performance drop from buffering the nvme command on the stack vs writing
it inline. This test synthesized an infinitely fast nvme device, though;
the loss is more insignificant on real h/w.

>> +		/* Ensure the reduced q_depth is above some threshold where it
>> +		would be better to map queues in system memory with the
>> +		original depth */
>> +		if (q_depth < 64)
>> +			return -ENOMEM;
>> +	}
>
> It seems to me that rather than avoiding use of the CMB entirely if it's
> too small, or the number of queues is too large, we should use the CMB
> for the first N queues and use host memory for the rest.  Yes, there'll
> be a performance difference between the queues, but there's already a
> performance difference between queues in memory that's NUMA-local to
> the adapter and memory that's NUMA-far.

At least with NUMA, a user can discover where the local node is and
control their applications for better performance.

If some queues are CMB and some are not, and we don't control which
CPUs are assigned a queue, there's no good way a user can know how to
tune their application to use one type of queue or another. It seemed
preferable to avoid a potentially confusing performance variability
scenario.
