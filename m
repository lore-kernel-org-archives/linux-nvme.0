From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 5 Dec 2016 16:08:52 +0200
Subject: [PATCH 2/3] nvmet: Make cntlid globally unique
In-Reply-To: <20161205113843.GG8481@linux-x5ow.site>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-3-git-send-email-sagi@grimberg.me>
 <20161205113843.GG8481@linux-x5ow.site>
Message-ID: <eac28c7d-c6c9-7dcf-844a-b3f0da3beaa8@mellanox.com>



On 12/5/2016 1:38 PM, Johannes Thumshirn wrote:
> On Mon, Dec 05, 2016@01:09:05PM +0200, Sagi Grimberg wrote:
>> We usually log the cntlid which is confusing in case
>> we have multiple subsystems each with it's own cntlid ida.
>> Instead make cntlid ida globally unique and log the initial
>> association.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>
> Looks good,
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
>

Looks fine,
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
