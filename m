From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 24 May 2019 01:03:07 -0700
Subject: [PATCH RFC] nvme: Common subsys and controller instances IDA
In-Reply-To: <20190521143540.GB1639@localhost.localdomain>
References: <20190515213351.22190-1-keith.busch@intel.com>
 <20190516064651.GA30234@lst.de>
 <1f0e7049-c926-98e0-3624-0d24eb45cd87@suse.de>
 <20190516144452.GB23372@localhost.localdomain> <yq17eaqbg4c.fsf@oracle.com>
 <040beeb5-d328-d5b0-f165-51bbd40f4c23@mellanox.com>
 <20190521143540.GB1639@localhost.localdomain>
Message-ID: <ccd37b33-6fa3-8435-9ac4-9c62f4525c1a@grimberg.me>


>> maybe we can improve it and print also the namespace during the "nvme
>> list-subsys" command.
>>
>> something like:
>>
>> [root at server50 ~]# nvme list-subsys
>> nvme-subsys0 - NQN=testsubsystem_0
>> \
>>   ?+- nvme0 rdma traddr=11.212.140.146 trsvcid=4420
>>   ?\
>>   ? +- nvme0n1 SN=cf8bbff661502c51 Model=Linux
>>   ? +- nvme0n2 SN=cf8bbff661502c51 Model=Linux
>>
>>
>> and we'll get subsys/ctrl/ns relations in 1 cmd.
>>
>> thoughts ?
> 
> Yes, this is very useful! I'd like to add this as soon as possible.
> Do you have a patch, or is this just an example?  The only change I'd
> recommend is remove SN and Model since those are controller properties
> rather than from the namespace.

This now gives some context to the series Max posted :)

I still don't understand how this is helping more than the existing
list-subsys for what you're trying to achieve keith.

Your use-case was "I want to understand what is my controller for 
/dev/nvme0n1". This information is already available in nvme list
subsys. Why do you need the mpath-slave devices listed as well?
