From: israelr@mellanox.com (Israel Rukshin)
Date: Mon, 5 Aug 2019 15:24:39 +0000
Subject: [PATCH 1/2] nvme-fabrics: Add type of service (TOS) configuration
In-Reply-To: <04c776f4-a04a-8256-c659-daa11fe78a29@grimberg.me>
References: <1564912530-15404-1-git-send-email-israelr@mellanox.com>
 <04c776f4-a04a-8256-c659-daa11fe78a29@grimberg.me>
Message-ID: <94d485bf-d1db-b75f-e918-32d46ca1c4c1@mellanox.com>

On 8/5/2019 6:10 PM, Sagi Grimberg wrote:
>
>> TOS is user-defined and needs to be configured via nvme-cli.
>> It must be set before initiating any traffic and once set the TOS
>> cannot be changed.
>
> Can you please have tcp support it too in the patch set (and test
> that it works)?
>
> Its simply setsockopt with SO_PRIORITY.

Hi,

Yes sure,? l will add support also for tcp.

Regards,

Israel
