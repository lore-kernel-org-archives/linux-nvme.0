From: hare@suse.de (Hannes Reinecke)
Date: Tue, 8 Jan 2019 13:01:29 +0100
Subject: [PATCHv2] nvme-multipath: round-robin I/O policy
In-Reply-To: <4f9a3072c6f3a08000346894fbcf9269ff869241.camel@redhat.com>
References: <20181221141330.96599-1-hare@suse.de>
 <4f9a3072c6f3a08000346894fbcf9269ff869241.camel@redhat.com>
Message-ID: <455c2193-9816-abf0-d0fd-0bb426c28575@suse.de>

On 1/3/19 9:24 PM, Ewan D. Milne wrote:
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
> 
> This works fine for me, and resolves the hang I saw in the earlier
> version when all the paths were taken down.  I have one comment about
> the state checking in this version, see below...
> 
[ .. ]
>> @@ -168,6 +171,54 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>>   	return found;
>>   }
>>   
>> +static struct nvme_ns *__nvme_rr_next_path(struct nvme_ns_head *head, int node,
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
>> +			ns = list_first_or_null_rcu(&head->list, struct nvme_ns,
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
> 
> __nvme_find_path() also checks test_bit(NVME_NS_ANA_PENDING, &ns->flags)
> in addition to the NVME_CTRL_LIVE state check, maybe this would be needed
> here as well?  (i.e. don't select a path that has just received an ANA error
> and has the ana_work queued to get the updated ANA state, and queue if
> necessary until a usable up-to-date path is found?)
> 
Hmm. Guess you are right.
Will be updating the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
