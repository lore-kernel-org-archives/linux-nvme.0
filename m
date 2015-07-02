From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 2 Jul 2015 20:42:17 +0800
Subject: Question about NVMe share I/O
In-Reply-To: <alpine.LNX.2.00.1507011612070.15930@localhost.lm.intel.com>
References: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
 <1433779695-15866-3-git-send-email-keith.busch@intel.com>
 <20150611104033.GA21107@infradead.org>
 <alpine.LNX.2.00.1506111410500.15930@localhost.lm.intel.com>
 <20150611152348.GB1292@infradead.org> <55935989.70809@huawei.com>
 <alpine.LNX.2.00.1507011612070.15930@localhost.lm.intel.com>
Message-ID: <559531A9.5040704@huawei.com>

On 2015/7/2 0:17, Keith Busch wrote:
> On Tue, 30 Jun 2015, dingxiang wrote:
>> Hi,All
>> We are now using NVMe to develop a share I/O model,the topology is
>>
>>   |------|        |------|
>>   |Host A|        |Host B|
>>   |______|        |______|
>>       \              /
>>        \            /
>>         \ |------| /
>>          \| nvme |/
>>           |______|
> 
> 
> I think I'm missing part of the picture here. Could you explain how
> you managed to get two hosts to talk to a single nvme controller. More
> specifically, how are they able to safely share the admin queue and the
> pci-e function's nvme registers?

Hi Keith, it's not a traditional topology, the physical NVMe device is located in
a manager OS which is independent of other hosts.  Every Host connects to manager OS
by some PCIe interconnect topology(something like NTB bridge). All hosts share the admin
queue which is created in manager OS, so if host want to deliver a admin command to nvme controller,
it would first send the admin command to the manager OS, then manger OS would post the admin command
to nvme controller instead.  Thanks to the PCIe interconnect fabric ,every Host could exclusively
occupy several NVMe IO queues which bypass the manager OS, the DMA packet could be routed to
correct Host by the PCIe interconnect fabric.

In our test case, we have two host A and B, and a manager OS, Manger OS occupy the admin queue and first IO
queue(id = 1), Host A occupy IO queue 2 and 3, Host B occupy IO queue 4 and 5. Every IO queue has its own
completion queue.

Most of the time, the Host and NVMe work fine, we could read/write the same nvme by different Host,
but if we do test which insmod and rmmod nvme driver(we reworked) in both hosts, a system crash would happen,
and the root cause is in Host B we receive a completion which does not belong to it, we found it belong to
Host A, because submit queue id in completion is 2. It's so strange, according to NVMe spec, I think
every IO queue should independent.

So is there some possibility a NVMe completion would deliver to another IO queue completion queue ?

Thanks!
Yijing.


> 
> 
>> We assign one queue for every host,
>> here are the details of host A and B:
>>
>> Host A:
>>  QID     :2
>>  MSIX irq:117
>>  cq prp1 :0x31253530000
>>  sq prp1 :0x3124af30000
>>
>> Host B:
>>  QID     :3
>>  MSIX irq:118
>>  cq prp1 :0x35252470000
>>  sq prp1 :0x3524d820000
>>
>> Then we run test script in both hosts,the script is :
>>  insmod nvme.ko
>>  sleep 2
>>  rmmod nvme
>>  sleep 2
>>
>> When the script runs after a period of time,Host B will crash in function "nvme_process_cq",
>> and Host A will print "I/O Buffer error" messages.
>> We found when host B crash,the QID Host B processed is QID 2,and the command_id
>> in struct "nvme_completion" is not the value allocate in Host B, but same as Host A ,
>> the MSIX and prp value of host B are not change.
>> My doubt is why Host B can receive Host A's nvmeq info? In my opinion,the queues of Host A and B
>> are independent, should not interfere with each other.
>> Thanks!
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
> 


-- 
Thanks!
Yijing
