From: young.yu@northwestern.edu (Young Yu)
Date: Thu, 5 Apr 2018 02:31:21 +0000
Subject: NVMe and IRQ Affinity, another problem
In-Reply-To: <20180405010037.GA10098@localhost.localdomain>
References: <388F2D0B-537F-4884-91F0-CD562F33C639@northwestern.edu>
 <20180405010037.GA10098@localhost.localdomain>
Message-ID: <18F290A8-40B0-4680-985D-5005D0892192@northwestern.edu>

Thank you for the quick reply Keith,

nr_cpus=24 kernel parameter definitely has limited the present CPU and
helped spread the queues to the interrupt.

If you could forgive me asking another question, the admin queue, and 
half of the I/O queues of all NVMe devices are allocated to cores in a 
NUMA nodes ( in my case it is NUMA 0 as admin queue wants to stay
in the CPU0), and the other half of the I/O queues are allocated with 
the other, even if they are attached to either one of them. This is 
regardless of whether they are attached to NUMA 0 or 1.

I?m trying to read from the NVMe devices and send them to the NIC, 
and they both are attached to the same NUMA node (1). Is it possible 
to manually bind the first half of nvme8 so they all belongs to the cores 
in the same NUMA node so I can avoid accessing them using slow QPI 
between NUMA nodes? (or maybe exclude ones with admin queue 
because there will be a patch to separate the admin queue and the I/O 
queue soon) 


> On Apr 4, 2018,@8:00 PM, Keith Busch <keith.busch@intel.com> wrote:
> 
> On Thu, Apr 05, 2018@12:28:05AM +0000, Young Yu wrote:
>> Hello,
>> 
>> I know that this is another run on the old topic, but I'm still
>> wondering what is the right way to bind irq of NVMe-pci devices to the
>> cores in local NUMA node.  I'm using kernel 4.16.0-1.el7 on CentOS 7.4
>> and the machine have 2 numa nodes as in
>> 
>> $ lscpu|grep NUMA
>> NUMA node(s):          2
>> NUMA node0 CPU(s):     0,2,4,6,8,10,12,14,16,18,20,22
>> NUMA node1 CPU(s):     1,3,5,7,9,11,13,15,17,19,21,23
>> 
>> I have 16 NVMe devices, 8 per NUMA node, nvme0 to 7 to the NUMA 0 and
>> 8 to 15 to NUMA 1. irqbalance was on by default.  The irq of these
>> devices are all bound to the core 0 and 1 regardless of where they are
>> physically attached. affinity_hint looks still invalid, however there
>> is an effective_affinity that matches with some interrupt
>> bounded. cpu_list on mq was pointed to the wrong cores on the NVMe
>> devices on NUMA 1. I read it was fixed in kernel 4.3 so not sure
>> whether I?m looking at it in a right way.
>> 
>> Eventually I?d like to know if there is a way to distribute irq of
>> each nvme devices to different local cores in NUMA they are attached
>> to.
> 
> Bad things happened for a lot of servers when the irq spread used
> "present" rather than the "online" CPUs, with the "present" CPUs being
> oh-so-much larger than what is actually possible.
> 
> I'm guessing there's no chance more than 24 CPUs will actually ever
> come online in this system, but your platform says 248 may come online,
> so we're getting a poor spread for what is actually there.
> 
> I believe Ming Lei has an IRQ affinity patch set that may be going in
> 4.17 that fixes that.
> 
> In the meantime, I think if you add kernel paramter "nr_cpus=24",
> that should get you a much much better affinity for submission and
> completion sides.
