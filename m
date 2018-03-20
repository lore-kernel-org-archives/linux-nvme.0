From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 20 Mar 2018 13:30:18 +0200
Subject: [PATCH 2/2] nvmet: Add port transport active flag
In-Reply-To: <817c9817-80eb-35a5-0aa9-a28594a031d9@mellanox.com>
References: <1521452867-13619-1-git-send-email-israelr@mellanox.com>
 <1521452867-13619-2-git-send-email-israelr@mellanox.com>
 <e95daee3-691e-0d3f-b5da-2fca15c4d22a@grimberg.me>
 <817c9817-80eb-35a5-0aa9-a28594a031d9@mellanox.com>
Message-ID: <f3207f48-7edb-cf91-ff12-304911f205f6@grimberg.me>


>>> tractive port flag means that nvmet transport is active and ready for
>>> receiving requests from host.
>>> It differ from enabled port state (port with subsystem symbolic link)
>>> which doesn't guarantee this.
>>> The tractive flag is necessary in case the physical ports become down
>>> while nvmet ports are enabled.
>>> In this case the port state remains enabled but tractive flag becomes 
>>> false.
>>>
>>> The tractive flag will help the administrator to monitor the port state
>>> from transport point of view.
>>> The commit also add the ability to activate the port by simply writing
>>> to tractive at the configfs.
>>> e.g.: echo 1 > config/nvmet/ports/1/tractive
>>
>> Why this is a write-able variable? this is a state. I would rename it
>> to be trstate.
> 
> We need a write-able entry to bring-up a listener in case the port/link 
> went down.
> Would you prefer 2 new configfs entries ? trstate (RO) and tractivate 
> (WO) ?

No, I would prefer a trstate which is RO and activation with a subsystem
symlink. We can easily take care of re-activation in the transport.
