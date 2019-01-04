From: hare@suse.com (Hannes Reinecke)
Date: Fri, 4 Jan 2019 15:24:27 +0100
Subject: [PATCHv2] nvme-multipath: round-robin I/O policy
In-Reply-To: <833821226d78f0e947b14434c188d64d4838337a.camel@suse.de>
References: <20181221141330.96599-1-hare@suse.de>
 <833821226d78f0e947b14434c188d64d4838337a.camel@suse.de>
Message-ID: <bb159cba-ce3a-32ca-d79c-3dece6a71fd0@suse.com>

On 1/4/19 3:06 PM, Martin Wilck wrote:
> On Fri, 2018-12-21@15:13 +0100, Hannes Reinecke wrote:
>> Implement a simple round-robin I/O policy for multipathing.
>> Path selection is done in two rounds, first iterating across all
>> optimized paths, and, if that doesn't return any valid paths,
>> then iterate over all optimized and non-optimized paths.
>> If no paths are found we're using the existing algorithm.
>> This patch also implements a sysfs attribute 'iopolicy' to switch
>> between the current, NUMA-aware I/O policy and the 'round-robin'
>> I/O policy.
>> The original NUMA-aware I/O policy is kept as a default.
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>>   drivers/nvme/host/core.c      |   6 +++
>>   drivers/nvme/host/multipath.c | 100
>> +++++++++++++++++++++++++++++++++++++++++-
>>   drivers/nvme/host/nvme.h      |  12 +++++
>>   3 files changed, 117 insertions(+), 1 deletion(-)
>>   
>> +static struct nvme_ns *__nvme_rr_next_path(struct nvme_ns_head
>> *head, int node,
>> +					   struct nvme_ns *old)
>> +{
>> +	struct nvme_ns *ns, *found = NULL;
>> +	bool try_nonoptimized = false;
>> +
>> +	if (!old)
>> +		return NULL;
>> +retry:
>> +	ns = old;
>> +	do {
>> +		ns = list_next_or_null_rcu(&head->list, &ns->siblings,
>> +					   struct nvme_ns, siblings);
>> +		if (!ns) {
>> +			ns = list_first_or_null_rcu(&head->list, struct
>> nvme_ns,
>> +						    siblings);
>> +			if (!ns)
>> +				return NULL;
>> +
>> +			if (ns == old)
>> +				/*
>> +				 * The list consists of just one entry.
>> +				 * Sorry for the noise :-)
>> +				 */
>> +				return old;
>> +		}
>> +		if (ns->disk && ns->ctrl->state == NVME_CTRL_LIVE) {
>> +			if (ns->ana_state == NVME_ANA_OPTIMIZED) {
>> +				found = ns;
>> +				break;
>> +			}
>> +			if (try_nonoptimized &&
>> +			    ns->ana_state == NVME_ANA_NONOPTIMIZED) {
>> +				found = ns;
>> +				break;
>> +			}
>> +		}
>> +	} while (ns != old);
>> +
>> +	if (found)
>> +		rcu_assign_pointer(head->current_path[node], found);
>> +	else if (!try_nonoptimized) {
>> +		try_nonoptimized = true;
>> +		goto retry;
>> +	}
>> +	return found;
>> +}
> 
> Would it make sense to skip the rcu_assign_pointer call if ns == old?

Hmm. That would mean an additional condition which would need to offset 
against 'rcu_assign_pointer'; doubt you could measure a difference here.

> Also, if no OPTIMIZED paths are found in the first iteration, I'd find
> it cleaner to restrict the search to NONOPTIMIZED paths in the second
> round (rather than looking at both OPTIMIZED and NONOPTIMIZED), similar
> to a pathgroup switch in traditional multipathing. The behavior would
> then come down to a PG switch with "immediate" fallback in multipath-
> tools terms.
> 
Concurrency is the key. We're running lockless here, so the path state 
might change at any time.
Only checking for non-optimized would cause us to miss any paths which 
went to 'optimized' in between checks.

>> +
>>   static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
>>   {
>>   	return ns->ctrl->state == NVME_CTRL_LIVE &&
>> @@ -180,6 +231,8 @@ inline struct nvme_ns *nvme_find_path(struct
>> nvme_ns_head *head)
>>   	struct nvme_ns *ns;
>>   
>>   	ns = srcu_dereference(head->current_path[node], &head->srcu);
>> +	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
>> +		ns = __nvme_rr_next_path(head, node, ns);
>>   	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
>>   		ns = __nvme_find_path(head, node);
>>   	return ns;
> 
> I don't understand why you call __nvme_find_path() here. If the return
> value of __nvme_rr_next_path() is NULL, you already know that there's
> no usable path; and if its NONOPTIMIZED, you know that there are no
> OPTIMIZED paths that __nvme_find_path() could discover.
> 
Concurrency again.
Paths might have switched priorities after our check.
Plus we have an additional safeguard that we'll never degrade wrt the 
original algorithm in terms of valid paths.

Cheers,

Hannes
