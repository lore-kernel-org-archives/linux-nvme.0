From: james.smart@broadcom.com (James Smart)
Date: Tue, 17 Jul 2018 09:05:47 -0700
Subject: [PATCHv4 3/4] nvme: Introduce frozen controller state
In-Reply-To: <59b9c74b-91f1-7d1b-f20a-5a64dd66a17e@grimberg.me>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-4-keith.busch@intel.com>
 <59b9c74b-91f1-7d1b-f20a-5a64dd66a17e@grimberg.me>
Message-ID: <f2bd494e-0930-9ebf-024f-dc4a547a8bd9@broadcom.com>



On 7/16/2018 9:34 AM, Sagi Grimberg wrote:
>
>> +??? if (ctrl->state == NVME_CTRL_FROZEN) {
>> +??????? nvme_wait_freeze(ctrl);
>> +??????? blk_mq_update_nr_hw_queues(ctrl->tagset, ctrl->queue_count - 
>> 1);
>> +??????? nvme_unfreeze(ctrl);
>> +??????? if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>> +??????????? return;
>> +??? }
>> +
>
> Having the transport drivers setup a state to indicate nvme-core to
> handle it and change it again looks convoluted to me...
>

I'll second the comment.

-- james
