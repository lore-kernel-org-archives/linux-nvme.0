From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 2 Jun 2017 15:54:40 +0200
Subject: [PATCH v3 3/8] nvmet: implement namespace identify descriptor list
In-Reply-To: <4f03d4c0-6f7b-dbc4-b0ee-bebe77e80ea6@grimberg.me>
References: <20170602094536.25775-1-jthumshirn@suse.de>
 <20170602094536.25775-4-jthumshirn@suse.de>
 <4f03d4c0-6f7b-dbc4-b0ee-bebe77e80ea6@grimberg.me>
Message-ID: <64fd1261-2019-5b37-a791-728105c84ac3@suse.de>

On 06/02/2017 03:46 PM, Sagi Grimberg wrote:
>> +    uuid_be            uuid;
> 
> This should be uuid_le to match the rest of NVMe.

Ahm, are you sure?
$ PAGER= git grep -E uuid_\(l\|b\)e drivers/nvme
drivers/nvme/host/fabrics.c:61:	uuid_be_gen(&host->id);
drivers/nvme/host/fabrics.c:78:	uuid_be_gen(&host->id);
drivers/nvme/host/fabrics.c:398:	memcpy(&data->hostid,
&ctrl->opts->host->id, sizeof(uuid_be));
drivers/nvme/host/fabrics.c:457:	memcpy(&data->hostid,
&ctrl->opts->host->id, sizeof(uuid_be));
drivers/nvme/host/fabrics.h:39:	uuid_be			id;
drivers/nvme/host/fc.c:882:		min_t(size_t, FCNVME_ASSOC_HOSTID_LEN,
sizeof(uuid_be)));
drivers/nvme/target/admin-cmd.c:324:	memcpy(&id->nguid, &ns->nguid,
sizeof(uuid_le));
drivers/nvme/target/configfs.c:328:	if (uuid_be_to_bin(page, &ns->uuid))
drivers/nvme/target/nvmet.h:49:	uuid_be			uuid;

And RFC4122 4.1.2 says MSB first as well.

> 
> Also, it would be useful to generate a random default with uuid_le_gen()
> for a better out-of-the-box experience.

Yep, sounds reasonable.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
