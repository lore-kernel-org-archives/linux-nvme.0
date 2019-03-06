From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 6 Mar 2019 12:19:04 -0800
Subject: [PATCH] nvmet-file: clamp-down file namespace lba_shift
In-Reply-To: <SN6PR04MB4527C36DBCE293BDA6A7508786730@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190305095548.14934-1-sagi@grimberg.me>
 <SN6PR04MB4527C36DBCE293BDA6A7508786730@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <2a38f63f-2349-e852-e24e-a046a64bc923@grimberg.me>


>> When the backing file is a tempfile for example, the inode i_blkbits
>> can be 1M in size which causes problems for hosts to support as the
>> disk block size.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>> This issue was observed in I/O errors in the log running test nvme/009.
>>
> We are not doing any I/O in nvme/009 explicitly using dd/fio, is this
> due to internal commands we send as a part of connect and disconnect ?
> Or test number is different ?

The former.

Also, I just now hit a divide by zero BUG when running test 009 with
multipath enabled.

Quick look shows that this is coming from blk_queue_stack_limits for the
ns_head.

Looks like nvme_update_disk_info() is reading a bs=0:
--
         unsigned short bs = 1 << ns->lba_shift;
--

bs is 16 bits and lba_shift is 20
(coming directly from the tempfile file_inode(ns->file)->i_blkbits)

So this fixes that one as well. Regardless, I think bs should be
unsigned int?
