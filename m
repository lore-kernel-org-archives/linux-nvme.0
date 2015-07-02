From: dingxiang@huawei.com (dingxiang)
Date: Thu, 2 Jul 2015 15:11:49 +0800
Subject: Question about NVMe share I/O
In-Reply-To: <alpine.LNX.2.00.1507011612070.15930@localhost.lm.intel.com>
References: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
 <1433779695-15866-3-git-send-email-keith.busch@intel.com>
 <20150611104033.GA21107@infradead.org>
 <alpine.LNX.2.00.1506111410500.15930@localhost.lm.intel.com>
 <20150611152348.GB1292@infradead.org> <55935989.70809@huawei.com>
 <alpine.LNX.2.00.1507011612070.15930@localhost.lm.intel.com>
Message-ID: <5594E435.8060306@huawei.com>



? 2015/7/2 0:17, Keith Busch wrote:
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
> 
> 
We create admin queue and an I/O queue(QID:1) in nvme server before Host A&B start,
host A&B send amdin commands to nvme controller through a PLX chip,then nvme controller
can handle admin commands that from host A&B,and there is no error in admin commands pci-e
messages, host A&B can create I/O queue and perform other amdin commands normally .
So Host A&B can share the admin queue and the pci-e function's nvme registers safely.

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
> .
> 
