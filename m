From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 29 May 2019 01:25:41 +0300
Subject: [PATCH 6/9] nvme: update list-subsys command to show the entire
 list
In-Reply-To: <0004494a-67a0-c010-5de6-fa66dcafff68@grimberg.me>
References: <1558951310-31066-1-git-send-email-maxg@mellanox.com>
 <1558951310-31066-7-git-send-email-maxg@mellanox.com>
 <0004494a-67a0-c010-5de6-fa66dcafff68@grimberg.me>
Message-ID: <8a754fd0-6abc-a000-0183-b6832df0f2ba@mellanox.com>


On 5/28/2019 10:48 PM, Sagi Grimberg wrote:
>
>> Make it similar to "nvme list" command. For that, remove the
>> unnecessary ana_state parsing (was introduced only if specific namespace
>> handle was given).
>
> No, this is useful! You're arbitrarily removing useful information from
> the display...
>
> nak from me on this one...

I intended to add it to different command (maybe to new "nvme multipath" 
command you suggested).

I don't understand why ANA state is so important attribute for a user 
that only asked "nvme list-subsys".

One can always run "nvme ana-log" command to get a full log page (I'll 
take a look on it and see if it can be improved per given namespace)
