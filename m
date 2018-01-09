From: joshi.k@samsung.com (Kanchan Joshi)
Date: Tue, 09 Jan 2018 19:20:58 +0530
Subject: [PATCH] nvme: Add weighted-round-robin arbitration support
In-Reply-To: <20180104173804.GA7007@localhost.localdomain>
References: <CGME20180104150334epcas1p14579a6ab7bcf1b6ce326d0bce89c91e1@epcas1p1.samsung.com>
 <1515078129-4041-1-git-send-email-joshi.k@samsung.com>
 <20180104173804.GA7007@localhost.localdomain>
Message-ID: <ec6f0d2f-2751-0a29-7762-7a32830e0fcc@samsung.com>

Hi Keith,

It seems to me that some sort of differentiation (among tasks of various 
classes) during tag allocation is required to handle this. Perhaps, 
static division of available tags into 4 priority classes needs to be 
done in block layer.
Or does there exist any other facility in block layer which you hinted 
at? I would appreciate your suggestions/concerns.

Thanks
Kanchan

On Thursday 04 January 2018 11:08 PM, Keith Busch wrote:
> On Thu, Jan 04, 2018@08:32:09PM +0530, Kanchan Joshi wrote:
>> This patch enables support for Weighted-Round-Robin (WRR) arbitration, so
>> that applications can make use of the prioritization capabilities natively
>> present in NVMe controller.
>>
>> - It links existing io-nice classes (real-time, best-effort, none, low)
>> to NVMe priorities (urgent, high, medium, low).  This is done through
>> 'request->ioprio' field inside 'queue_rq' function.
>>
>> - Current driver has 1:1 mapping (1 SQ, 1 CQ) per cpu, encapsulated in
>> 'nvmeq' structure.  This patch refactors the code so that N:1 mapping per
>> cpu can be created; 'nvmeq' has been changed to contain variable number of SQ
>> related fields.  For WRR, 4 submission-queues (corresponding to each queue
>> priorites) need to be created on each cpu.
> 
> You have a single tagset per CQ for up to N oustandanding commands, but
> allocate enough submission entries for 4 * N. And since they're sharing
> tags, a lower pri task can limit a high-pri one from getting a tag. I
> think we could use a little more help from the block layer for WRR.
> 
> 
> 
