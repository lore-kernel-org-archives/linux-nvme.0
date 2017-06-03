From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 3 Jun 2017 11:03:06 +0300
Subject: [PATCH v3 3/8] nvmet: implement namespace identify descriptor list
In-Reply-To: <20170603051856.GA7093@lst.de>
References: <20170602094536.25775-1-jthumshirn@suse.de>
 <20170602094536.25775-4-jthumshirn@suse.de>
 <4f03d4c0-6f7b-dbc4-b0ee-bebe77e80ea6@grimberg.me>
 <20170603051856.GA7093@lst.de>
Message-ID: <a7382b1a-7f7b-24cc-cf7d-734f943ad122@grimberg.me>


>>>   	switch (type) {
>>>   	case NVME_NQN_NVME:
>>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>>> index cfc5c7fb0ab7..4c6cb5ea1186 100644
>>> --- a/drivers/nvme/target/nvmet.h
>>> +++ b/drivers/nvme/target/nvmet.h
>>> @@ -46,6 +46,7 @@ struct nvmet_ns {
>>>   	u32			blksize_shift;
>>>   	loff_t			size;
>>>   	u8			nguid[16];
>>> +	uuid_be			uuid;
>>
>> This should be uuid_le to match the rest of NVMe.
> 
> It shouldn't.  A RFC4122 uuid is always in "big endian" notation.
> A little endiane uuid doesn't exist, it's called a GUID in Wintel
> speak and isn't used in NVMe.  My new uuid tree tries to fix up
> the confusion by renaming our uuid_be type to uuid_t and uuid_le
> to guid_t.

Thanks for clarifying.

At one point we had a uuid before we allowed user-space to pass a nguid
and it was little endian, but it was a hack anyway.
