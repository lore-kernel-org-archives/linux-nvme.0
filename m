From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 23 May 2019 11:01:54 +0300
Subject: [PATCH 9/9] nvme: Retrieve namespaces during list-subsys cmd
In-Reply-To: <20190522224955.GC5857@localhost.localdomain>
References: <1558543193-24752-1-git-send-email-maxg@mellanox.com>
 <1558543193-24752-10-git-send-email-maxg@mellanox.com>
 <20190522224955.GC5857@localhost.localdomain>
Message-ID: <0c677aa1-aa60-dddd-4a3f-a339545fee63@mellanox.com>


On 5/23/2019 1:49 AM, Keith Busch wrote:
> On Wed, May 22, 2019@07:39:53PM +0300, Max Gurtovoy wrote:
>> Add an association between subsystems/ctrls/namespaces using
>> "nvme list-subsys" command. Now this command will show the following:
>>
>> nvme-subsys4 - NQN=testsubsystem_0
>> \
>>   +- nvme4 rdma traddr=12.212.99.85 trsvcid=4420 live
>>   \
>>    +- nvme4n1
>>    +- nvme4n2
>>    +- nvme4n3
>>   +- nvme5 rdma traddr=12.212.99.85 trsvcid=4420 live
>>   \
>>    +- nvme5n1
>>    +- nvme5n2
>>    +- nvme5n3
>>
>> Instead of:
>> ----------------
>> nvme-subsys4 - NQN=testsubsystem_0
>> \
>>   +- nvme4 rdma traddr=12.212.99.85 trsvcid=4420
>>   +- nvme5 rdma traddr=12.212.99.85 trsvcid=4420
> This is a terrific start. Your output indicates you are not using
> nvme native multipathing, though. Could you retry this command with
> that enabled (I'll try it tomorrow as well)?

Yup I'll configure the native multipath. But what is expected ?

should we print nvme4c1n1/nvme4c1n2/nvme4c1n3 for nvme4

and nvme4c2n1/nvme4c2n2/nvme4c2n3 for nvme5 ?

if so, I guess the information on the "IO-ble" devices 
nvme4n1/nvme4n2/nvme4n3 will not be printed.

something like:

nvme-subsys4 - NQN=testsubsystem_0
\
 ?+- nvme4 rdma traddr=12.212.99.85 trsvcid=4420 live
 ?\
 ? +- nvme4c1n1
 ? +- nvme4c1n2
 ? +- nvme4c1n3
 ?+- nvme5 rdma traddr=12.212.99.85 trsvcid=4420 live
 ?\
 ? +- nvme4c2n1
 ? +- nvme4c2n2
 ? +- nvme4c2n3


if this if fine I'll send a V2 with a small fix.

-Max.
