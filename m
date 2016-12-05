From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 5 Dec 2016 16:08:01 +0200
Subject: [PATCH 1/3] nvmet: delete controllers deletion upon subsystem
 release
In-Reply-To: <20161205113907.GH8481@linux-x5ow.site>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-2-git-send-email-sagi@grimberg.me>
 <20161205113907.GH8481@linux-x5ow.site>
Message-ID: <a3074fea-0a1e-e5dc-03f8-6b4420c8a628@mellanox.com>



On 12/5/2016 1:39 PM, Johannes Thumshirn wrote:
> On Mon, Dec 05, 2016@01:09:04PM +0200, Sagi Grimberg wrote:
>> No reason for them to be kept around if we are
>> deleting the subsystem, so instead of passively
>> wait for the host to disconnect, actively delete
>> the controllers.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>
> Looks good,
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
>

Looks fine,
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
