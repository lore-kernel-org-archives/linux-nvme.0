From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 20 Mar 2018 14:10:38 +0200
Subject: [PATCH 2/2] nvmet: Add port transport active flag
In-Reply-To: <f3207f48-7edb-cf91-ff12-304911f205f6@grimberg.me>
References: <1521452867-13619-1-git-send-email-israelr@mellanox.com>
 <1521452867-13619-2-git-send-email-israelr@mellanox.com>
 <e95daee3-691e-0d3f-b5da-2fca15c4d22a@grimberg.me>
 <817c9817-80eb-35a5-0aa9-a28594a031d9@mellanox.com>
 <f3207f48-7edb-cf91-ff12-304911f205f6@grimberg.me>
Message-ID: <d0ee8932-f51d-cbec-4519-eb4c2bc8397d@mellanox.com>



On 3/20/2018 1:30 PM, Sagi Grimberg wrote:
> 
>>>> tractive port flag means that nvmet transport is active and ready for
>>>> receiving requests from host.
>>>> It differ from enabled port state (port with subsystem symbolic link)
>>>> which doesn't guarantee this.
>>>> The tractive flag is necessary in case the physical ports become down
>>>> while nvmet ports are enabled.
>>>> In this case the port state remains enabled but tractive flag 
>>>> becomes false.
>>>>
>>>> The tractive flag will help the administrator to monitor the port state
>>>> from transport point of view.
>>>> The commit also add the ability to activate the port by simply writing
>>>> to tractive at the configfs.
>>>> e.g.: echo 1 > config/nvmet/ports/1/tractive
>>>
>>> Why this is a write-able variable? this is a state. I would rename it
>>> to be trstate.
>>
>> We need a write-able entry to bring-up a listener in case the 
>> port/link went down.
>> Would you prefer 2 new configfs entries ? trstate (RO) and tractivate 
>> (WO) ?
> 
> No, I would prefer a trstate which is RO and activation with a subsystem
> symlink. We can easily take care of re-activation in the transport.

The initial activation is done using a subsystem symlink.
Please share your idea for re-activation (IIRC you were against 
re-activation in the kernel and prefered a user space re-activation).
We are reffering to situations where the LLD is unloaded or some other 
fatal event occur (EEH on Power systems for example)...
