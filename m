From: vedant@lath.in (Vedant Lath)
Date: Thu, 12 Nov 2015 03:26:04 +0530
Subject: nvme: controller resets
In-Reply-To: <CAKajsGOdxWzK8TfpaLYpf25h=ZRfQbxRW47Q4aAHhCOunLK+FQ@mail.gmail.com>
References: <33aa688b8da3f41960d36e66aa1703d8@localhost>
 <20151110155110.GA31697@localhost.localdomain>
 <CAKajsGOdxWzK8TfpaLYpf25h=ZRfQbxRW47Q4aAHhCOunLK+FQ@mail.gmail.com>
Message-ID: <CAKajsGNGvWw1+B7X8HxdvP0MyvAawb_PStu_adOC8wogOF-Fbg@mail.gmail.com>

On Wed, Nov 11, 2015@3:58 AM, Vedant Lath <vedant@lath.in> wrote:
> On Tue, Nov 10, 2015@9:21 PM, Keith Busch <keith.busch@intel.com> wrote:
>> Not sure really. Normally I file a f/w bug for this kind of thing. :)
>>
>> But I'll throw out some potential ideas. Try trottling driver capabilities
>> and see if anything improves: reduce queue count to 1 and depth to 2
>> (requires code change).
>>
>> If you're able to recreate with reduced settings, then your controller's
>> failure can be caused by a single command, and it's hopefully just a
>> matter of finding that command.
>>
>> If the problem is not reproducible with reduced settings, then perhaps
>> it's related to concurrent queue usage or high depth, and you can play
>> with either to see if you discover anything interesting.
>>
>> Of course, I could be way off...
>
> Is there any way to monitor all the commands going through the wire?
> Wouldn't that help? That would at least tell us which NVMe command
> results in a reset, and the flow of the commands leading up to the
> reset can give us more context into the error.

Reducing I/O queue depth to 2 fixes the crash. Increasing I/O queue
depth to 3 again results in a crash.

I did some debugging with pr_debug() in __nvme_submit_cmd() and a few
other functions and found out that running partprobe -d is a very
simple test case. With I/O queue depth as 3, I got the following
trace:
[...]
[  307.045206] nvme: submit: QID 1 CMD opcode 2 flags 0 cid 0 NSID 1
[  307.045209] nvme: submit: rsvd2 0 metadata 0 prp1 2308943872 prp2 0
slba 48907264 length 0 control 0 dsmgmt 0 reftag 0 apptag 0 appmask 0
[  307.045311] nvme: nvme_finish_cmd called
[  308.474874] nvme: submit: QID 0 CMD opcode C flags 0 cid 0 NSID 0
[  308.474900] nvme: nvme_finish_cmd called
[  308.474908] nvme: async_req_completion called
(completion of add_id)
(run partprobe -d)
[  318.488668] nvme: submit: QID 1 CMD opcode 0 flags 0 cid 1 NSID 1
[  318.497900] nvme: nvme_finish_cmd called
[  318.498318] nvme: submit: QID 1 CMD opcode 0 flags 0 cid 1 NSID 1
[  318.498835] nvme: submit: QID 1 CMD opcode 2 flags 0 cid 0 NSID 1
[  318.498839] nvme: submit: rsvd2 0 metadata 0 prp1 6042226688 prp2 0
slba 76790 length 0 control 0 dsmgmt 0 reftag 0 apptag 0 appmask 0
[  319.472684] nvme 0000:04:00.0: Failed status: 3, reset controller
[  319.472946] nvme 0000:04:00.0: Cancelling I/O 0 QID 1
[  319.472952] nvme 0000:04:00.0: Cancelling I/O 1 QID 1
[  319.472983] nvme: MQES is 1023, compiled Q_DEPTH is 3, configured
q_depth is 3
[  335.069654] nvme 0000:04:00.0: Device not ready; aborting reset
[  335.069679] nvme 0000:04:00.0: Device failed to resume
[  335.071921] blk_update_request: I/O error, dev nvme0n1, sector 0
[  335.071931] blk_update_request: I/O error, dev nvme0n1, sector 614320
[  335.071947] Buffer I/O error on dev nvme0n1p1, logical block 76784,
async page read

With mkfs.btrfs /dev/nvme0n1p5, the last few messages before the crash were:
[  235.496658] nvme: submit: QID 1 CMD opcode 1 flags 0 cid 0 NSID 1
[  235.496668] nvme: nvme_finish_cmd called
[  235.496685] nvme: submit: QID 1 CMD opcode 1 flags 0 cid 1 NSID 1
[  235.496686] nvme: nvme_finish_cmd called
[  235.496696] nvme: submit: QID 1 CMD opcode 1 flags 0 cid 0 NSID 1
[  235.496710] nvme: nvme_finish_cmd called
[  235.496720] nvme: nvme_finish_cmd called
[  235.496731] nvme: submit: QID 1 CMD opcode 0 flags 0 cid 0 NSID 1
[  235.496753] nvme: submit: QID 1 CMD opcode 2 flags 0 cid 1 NSID 1
[  235.496755] nvme: submit: rsvd2 0 metadata 0 prp1 5897535488 prp2
2318221568 slba 41495303 length 0 control 0 dsmgmt 0 reftag 0 apptag 0
appmask 0
[  236.189627] nvme 0000:04:00.0: Failed status: 3, reset controller
[  236.189985] nvme 0000:04:00.0: Cancelling I/O 0 QID 1
[  236.189995] nvme 0000:04:00.0: Cancelling I/O 1 QID 1
[  236.190056] nvme: MQES is 1023, compiled Q_DEPTH is 3, configured
q_depth is 3
[  251.792099] nvme 0000:04:00.0: Device not ready; aborting reset
[  251.792140] nvme 0000:04:00.0: Device failed to resume
[  251.796491] blk_update_request: I/O error, dev nvme0n1, sector 331962424
[  251.796519] blk_update_request: I/O error, dev nvme0n1, sector 0
[  251.798340] Buffer I/O error on dev nvme0n1p5, logical block 7,
async page read

I am not sure when nvme_finish_cmd is called, does that mean that a
command has completed execution and it's request can be freed from the
completion queue?

In both cases, the controller crashes when FLUSH and WRITE commands
are in the queue at the same time.

What could be the best way around this firmware bug? There's no hope
that this will be fixed in a firmware update.
