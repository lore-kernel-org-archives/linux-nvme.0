From: robert.r.randall@gmail.com (Robert Randall)
Date: Tue, 21 Jun 2016 10:20:04 -0500
Subject: Windows NVMeoF client - debug assistance requested
In-Reply-To: <CAEqzOjuvLx3v1zqZhdepOHN-5fvovF20wPybBNgDfpR3CRqM1w@mail.gmail.com>
References: <3286b6ca966947ff8aca316b5ab56435@bowex36e.micron.com>
 <57694CDB.7010206@grimberg.me>
 <CAEqzOjuvLx3v1zqZhdepOHN-5fvovF20wPybBNgDfpR3CRqM1w@mail.gmail.com>
Message-ID: <CAEqzOjvbShKm0UOFsb9q=GydJKLvjyne62gdwLSmXb8pjeGSHw@mail.gmail.com>

Well, this is interesting, based on the telemetry from the block layer
the write is going down as a read!!  I'll start looking for the bug.

8975474 Jun 21 10:10:38 nvmeof0 kernel: [  160.772992] nvmet_rdma:
drivers/nvme/target/rdma.c nvmet_rdma_read_data_done 552
8975475 Jun 21 10:10:38 nvmeof0 kernel: [  160.772996] nvmet:
drivers/nvme/target/io-cmd.c nvmet_execute_rw 62
8975476 Jun 21 10:10:38 nvmeof0 kernel: [  160.772998] nvmet:
drivers/nvme/target/io-cmd.c nvmet_execute_rw 71 WRITE
8975477 Jun 21 10:10:38 nvmeof0 kernel: [  160.773005] nvmet:
req->cmd->rw details
8975478 Jun 21 10:10:38 nvmeof0 kernel: [  160.773011] nvmet: __u8 opcode 1
8975479 Jun 21 10:10:38 nvmeof0 kernel: [  160.773013] nvmet: __u8 flags 40
8975480 Jun 21 10:10:38 nvmeof0 kernel: [  160.773015] nvmet: __u16 command_id 3
8975481 Jun 21 10:10:38 nvmeof0 kernel: [  160.773017] nvmet: __le32 nsid 1
8975482 Jun 21 10:10:38 nvmeof0 kernel: [  160.773019] nvmet: __u64 rsvd2 0
8975483 Jun 21 10:10:38 nvmeof0 kernel: [  160.773030] nvmet: __le64 metadata 0
8975484 Jun 21 10:10:38 nvmeof0 kernel: [  160.773035] nvmet: __le64
dptr.ksgl.addr FFFFD0009D6B4400
8975485 Jun 21 10:10:38 nvmeof0 kernel: [  160.773037] nvmet: __u8
dptr.ksgl.length[0] 0
8975486 Jun 21 10:10:38 nvmeof0 kernel: [  160.773040] nvmet: __u8
dptr.ksgl.length[1] 2
8975487 Jun 21 10:10:38 nvmeof0 kernel: [  160.773042] nvmet: __u8
dptr.ksgl.length[2] 0
8975488 Jun 21 10:10:38 nvmeof0 kernel: [  160.773044] nvmet: __u8
dptr.ksgl.key[0] F
8975489 Jun 21 10:10:38 nvmeof0 kernel: [  160.773047] nvmet: __u8
dptr.ksgl.key[1] 85
8975490 Jun 21 10:10:38 nvmeof0 kernel: [  160.773055] nvmet: __u8
dptr.ksgl.key[2] 1
8975491 Jun 21 10:10:38 nvmeof0 kernel: [  160.773064] nvmet: __u8
dptr.ksgl.key[3] BA
8975492 Jun 21 10:10:38 nvmeof0 kernel: [  160.773066] nvmet: __u8
dptr.ksgl.type 40
8975493 Jun 21 10:10:38 nvmeof0 kernel: [  160.773068] nvmet: __le64 slba 0
8975494 Jun 21 10:10:38 nvmeof0 kernel: [  160.773071] nvmet: __le16 length 0
8975495 Jun 21 10:10:38 nvmeof0 kernel: [  160.773072] nvmet: __le16 control 0
8975496 Jun 21 10:10:38 nvmeof0 kernel: [  160.773075] nvmet: __le32 dsmgmt 0
8975497 Jun 21 10:10:38 nvmeof0 kernel: [  160.773077] nvmet: __le32 reftag 0
8975498 Jun 21 10:10:38 nvmeof0 kernel: [  160.773085] nvmet: __le16 apptag 0
8975499 Jun 21 10:10:38 nvmeof0 kernel: [  160.773094] nvmet: __le16 appmask 0
8975500 Jun 21 10:10:38 nvmeof0 kernel: [  160.773101] nvmet: bio before
8975501 Jun 21 10:10:38 nvmeof0 kernel: [  160.773103] nvmet: bio->bi_flags 0
8975502 Jun 21 10:10:38 nvmeof0 kernel: [  160.773105] nvmet: bio->bi_error 0
8975503 Jun 21 10:10:38 nvmeof0 kernel: [  160.773107] nvmet: bio->bi_rw 0
8975504 Jun 21 10:10:38 nvmeof0 kernel: [  160.773109] nvmet: bio->bi_ioprio 0
8975505 Jun 21 10:10:38 nvmeof0 kernel: [  160.773112] nvmet:
bio->bi_phys_segments 0
8975506 Jun 21 10:10:38 nvmeof0 kernel: [  160.773114] nvmet:
bio->bi_phys_segments 0
8975507 Jun 21 10:10:38 nvmeof0 kernel: [  160.773117] nvmet:
drivers/nvme/target/io-cmd.c nvmet_execute_rw 123 sg_cnt 1
**************8975508 Jun 21 10:10:38 nvmeof0 kernel: [  160.773124]
kworker/u17:1(3103): READ block 0 on nvme1n1 (1 sectors) ***********
8975509 Jun 21 10:10:38 nvmeof0 kernel: [  160.773134] nvmet:
drivers/nvme/target/io-cmd.c nvmet_execute_rw 146 calling blk_poll
8975510 Jun 21 10:10:38 nvmeof0 kernel: [  160.773136] nvmet: bio after
8975511 Jun 21 10:10:38 nvmeof0 kernel: [  160.773138] nvmet: bio->bi_flags 2
8975512 Jun 21 10:10:38 nvmeof0 kernel: [  160.773140] nvmet: bio->bi_error 0
8975513 Jun 21 10:10:38 nvmeof0 kernel: [  160.773142] nvmet: bio->bi_rw 0
8975514 Jun 21 10:10:38 nvmeof0 kernel: [  160.773144] nvmet: bio->bi_ioprio 0
8975515 Jun 21 10:10:38 nvmeof0 kernel: [  160.773146] nvmet:
bio->bi_phys_segments 1
8975516 Jun 21 10:10:38 nvmeof0 kernel: [  160.773149] nvmet:
bio->bi_phys_segments 1
8975517 Jun 21 10:10:38 nvmeof0 kernel: [  160.773165] nvmet:
drivers/nvme/target/io-cmd.c nvmet_bio_done 29
8975518 Jun 21 10:10:38 nvmeof0 kernel: [  160.773166] nvmet: block io complete
8975519 Jun 21 10:10:38 nvmeof0 kernel: [  160.773168] nvmet:
drivers/nvme/target/core.c nvmet_req_complete 427
8975520 Jun 21 10:10:38 nvmeof0 kernel: [  160.773169] nvmet: request
is complete.
8975521 Jun 21 10:10:38 nvmeof0 kernel: [  160.773170] nvmet:
drivers/nvme/target/core.c __nvmet_req_complete 406
8975522 Jun 21 10:10:38 nvmeof0 kernel: [  160.773172] nvmet:
__nvmet_req_complete status is zero 0
8975523 Jun 21 10:10:38 nvmeof0 kernel: [  160.773173] nvmet:
__nvmet_req_complete status not set on request!!

On Tue, Jun 21, 2016 at 9:55 AM, Robert Randall
<robert.r.randall@gmail.com> wrote:
> Correct, we don't use in-capsule data.  What is confusing is that the
> reads are working fine without in-capsule data.  The writes are
> failing silently.  Nothing in the protocol indicates an error but the
> bits never get to the device.
>
> On Tue, Jun 21, 2016@9:19 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>> Hello all,
>>>
>>> We were making great progress on a Windows version of the NVMe over
>>> Fabrics host / initiator / client until we ran into something very
>>> interesting.  All of read/write requests from the client execute without any
>>> errors reported on either side, the Linux server is happy and the Windows
>>> client is happy.  The interesting part is that the writes never make it to
>>> the device.  The write completes with success but a subsequent read does not
>>> return what was written.  We've verified the command packets, etc. and the
>>> writes look just fine and do succeed but the data never makes it to the
>>> device.  The server reports no errors and returns success.
>>>
>>> If we use the Linux host to write data to the device or just 'dd' a good
>>> partition table to the device we can read it without any problems from
>>> Windows.
>>>
>>> I could use some advice on the best strategy to track this down.
>>>
>>> The traffic generated by the Linux host and Windows host are quite
>>> similar.  The only difference that might be interesting are the RDMA
>>> addresses.  On Linux they tend to be low in the address range.  On Windows
>>> they tend to be high in the address range.  But this is true of the reads as
>>> well.
>>>
>>> A sample write from the Linux host:
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087148] nvmet:
>>> drivers/nvme/target/core.c nvmet_req_init 499
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087149] nvmet:  struct
>>> nvme_common_command {
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087150] nvmet: __u8 opcode 1
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087151] nvmet: __u8 flags 40
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087153] nvmet: __u16 command_id 78
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087154] nvmet: __le32 nsid 1
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087155] nvmet: __le32 cdw2[0] 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087156] nvmet: __le32 cdw2[1] 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087157] nvmet: __le64 metadata 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087158] nvmet: union nvme_data_ptr
>>> { nvme_keyed_sgl_desc
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087159] nvmet:
>>> nvme_keyed_sgl_desc.__le64 addr 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087161] nvmet:
>>> nvme_keyed_sgl_desc.__u8 length[0] 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087162] nvmet:
>>> nvme_keyed_sgl_desc.__u8 length[1] 10
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087163] nvmet:
>>> nvme_keyed_sgl_desc.__u8 length[2] 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087164] nvmet:
>>> nvme_keyed_sgl_desc.__u8 key[0] 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087166] nvmet:
>>> nvme_keyed_sgl_desc.__u8 key[1] 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087167] nvmet:
>>> nvme_keyed_sgl_desc.__u8 key[2] 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087168] nvmet:
>>> nvme_keyed_sgl_desc.__u8 key[3] 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087169] nvmet:
>>> nvme_keyed_sgl_desc.__u8 type 1
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087170] nvmet: __le32 cdw10[0] 9C8
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087171] nvmet: __le32 cdw10[1] 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087173] nvmet: __le32 cdw10[2] 7
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087174] nvmet: __le32 cdw10[3] 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087175] nvmet: __le32 cdw10[4] 0
>>> Jun 20 16:36:48 nvmeof0 kernel: [ 4024.087176] nvmet: __le32 cdw10[5] 0
>>>
>>> A sample write from the Windows host:
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109389] nvmet:  struct
>>> nvme_common_command {
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109390] nvmet: __u8 opcode 1
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109391] nvmet: __u8 flags 40
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109392] nvmet: __u16 command_id A
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109394] nvmet: __le32 nsid 1
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109395] nvmet: __le32 cdw2[0] 0
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109396] nvmet: __le32 cdw2[1] 0
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109397] nvmet: __le64 metadata 0
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109398] nvmet: union nvme_data_ptr
>>> { nvme_keyed_sgl_desc
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109400] nvmet:
>>> nvme_keyed_sgl_desc.__le64 addr FFFFD0009BB95040
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109401] nvmet:
>>> nvme_keyed_sgl_desc.__u8 length[0] 0
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109402] nvmet:
>>> nvme_keyed_sgl_desc.__u8 length[1] 2
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109405] nvmet:
>>> nvme_keyed_sgl_desc.__u8 length[2] 0
>>
>>
>> Looks like the writes differ in length (4k vs. 512).
>>
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109406] nvmet:
>>> nvme_keyed_sgl_desc.__u8 key[0] A
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109407] nvmet:
>>> nvme_keyed_sgl_desc.__u8 key[1] 64
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109408] nvmet:
>>> nvme_keyed_sgl_desc.__u8 key[2] 1
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109409] nvmet:
>>> nvme_keyed_sgl_desc.__u8 key[3] 92
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109411] nvmet:
>>> nvme_keyed_sgl_desc.__u8 type 40
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109412] nvmet: __le32 cdw10[0] 21
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109413] nvmet: __le32 cdw10[1] 0
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109414] nvmet: __le32 cdw10[2] 0
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109415] nvmet: __le32 cdw10[3] 0
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109416] nvmet: __le32 cdw10[4] 0
>>> Jun 20 17:26:47 nvmeof0 kernel: [ 7023.109418] nvmet: __le32 cdw10[5] 0
>>
>>
>> Looks like you never use in-capsule data (which we do in linux for 4k
>> or less), you passed to the target:
>> {addr=0xFFFFD0009BB95040, length=0x200, key=0x9201640a}
>>
>> Are you sure that this is the buffer address you have registered with
>> the device? Do you see the actual data travel the wire?
>>
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
>
>
> --
> Robert Randall | robert.r.randall at gmail.com



-- 
Robert Randall | robert.r.randall at gmail.com
