From: marc.smith@mcc.edu (Marc Smith)
Date: Tue, 21 Feb 2017 11:42:33 -0500
Subject: Linux 4.9.8 + NVMe CiB Issue
In-Reply-To: <CAHkw+LfthNu5Bs5xFNw3YRNmTHxFpea1E_W--f4ZVvd_gnMs0g@mail.gmail.com>
References: <CAHkw+LcMtBp_xC6YdR-c=P-feZJvukNtkeEWueJ_y9wkAg2hUA@mail.gmail.com>
 <20170215211240.GA23472@localhost.localdomain>
 <CAHkw+Lfy-3b+Dg4Bwfg1ViBSNrWsiiuBSXJTcu2VQNdfBRcB0g@mail.gmail.com>
 <CAHkw+LfthNu5Bs5xFNw3YRNmTHxFpea1E_W--f4ZVvd_gnMs0g@mail.gmail.com>
Message-ID: <CAHkw+Lem6EzvxwPYK+5R02rdDARzNxjCKGZXc-vDzLcdj8FJnQ@mail.gmail.com>

I thought I just resolved this, but it choked again... I should have
checked this first, but didn't: The firmware version / available
updates. Our drives were on 8DV101D0 and then we updated to 8DV101H0.
And even in the release notes for the firmware it lists:

8DV101H0 - Multiple PCIe Link Dynamic Equalization updates
- SQ Header Pointer Mismatch fix
- Drive Drop issue under heavy IO testing
- Drive unresponsive during concurrent IO and NVMe-MI Basic Management Commands
- XN022 Assert Fixes
- Sequential read performance improvement at end of life from firmware 8DV101D0

I saw the "drive drop issue under heavy IO testing" and was hopeful it
was related. The test seemed to go longer before a drive dropped out,
but still only after a few minutes, several of the NVMe drives
disappeared.

Should we be opening a support request with Intel (hardware), or is
linux-nvme the appropriate forum?


Thanks,

Marc



On Mon, Feb 20, 2017@11:43 AM, Marc Smith <marc.smith@mcc.edu> wrote:
> Hi,
>
> A little more information... I attempted the same test using a Linux
> 4.9.8 kernel with a number of debugging options set, but I am unable
> to reproduce the NVMe timeout issue with that kernel configuration.
> With the debug kernel, I'm only able to obtain about 1.5 million IOPS,
> which is expected with all the extra options set. So it doesn't appear
> its an issue with using all eight of the NVMe devices at once, it
> appears to be load/IO related. Its a different NVMe drive each time
> too that gives the timeout error, so not a single device causing this,
> at least from what I can tell.
>
> I also tried the same test on the second server connected to the NVMe
> drives and I'm able to reproduce the failure on that machine as well,
> so I don't think its related to the physical servers.
>
> Anything else I can check? I realize we'll probably never push 3
> million IOPS in production, but I'd like to get any stability issues
> sorted out before continuing. =)
>
> Thanks for your time.
>
>
> --Marc
>
> On Thu, Feb 16, 2017@10:37 AM, Marc Smith <marc.smith@mcc.edu> wrote:
>> On Wed, Feb 15, 2017@4:12 PM, Keith Busch <keith.busch@intel.com> wrote:
>>> On Wed, Feb 15, 2017@02:27:13PM -0500, Marc Smith wrote:
>>>> Hi,
>>>>
>>>> I'm testing with a Supermicro SSG-2028R-DN2R40L NVMe CiB
>>>> (cluster-in-a-box) solution. The performance is amazing so far, but I
>>>> experienced an issue during a performance test while using the fio
>>>> tool.
>>>>
>>>> Linux 4.9.8
>>>> fio 2.14
>>>>
>>>> We have just (8) NVMe drives in the "enclosure", and it contains two
>>>> server nodes, but right now we're just testing from one of the nodes.
>>>>
>>>> This is the command we ran:
>>>> fio --bs=4k --direct=1 --rw=randread --ioengine=libaio --iodepth=12
>>>> --numjobs=16 --name=/dev/nvme0n1 --name=/dev/nvme1n1
>>>> --name=/dev/nvme2n1 --name=/dev/nvme3n1 --name=/dev/nvme4n1
>>>> --name=/dev/nvme5n1 --name=/dev/nvme6n1 --name=/dev/nvme7n1
>>>>
>>>> After a few seconds, noticed the performance numbers started dropping,
>>>> and started flaking out. This is what we saw in the kernel logs:
>>>
>>> It looks like your controller stopped posting completions to commands.
>>>
>>> There is some excessive kernel spamming going on here, though, but that
>>> fix is already staged for 4.11 inclusion here:
>>>
>>>   http://git.infradead.org/nvme.git/commitdiff/7bf7d778620d83f14fcd92d0938fb97c7d78bf19?hp=9a69b0ed6257ae5e71c99bf21ce53f98c558476a
>>>
>>> As to why the driver was triggered to abort IO in the first place, that
>>> appears to be the device not posting completions on time. As far as I
>>> can tell, blk-mq's timeout handling won't mistakenly time out a command
>>> on the initial abort, and the default 30 second timeout should be more
>>> than enough for your workload.
>>>
>>> There does appear to be a small window where blk-mq can miss a completion,
>>> though: blk-mq's timeout handler sets the REQ_ATOM_COMPLETE flag
>>> while running the timeout handler, which blocks a natural completion
>>> from occuring while set. So if a real completion did occur, then that
>>> completion is lost, which will force the subseqent timeout handler to
>>> issue a controller reset.
>>>
>>> But I don't think that's what's happening here. You are getting time
>>> outs on admin commands as well, so that really looks like your
>>> controller just stopped responding.
>>
>> Thanks for the quick reply; so, I rebooted both nodes that are
>> attached to the NVMe drives, and all (8) NVMe devices appear on both
>> nodes after reboot, including the nvme0 device that had disappeared
>> before. I then hammered the nvme0n1 device, by itself, using fio to
>> try and reproduce this same issue, but couldn't do so. I ran fio with
>> huge I/O depths and jobs for hours, and still couldn't reproduce this.
>>
>> Then, I ran the same test again that caused the original issue,
>> running fio across all (8) of the NVMe drives:
>> fio --bs=4k --direct=1 --rw=randread --ioengine=libaio --iodepth=12
>> --numjobs=16 --name=/dev/nvme0n1 --name=/dev/nvme1n1
>> --name=/dev/nvme2n1 --name=/dev/nvme3n1 --name=/dev/nvme4n1
>> --name=/dev/nvme5n1 --name=/dev/nvme6n1 --name=/dev/nvme7n1
>>
>> Within a minute or two, I noticed similar kernel messages but with a
>> different NVMe drive this time, and as before, the NVMe drive
>> disappears from both servers. Here are the logs:
>>
>> --snip--
>> [ 5329.400622] nvme nvme7: I/O 930 QID 1 timeout, aborting
>> [ 5329.400628] nvme nvme7: I/O 931 QID 1 timeout, aborting
>> [ 5329.400630] nvme nvme7: I/O 932 QID 1 timeout, aborting
>> [ 5329.400631] nvme nvme7: I/O 933 QID 1 timeout, aborting
>> [ 5359.413460] nvme nvme7: I/O 930 QID 1 timeout, reset controller
>> [ 5389.618277] nvme nvme7: I/O 130 QID 0 timeout, reset controller
>> [ 5419.927512] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927513] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927515] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927517] blk_update_request: I/O error, dev nvme7n1, sector 635173168
>> [ 5419.927519] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927521] blk_update_request: I/O error, dev nvme7n1, sector 1500458320
>> [ 5419.927523] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927524] blk_update_request: I/O error, dev nvme7n1, sector 1402863672
>> [ 5419.927526] blk_update_request: I/O error, dev nvme7n1, sector 1930822624
>> [ 5419.927527] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927529] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927531] blk_update_request: I/O error, dev nvme7n1, sector 1060940040
>> [ 5419.927532] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927533] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927535] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927536] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927537] blk_update_request: I/O error, dev nvme7n1, sector 697098256
>> [ 5419.927538] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927540] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927541] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927542] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927543] blk_update_request: I/O error, dev nvme7n1, sector 1803921928
>> [ 5419.927546] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927548] blk_update_request: I/O error, dev nvme7n1, sector 231221800
>> [ 5419.927549] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927550] blk_update_request: I/O error, dev nvme7n1, sector 1411290456
>> [ 5419.927551] blk_update_request: I/O error, dev nvme7n1, sector 1888075000
>> [ 5419.927553] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927554] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927555] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927556] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927557] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927559] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927560] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927561] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927562] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927564] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927565] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927566] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927568] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927570] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927570] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927571] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927572] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927573] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927575] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927576] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927577] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927578] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927579] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927581] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927582] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927583] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927584] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927585] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927586] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927587] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927590] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927592] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927593] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927595] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927596] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927597] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927598] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927599] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927600] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927601] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927604] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927606] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927607] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927609] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927610] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927611] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927612] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927615] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927616] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927617] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927619] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927620] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927621] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927621] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927624] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927626] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927627] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927628] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927630] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927631] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927634] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927635] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927636] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927637] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927639] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927640] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927642] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927644] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927645] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927647] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927648] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927649] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927651] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927654] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927655] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927656] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927657] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927658] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927659] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927660] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927663] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927664] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927665] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927666] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927667] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927668] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927671] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927672] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927674] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927675] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927677] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927678] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927681] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927682] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927683] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927687] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927688] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927691] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927693] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927695] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927699] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927701] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927704] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927706] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927709] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927714] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927718] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927724] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927730] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927733] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927737] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927742] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927745] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927749] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927752] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927753] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927755] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927757] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927758] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927760] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927764] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927765] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927767] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927769] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927771] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927772] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927774] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927776] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927778] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927780] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927781] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927784] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927790] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927792] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927794] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927796] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927797] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927799] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927801] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927802] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927804] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927806] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927808] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927810] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927815] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927817] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927819] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927820] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927822] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927824] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927826] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927827] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927829] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927831] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927832] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927835] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927839] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927840] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927842] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927844] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927846] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927847] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927849] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927850] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927852] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927854] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927855] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927859] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927861] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927863] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927865] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927867] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927868] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927870] nvme nvme7: completing aborted command with status: 0007
>> [ 5419.927873] nvme nvme7: Abort status: 0x7
>> [ 5419.927874] nvme nvme7: Abort status: 0x7
>> [ 5419.927875] nvme nvme7: Abort status: 0x7
>> [ 5419.927896] nvme nvme7: completing aborted command with status: fffffffc
>> [ 5419.927966] nvme nvme7: Abort status: 0xfffc
>> [ 5419.928223] ------------[ cut here ]------------
>> [ 5419.928233] WARNING: CPU: 19 PID: 1438 at fs/sysfs/dir.c:31
>> sysfs_warn_dup+0x53/0x5f
>> [ 5419.928234] sysfs: cannot create duplicate filename
>> '/devices/pci0000:80/0000:80:03.0/0000:82:00.0/0000:83:07.0/0000:87:00.0/nvme/nvme7/cmb'
>> [ 5419.928235] Modules linked in: qla2xxx bonding mlx5_core bna
>> [ 5419.928241] CPU: 19 PID: 1438 Comm: kworker/u114:1 Not tainted
>> 4.9.8-esos.prod #1
>> [ 5419.928242] Hardware name: Supermicro SSG-2028R-DN2R40L/X10DSN-TS,
>> BIOS 2.0 10/28/2016
>> [ 5419.928248] Workqueue: nvme nvme_reset_work
>> [ 5419.928250]  0000000000000000 ffffffff81397af8 ffffc9000b00fcf0
>> 0000000000000000
>> [ 5419.928252]  ffffffff81065550 ffff88085a139000 ffffc9000b00fd48
>> ffff880858b21d20
>> [ 5419.928254]  ffff88105b34b000 00000000e6000000 ffff881059993938
>> ffffffff810655af
>> [ 5419.928256] Call Trace:
>> [ 5419.928264]  [<ffffffff81397af8>] ? dump_stack+0x46/0x59
>> [ 5419.928269]  [<ffffffff81065550>] ? __warn+0xc8/0xe1
>> [ 5419.928271]  [<ffffffff810655af>] ? warn_slowpath_fmt+0x46/0x4e
>> [ 5419.928275]  [<ffffffff81182ce0>] ? kernfs_path_from_node+0x4e/0x58
>> [ 5419.928277]  [<ffffffff81184e5c>] ? sysfs_warn_dup+0x53/0x5f
>> [ 5419.928279]  [<ffffffff81184c39>] ? sysfs_add_file_mode_ns+0xd1/0x14d
>> [ 5419.928281]  [<ffffffff81184d7c>] ? sysfs_add_file_to_group+0x3c/0x4b
>> [ 5419.928282]  [<ffffffff815dae5f>] ? nvme_reset_work+0x415/0xb25
>> [ 5419.928286]  [<ffffffff81076a58>] ? process_one_work+0x192/0x29b
>> [ 5419.928287]  [<ffffffff81077096>] ? worker_thread+0x26e/0x356
>> [ 5419.928289]  [<ffffffff81076e28>] ? rescuer_thread+0x2a0/0x2a0
>> [ 5419.928292]  [<ffffffff810686e8>] ? do_group_exit+0x39/0x91
>> [ 5419.928295]  [<ffffffff8107abe2>] ? kthread+0xc2/0xca
>> [ 5419.928296]  [<ffffffff8107ab20>] ? kthread_park+0x4e/0x4e
>> [ 5419.928300]  [<ffffffff81a7ed22>] ? ret_from_fork+0x22/0x30
>> [ 5419.928310] ---[ end trace 9d1818416c7876e0 ]---
>> [ 5419.928313] nvme 0000:87:00.0: failed to add sysfs attribute for CMB
>> [ 5420.031107] do_IRQ: 1.66 No irq handler for vector
>> [ 5480.488746] nvme nvme7: I/O 215 QID 0 timeout, disable controller
>> [ 5480.488755] ------------[ cut here ]------------
>> [ 5480.488766] WARNING: CPU: 19 PID: 1233 at kernel/irq/manage.c:1478
>> __free_irq+0x93/0x1ed
>> [ 5480.488767] Trying to free already-free IRQ 443
>> [ 5480.488768] Modules linked in: qla2xxx bonding mlx5_core bna
>> [ 5480.488775] CPU: 19 PID: 1233 Comm: kworker/19:1H Tainted: G
>> W       4.9.8-esos.prod #1
>> [ 5480.488776] Hardware name: Supermicro SSG-2028R-DN2R40L/X10DSN-TS,
>> BIOS 2.0 10/28/2016
>> [ 5480.488785] Workqueue: kblockd blk_mq_timeout_work
>> [ 5480.488786]  0000000000000000 ffffffff81397af8 ffffc9000be9fb88
>> 0000000000000000
>> [ 5480.488789]  ffffffff81065550 ffff880859f08800 ffffc9000be9fbe0
>> 00000000000001bb
>> [ 5480.488792]  ffff880859f0889c ffff8810584abb00 0000000000000246
>> ffffffff810655af
>> [ 5480.488794] Call Trace:
>> [ 5480.488801]  [<ffffffff81397af8>] ? dump_stack+0x46/0x59
>> [ 5480.488808]  [<ffffffff81065550>] ? __warn+0xc8/0xe1
>> [ 5480.488810]  [<ffffffff810655af>] ? warn_slowpath_fmt+0x46/0x4e
>> [ 5480.488812]  [<ffffffff8139c224>] ? __radix_tree_lookup+0x2c/0x93
>> [ 5480.488814]  [<ffffffff8109d5b0>] ? __free_irq+0x93/0x1ed
>> [ 5480.488816]  [<ffffffff8109d7a5>] ? free_irq+0x61/0x72
>> [ 5480.488823]  [<ffffffff815d9e2b>] ? nvme_suspend_queue+0x66/0x6b
>> [ 5480.488825]  [<ffffffff815da001>] ? nvme_dev_disable+0x96/0x30b
>> [ 5480.488831]  [<ffffffff8148ebd6>] ? dev_warn+0x50/0x58
>> [ 5480.488833]  [<ffffffff815da368>] ? nvme_timeout+0x59/0x186
>> [ 5480.488835]  [<ffffffff81386956>] ? blk_mq_rq_timed_out+0x5e/0x5e
>> [ 5480.488836]  [<ffffffff8138691f>] ? blk_mq_rq_timed_out+0x27/0x5e
>> [ 5480.488838]  [<ffffffff8138816f>] ? bt_for_each+0xaf/0xca
>> [ 5480.488840]  [<ffffffff81386956>] ? blk_mq_rq_timed_out+0x5e/0x5e
>> [ 5480.488841]  [<ffffffff81386956>] ? blk_mq_rq_timed_out+0x5e/0x5e
>> [ 5480.488842]  [<ffffffff813885df>] ? blk_mq_queue_tag_busy_iter+0x7b/0x88
>> [ 5480.488844]  [<ffffffff81385677>] ? blk_mq_timeout_work+0x7d/0x102
>> [ 5480.488848]  [<ffffffff81076a58>] ? process_one_work+0x192/0x29b
>> [ 5480.488850]  [<ffffffff81077096>] ? worker_thread+0x26e/0x356
>> [ 5480.488851]  [<ffffffff81076e28>] ? rescuer_thread+0x2a0/0x2a0
>> [ 5480.488853]  [<ffffffff8107abe2>] ? kthread+0xc2/0xca
>> [ 5480.488855]  [<ffffffff8107ab20>] ? kthread_park+0x4e/0x4e
>> [ 5480.488861]  [<ffffffff81a7ed22>] ? ret_from_fork+0x22/0x30
>> [ 5480.488862] ---[ end trace 9d1818416c7876e1 ]---
>> [ 5480.489161] nvme nvme7: Removing after probe failure status: -4
>> [ 5480.489181] nvme7n1: detected capacity change from 1000204886016 to 0
>> --snip--
>>
>> While running this test, I see fio showing 100% random, 100% read 4K
>> IOPS numbers of ~2.9M IOPS, and then when I see it suddenly drop to
>> ~2.5M IOPS, I then look at the kernel logs and see the above.
>>
>>
>> Thanks,
>>
>> Marc
>>
>>>
>>>> --snip--
>>>> [70961.868655] nvme nvme0: I/O 1009 QID 1 timeout, aborting
>>>> [70961.868666] nvme nvme0: I/O 1010 QID 1 timeout, aborting
>>>> [70961.868670] nvme nvme0: I/O 1011 QID 1 timeout, aborting
>>>> [70961.868673] nvme nvme0: I/O 1013 QID 1 timeout, aborting
>>>> [70992.073974] nvme nvme0: I/O 1009 QID 1 timeout, reset controller
>>>> [71022.727229] nvme nvme0: I/O 237 QID 0 timeout, reset controller
