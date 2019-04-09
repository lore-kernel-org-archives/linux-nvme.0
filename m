From: james.smart@broadcom.com (James Smart)
Date: Tue, 9 Apr 2019 10:17:10 -0700
Subject: FC-NVMe csn initialisation
In-Reply-To: <fa84d071-4c61-6082-f92e-4c018e9ff0ff@suse.de>
References: <7f105083-7e74-7191-d321-acdeafa25f88@suse.de>
 <210FF865-6562-4404-A47D-E38EDD5D9B00@netapp.com>
 <e1d5b88f-218c-e556-6053-93a6c3aeda8b@broadcom.com>
 <fa84d071-4c61-6082-f92e-4c018e9ff0ff@suse.de>
Message-ID: <5620085f-9add-7e97-3145-c815690ca9ca@broadcom.com>



On 4/8/2019 11:08 PM, Hannes Reinecke wrote:
> On 4/8/19 6:37 PM, James Smart wrote:
>>
>>
>> On 4/8/2019 8:45 AM, Meneghini, John wrote:
>>>> a) the CSN shall be equal to zero for the first NVMe_CMND IU for each
>>>> ??? NVMeoFC connection and shall be incremented by one for each 
>>>> subsequent
>>>> ??? command on the NVMeoFC connection;
>>> I'm not sure it matters if the csn starts at 0. As long as the csn 
>>> is incremented with every FC_CMD_IU that's put on the wire, I think 
>>> we're good.
>>>
>>> However, I do think I see a bug were nvme_fc_start_fcp_op() 
>>> increments the queue->csn counter and then never puts the cmdiu on 
>>> the transport queue.
>>>
>>> This can happen when nvme_fc_map_data() returns an error.
>>>
>>> /John
>>>
>>> static blk_status_t
>>> nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue 
>>> *queue,
>>> ???????? struct nvme_fc_fcp_op *op, u32 data_len,
>>> ???????? enum nvmefc_fcp_datadir io_dir)
>>> {
>>> ???????? struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
>>> ???????? struct nvme_command *sqe = &cmdiu->sqe;
>>> ???????? u32 csn;
>>> ???????? int ret, opstate;
>>> ??? ...
>>> ???????? /* format the FC-NVME CMD IU and fcp_req */
>>> ???????? cmdiu->connection_id = cpu_to_be64(queue->connection_id);
>>> ???????? csn = atomic_inc_return(&queue->csn);
>>> ???????? cmdiu->csn = cpu_to_be32(csn);
>>> ?? ...
>>> ???????? if (!(op->flags & FCOP_FLAGS_AEN)) {
>>> ???????????????? ret = nvme_fc_map_data(ctrl, op->rq, op);
>>> ???????????????? if (ret < 0) {
>>> ???????????????????????? nvme_cleanup_cmd(op->rq);
>>> ???????????????????????? nvme_fc_ctrl_put(ctrl);
>>> ???????????????????????? if (ret == -ENOMEM || ret == -EAGAIN)
>>> ???????????????????????????????? return BLK_STS_RESOURCE;
>>> ???????????????????????? return BLK_STS_IOERR;
>>> ???????????????? }
>>> ???????? }
>>> ??? ...
>>> ???????? ret = ctrl->lport->ops->fcp_io(&ctrl->lport->localport,
>>> &ctrl->rport->remoteport,
>>> queue->lldd_handle, &op->fcp_req);
>>>
>>>
>>
>> Good question. I believe a simple bug from a long time ago. The 
>> target side, for the most part, doesn't care about what the csn is 
>> until a fused io comes, then it would has to use the csn to pair them 
>> up.? As linux never sends fuse ios, csn is effectively irrelevant 
>> when used with linux.? If one were to be "spec compliant" yes, the 
>> target could choose to validate the connect cmd had cmdiu=0. But for 
>> any other command on the connection, order isn't dictated so there's 
>> no way to guess what the csn should be.
>>
>> And I do agree with John. I'll send a patchup shortly.
>>
> Well, the _actual_ background of this question was that I'd been 
> thinking if one could use csn to implement SQ flow control; after all, 
> csn is pretty similar to the SQ Head pointer, albeit with a different 
> modulo. If the spec would allow us to wrap-around csn at any arbitrary 
> fixed number we wouldn't need to implement a separate SQ head pointer 
> at all :-)
> Sadly, FC-NVMe is pretty adamant that we should be wrapping around at 
> UINT_MAX...
>
> Cheers,
>
> Hannes

Nope. CSN is a different beast with different semantics. Why wouldn't 
you go to SQHD/SQTAIL like the standard says ? (which our initiators 
purposely ignore)

it actually wouldn't be such a big deal to implement in the transport - 
we already have the retry logic for other things, and the nvmet target 
does properly increment SQHD - by 1 on every command completion, thus 
it's compliant with fabric flow control style too.? But you could then 
pace SQHD updates to give you the flow control like you wanted (per 
spec). Granted the question would then be do all transports honor it per 
spec. ? It could also open to using more than a single io queues's depth 
worth of commands on a controller (can scale out by the number of 
queues; I dislike how many target resources we leave unused today), but 
it goes against some of the things Christoph was trying to do, one of 
which checking SQHD/SQTAIL.

-- james
