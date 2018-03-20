From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 20 Mar 2018 12:53:38 +0200
Subject: [PATCH 2/2] nvmet: Add port transport active flag
In-Reply-To: <e95daee3-691e-0d3f-b5da-2fca15c4d22a@grimberg.me>
References: <1521452867-13619-1-git-send-email-israelr@mellanox.com>
 <1521452867-13619-2-git-send-email-israelr@mellanox.com>
 <e95daee3-691e-0d3f-b5da-2fca15c4d22a@grimberg.me>
Message-ID: <817c9817-80eb-35a5-0aa9-a28594a031d9@mellanox.com>



On 3/20/2018 12:45 PM, Sagi Grimberg wrote:
> 
>> tractive port flag means that nvmet transport is active and ready for
>> receiving requests from host.
>> It differ from enabled port state (port with subsystem symbolic link)
>> which doesn't guarantee this.
>> The tractive flag is necessary in case the physical ports become down
>> while nvmet ports are enabled.
>> In this case the port state remains enabled but tractive flag becomes 
>> false.
>>
>> The tractive flag will help the administrator to monitor the port state
>> from transport point of view.
>> The commit also add the ability to activate the port by simply writing
>> to tractive at the configfs.
>> e.g.: echo 1 > config/nvmet/ports/1/tractive
> 
> Why this is a write-able variable? this is a state. I would rename it
> to be trstate.

We need a write-able entry to bring-up a listener in case the port/link 
went down.
Would you prefer 2 new configfs entries ? trstate (RO) and tractivate (WO) ?
