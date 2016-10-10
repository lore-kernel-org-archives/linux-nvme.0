From: patrick.sheridan@seagate.com (Patrick Sheridan)
Date: Mon, 10 Oct 2016 08:58:36 -0600
Subject: nvme_admin_passthru DMA failure
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93D75FBDE@fmsmsx104.amr.corp.intel.com>
References: <CAEhN9jtotCMNBt9Oy7M_HDe_oqDHoMegf+trki+2255gyfoO0g@mail.gmail.com>
 <B58D82457FDA0744A320A2FC5AC253B93D75FBDE@fmsmsx104.amr.corp.intel.com>
Message-ID: <CAEhN9jtpkEGOOo88hDADkhuL09OgGTUgSDsqsqxGOG7+XDfMCA@mail.gmail.com>

Hi Keith,

It is a vendor specific command with opcode 0xC0 and is expected to
copy data from the host to the drive.
I think you hit the nail on the head:  nvme_is_write would indicate
that it's a read.
Out of curiosity, do you know why this worked in previous nvme drivers?

- Patrick

On Sat, Oct 8, 2016@1:00 PM, Busch, Keith <keith.busch@intel.com> wrote:
> Is this a vendor specific opcode? If so, what is the opcode value and what direction are you expecting the data transfer to go?
>
>
>> -----Original Message-----
>> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf Of Patrick Sheridan
>> Sent: Friday, October 7, 2016 3:15 PM
>> To: linux-nvme at lists.infradead.org
>> Subject: nvme_admin_passthru DMA failure
>>
>> There is a problem when using an NVME_IOCTL_ADMIN_CMD to submit an
>> nvme_admin_passthru struct such that user data
>> (nvme_passthru_cmd.addr) does not get DMA'd to the drive correctly.
>>
>> The problem first appeared in kernel tags/v4.5.1 and was absent in
>> tags/v4.5.  The only relevant difference between those was in
>> block/blk-core.c, so this is likely a block layer problem:
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index b83d297..45f4d7e 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -2198,7 +2198,7 @@ int blk_insert_cloned_request(struct
>> request_queue *q, struct request *rq)
>>         if (q->mq_ops) {
>>                 if (blk_queue_io_stat(q))
>>                         blk_account_io_start(rq, true);
>> -               blk_mq_insert_request(rq, false, true, true);
>> +               blk_mq_insert_request(rq, false, true, false);
>>                 return 0;
>>         }
