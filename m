From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 6 Mar 2019 17:14:52 -0800
Subject: [PATCH] nvmet-file: clamp-down file namespace lba_shift
In-Reply-To: <20190306204958.GA1603@localhost.localdomain>
References: <20190305095548.14934-1-sagi@grimberg.me>
 <SN6PR04MB4527C36DBCE293BDA6A7508786730@SN6PR04MB4527.namprd04.prod.outlook.com>
 <2a38f63f-2349-e852-e24e-a046a64bc923@grimberg.me>
 <SN6PR04MB4527804E0DF20A373E42BC2986730@SN6PR04MB4527.namprd04.prod.outlook.com>
 <20190306204958.GA1603@localhost.localdomain>
Message-ID: <90347fff-79c3-4d99-584a-e0b6735da51e@grimberg.me>


>>> Quick look shows that this is coming from blk_queue_stack_limits for the
>>> ns_head.
>>>
>>> Looks like nvme_update_disk_info() is reading a bs=0:
>>> --
>>>            unsigned short bs = 1 << ns->lba_shift;
>>> --
>>>
>>> bs is 16 bits and lba_shift is 20
>>> (coming directly from the tempfile file_inode(ns->file)->i_blkbits)
>>>
>>> So this fixes that one as well. Regardless, I think bs should be
>>> unsigned int?
>>
>> Yes.
> 
> blk_queue_logical_block_size() takes an 'unsigned short', so be sure to
> check 'bs' is less than USHRT_MAX.

So this means that we should fail ns allocation if lba_shift is more
than fits in a short.
