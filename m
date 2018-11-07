From: ilya@yadro.com (=?utf-8?B?0JjQu9GM0Y8g0JrRg9C30L3QtdGG0L7Qsg==?=)
Date: Wed, 7 Nov 2018 20:32:23 +0300
Subject: Question regarding dual-port NVMe drives naming.
In-Reply-To: <20181107162457.GA15835@localhost.localdomain>
References: <20181107155241.ynvixi56i44zeakz@yadro.com>
 <20181107162457.GA15835@localhost.localdomain>
Message-ID: <20181107173223.dl5fludr3yidnyqi@yadro.com>

Keith,
thank you for quick response. Am I correct that to disable it I have to 
recompile kernel with CONFIG_NVME_MULTIPATH=n? No other options to disable it 
quickly exists?

Keith Busch <keith.busch at intel.com> wrote on ?? [2018-???-07 09:24:58 -0700]:
>On Wed, Nov 07, 2018@06:52:41PM +0300, ???? ???????? wrote:
>> Hello,
>> recently I started to use dual-port NVMe drives and faced with behaviour different to single-port drives.
>>
>> Dual-port drives have [virtual] Expansion ROM at 3ff083000000 [disabled] [size=128K] while single-port drives does not have expansion ROMs.
>> In naming of dual-port drives there are new names in sysfs like nvme1c1n1.
>> Also all dual-port drives in sysfs are located in virtual directory like they don't have any parent bus.
>>
>> Could somebody explain this difference or give the direction where to dig?
>
>You are using a relatively recent kernel with CONFIG_NVME_MULTIPATH set.
>This option exposes nvme block devices under their nvme subsystem
>abstraction rather than under the controller so you see only one block
>handle per-namespace. The subsystem is presented as a virtual device.
>
>The individual block paths are hidden from the user, but the topology
>is visible in sysfs, like the nvme1c1n1 in your example.
