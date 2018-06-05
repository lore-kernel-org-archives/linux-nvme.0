From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 5 Jun 2018 11:52:18 +0300
Subject: [PATCH v3 3/3] nvmet-rdma: support 16K inline data
In-Reply-To: <018f01d3fc0e$f3648830$da2d9890$@opengridcomputing.com>
References: <cover.1527618402.git.swise@opengridcomputing.com>
 <55c82aa5730c05017a58641ad9550b6c0f0e16b2.1527618402.git.swise@opengridcomputing.com>
 <ff362b8e-c223-2d81-b355-80397745bd2a@mellanox.com>
 <00fe01d3fb68$4b5e2cf0$e21a86d0$@opengridcomputing.com>
 <7fc24496-9eec-3282-1c26-3cb05773ffd1@mellanox.com>
 <018f01d3fc0e$f3648830$da2d9890$@opengridcomputing.com>
Message-ID: <7e25837c-47df-d2dd-9a01-b63dbb6a986f@mellanox.com>



On 6/4/2018 5:18 PM, Steve Wise wrote:
> 
> 
>> -----Original Message-----
>> From: Max Gurtovoy <maxg at mellanox.com>
>> Sent: Monday, June 4, 2018 8:58 AM
>> To: Steve Wise <swise at opengridcomputing.com>; axboe at kernel.dk;
>> hch at lst.de; keith.busch at intel.com; sagi at grimberg.me; linux-
>> nvme at lists.infradead.org
>> Cc: parav at mellanox.com; linux-rdma at vger.kernel.org
>> Subject: Re: [PATCH v3 3/3] nvmet-rdma: support 16K inline data
>>
>>
>>
>> On 6/3/2018 9:25 PM, Steve Wise wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Max Gurtovoy <maxg at mellanox.com>
>>>> Sent: Sunday, June 3, 2018 3:40 AM
>>>> To: Steve Wise <swise at opengridcomputing.com>; axboe at kernel.dk;
>>>> hch at lst.de; keith.busch at intel.com; sagi at grimberg.me; linux-
>>>> nvme at lists.infradead.org
>>>> Cc: parav at mellanox.com; linux-rdma at vger.kernel.org
>>>> Subject: Re: [PATCH v3 3/3] nvmet-rdma: support 16K inline data
>>>>
>>>>
>>>>
>>>> On 5/29/2018 9:25 PM, Steve Wise wrote:
>>>>> Add a new configfs port attribute, called inline_data_size,
>>>>> to allow configuring the size of inline data for a given port.
>>>>> The maximum size allowed is still enforced by nvmet-rdma with
>>>>> NVMET_RDMA_MAX_INLINE_DATA_SIZE, which is increased to
>> max(16KB,
>>>>> PAGE_SIZE).  And the default size, if not specified via configfs,
>>>>> is still PAGE_SIZE.  This preserves the existing behavior, but allows
>>>>> larger inline sizes.
>>>>>
>>>>> Also support a configuration where inline_data_size is 0, which
> disables
>>>>> using inline data.
>>>>>
>>>>> Signed-off-by: Steve Wise <swise at opengridcomputing.com>
>>>>> ---
>>>>>     drivers/nvme/target/admin-cmd.c |  4 ++--
>>>>>     drivers/nvme/target/configfs.c  | 31 ++++++++++++++++++++++++++++
>>>>>     drivers/nvme/target/core.c      |  4 ++++
>>>>>     drivers/nvme/target/discovery.c |  2 +-
>>>>>     drivers/nvme/target/nvmet.h     |  2 +-
>>>>>     drivers/nvme/target/rdma.c      | 45 ++++++++++++++++++++++++++++-
>> ----
>>>> --------
>>>>>     6 files changed, 70 insertions(+), 18 deletions(-)
>>>>
>>>> snip..
>>>>
>>>>>
>>>>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>>>>> index 52e0c5d..2f0b08e 100644
>>>>> --- a/drivers/nvme/target/rdma.c
>>>>> +++ b/drivers/nvme/target/rdma.c
>>>>> @@ -33,9 +33,10 @@
>>>>>     #include "nvmet.h"
>>>>>
>>>>>     /*
>>>>> - * We allow up to a page of inline data to go with the SQE
>>>>> + * We allow at least 1 page, and up to 16KB of inline data to go with
>>> the
>>>> SQE
>>>>>      */
>>>>> -#define NVMET_RDMA_INLINE_DATA_SIZE	PAGE_SIZE
>>>>> +#define NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE	PAGE_SIZE
>>>>> +#define NVMET_RDMA_MAX_INLINE_DATA_SIZE		max_t(int,
>>>> SZ_16K, PAGE_SIZE)
>>>>
>>>> why not use SZ_16K ? why we need to mention the PAGE_SIZE ?
>>>>
>>>
>>> The idea is to allow at least 1 page.  So for, say, a 64K page system,
> we'll
>>> allow 64K since we're allocating a page minimum for the buffer.
>>
>> IMO you want to support upto 16K inline data and not upto 64k (also in
>> PowerPC system)...
> 
> Why?
> 

Ok we can use PAGE_SIZE from resource and perf perspective, but please 
change the subject since it is confusing. I guess the subject can be 
similar to the one you used in the initiator.

I think we should consider clamping to NVMET_RDMA_MAX_INLINE_DATA_SIZE 
in case port->inline_data_size > NVMET_RDMA_MAX_INLINE_DATA_SIZE instead 
of failing the operation (and add an info print).

-Max.
