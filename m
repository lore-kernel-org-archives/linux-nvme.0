From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 6 Aug 2019 10:36:54 +0800
Subject: [PATCH 1/2] nvme-fabrics: Add type of service (TOS) configuration
In-Reply-To: <a934378c-af6a-6c31-7d72-58f4295ad5b5@grimberg.me>
References: <1564912530-15404-1-git-send-email-israelr@mellanox.com>
 <0fb2cf8c-3657-31bf-0df5-ee2495282f57@broadcom.com>
 <a934378c-af6a-6c31-7d72-58f4295ad5b5@grimberg.me>
Message-ID: <5b634bfb-80df-5620-dbb1-7d09015bcdf5@mellanox.com>


On 8/6/2019 2:17 AM, Sagi Grimberg wrote:
>
>> On 8/4/2019 2:55 AM, Israel Rukshin wrote:
>>> TOS is user-defined and needs to be configured via nvme-cli.
>>> It must be set before initiating any traffic and once set the TOS
>>> cannot be changed.
>>>
>>> Signed-off-by: Israel Rukshin <israelr at mellanox.com>
>>> ---
>>> ? drivers/nvme/host/fabrics.c | 16 +++++++++++++++-
>>> ? drivers/nvme/host/fabrics.h |? 3 +++
>>> ? 2 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>>> index 5838f7cd53ac..dbce7ffe6c2c 100644
>>> --- a/drivers/nvme/host/fabrics.c
>>> +++ b/drivers/nvme/host/fabrics.c
>>> @@ -611,6 +611,7 @@ static const match_table_t opt_tokens = {
>>> ????? { NVMF_OPT_DATA_DIGEST,??????? "data_digest"??????? },
>>> ????? { NVMF_OPT_NR_WRITE_QUEUES,??? "nr_write_queues=%d" },
>>> ????? { NVMF_OPT_NR_POLL_QUEUES,??? "nr_poll_queues=%d"??? },
>>> +??? { NVMF_OPT_TOS,??????????? "tos=%d"??????? },
>>> ????? { NVMF_OPT_ERR,??????????? NULL??????????? }
>>> ? };
>>>
>>
>> I think we need to create a framework for transport-specific options. 
>> Keeping them at the same flat level as the generic options isn't a 
>> great idea as they start to grow and always modifying core for a 
>> transport option isn't good either.
>
> Well, not disagreeing, but I personally think that this can be
> applicable to all transports as this is a generic term that happens
> to map to a specific marking in ip transports.
>
> Also, I actually think that keeping a single parser simplifies things.
> Unless we may run out of short arg options, which in that case it is
> beneficial...
>
>> How about we start the convention "<transport_name>:<option>" for an 
>> option.? The opts struct can have a pointer that is owned by the 
>> transport.? The transport can supply a parsing function for an 
>> option. The core layer can match the transport name in the prefix, 
>> then invoke the transport handler instead of the generic parsing. 
>> Transport handler can parse and set it's own value in its own opts 
>> struct. Transport can validate it has the necessary transport opts as 
>> the first thing it does in it's create_ctrl routine.
>
> That is one way to go...
>
> I don't have a strong stand here, what do others think?

I think we can re-use the code in the general fabrics and just add 
helpers for each option to decrease the lines of nvmf_parse_options func 
and make it more readable.

I prefer to avoid of parsing per transport.

something like:

case NVMF_OPT_NR_POLL_QUEUES:

 ??? nvmf_parse_nr_poll_queues(opts, args);

 ??? break;

case NVMF_OPT_TOS:

 ??? nvmf_parse_tos(opts, args);

 ??? break;

-Max.
