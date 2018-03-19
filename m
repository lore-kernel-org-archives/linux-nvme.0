From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 19 Mar 2018 14:19:46 +0200
Subject: [PATCH 2/2] nvmet: Add port transport active flag
In-Reply-To: <20180319105649.vchnplwx4c5vjkhb@linux-x5ow.site>
References: <1521452867-13619-1-git-send-email-israelr@mellanox.com>
 <1521452867-13619-2-git-send-email-israelr@mellanox.com>
 <20180319101143.lfsy2lksp3zl5lcr@linux-x5ow.site>
 <3ff966fc-ee5c-e171-f427-638619ff706f@mellanox.com>
 <20180319105649.vchnplwx4c5vjkhb@linux-x5ow.site>
Message-ID: <afed58d5-4907-7532-35ab-d508cab5b8d1@mellanox.com>



On 3/19/2018 12:56 PM, Johannes Thumshirn wrote:
> On Mon, Mar 19, 2018@12:48:15PM +0200, Max Gurtovoy wrote:
>>
>>
>> On 3/19/2018 12:11 PM, Johannes Thumshirn wrote:
>>> On Mon, Mar 19, 2018@09:47:47AM +0000, Israel Rukshin wrote:
>>>> tractive port flag means that nvmet transport is active and ready for
>>>> receiving requests from host.
>>>> It differ from enabled port state (port with subsystem symbolic link)
>>> differs^
>>>
>>>
>>> Also, this would need an accompanying nvmetcli change as well.
>>
>> Are you reffereing to the current implementation ?
>> Which change is in your mind ?
>>
>> Currently the tractive flag will become true if the initial port
>> configuration will succeed (also using nvmetcli).
>> One can create a service/timer/script to check periodically the tractive
>> flag and echo 1 to it in case needed (for persistent target configuration).
> 
> No I was thinking of a nvmetcli command to administratively toggle the
> tractive flag from within nvmetcli.

Yup, we can add this incrementally.

> 
> It is exported via configfs 'CONFIGFS_ATTR(nvmet_, tractive);' so
> what's the purpose of a user controllable knob that can't be
> controlled by the tool that usually configures these?
> 
> Byte,
> 	   Johannes
> 
