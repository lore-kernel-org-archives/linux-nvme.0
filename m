From: mlin@kernel.org (Ming Lin)
Date: Mon, 1 Jun 2015 16:24:01 -0700
Subject: NVMe scalability issue
In-Reply-To: <alpine.LNX.2.00.1506012254500.15930@localhost.lm.intel.com>
References: <1433199171.7699.22.camel@ssi>
 <alpine.LNX.2.00.1506012254500.15930@localhost.lm.intel.com>
Message-ID: <CAF1ivSZCiWjrJQWckr2cTrfHEjS99ULz0HH94XP+wW3L3Jwttg@mail.gmail.com>

On Mon, Jun 1, 2015@4:02 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, 1 Jun 2015, Ming Lin wrote:
>>
>> Hi list,
>>
>> I'm playing with 8 high performance NVMe devices on a 4 sockets server.
>> Each device can get 730K 4k read IOPS.
>>
>> Kernel: 4.1-rc3
>> fio test shows it doesn't scale well with 4 or more devices.
>> I wonder any possible direction to improve it.
>
>
> There was a demo at SC'14 with a heck of a lot more NVMe drives than that,
> and performance scaled quite linearly. Are your devices sharing PCI-e lanes?

Is there a way to check it via, for example, /sys?

> You could try setting "cpus_allowed" on each job to the CPU's on the
> socket local to the nvme device. That should get a measurable improvement,
> and if your irq's are appropriately affinitized.

How to know which socket is local to which nvme device?

I did a quick test with:
node0: nvme0 and nvme1
node1: nvme2 and nvme3
node2: nvme4 and nvme5
node3: nvme6 and nvme7

[job0]
filename=/dev/nvme0n1
cpus_allowed=0,4,8,12,16,20,24,28,32,36,40,44

[job1]
filename=/dev/nvme1n1
cpus_allowed=0,4,8,12,16,20,24,28,32,36,40,44

[job2]
filename=/dev/nvme2n1
cpus_allowed=1,5,9,13,17,21,25,29,33,37,41,45

[job3]
filename=/dev/nvme3n1
cpus_allowed=1,5,9,13,17,21,25,29,33,37,41,45

[job4]
filename=/dev/nvme4n1
cpus_allowed=2,6,10,14,18,22,26,30,34,38,42,46

[job5]
filename=/dev/nvme5n1
cpus_allowed=2,6,10,14,18,22,26,30,34,38,42,46

[job6]
filename=/dev/nvme6n1
cpus_allowed=3,7,11,15,19,23,27,31,35,39,43,47

[job7]
filename=/dev/nvme7n1
cpus_allowed=3,7,11,15,19,23,27,31,35,39,43,47

But it doesn't make much difference.

devices         theory          actual          actual
                IOPS(K)         IOPS(K)         IOPS(K) "cpus_allowed"
-------         -------            -------
-------------------------------
1               733             733                   733
2               1466            1446.8             1467.7
3               2199            2174.5             2213.9
4               2932            2354.9             2354.8
5               3665            3024.5             3085.2
6               4398            3818.9             3822.6
7               5131            4526.3             4517.8
8               5864            4621.2             4722.4
