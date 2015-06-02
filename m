From: axboe@fb.com (Jens Axboe)
Date: Tue, 2 Jun 2015 12:22:23 -0600
Subject: NVMe scalability issue
In-Reply-To: <CAF1ivSaoRY9G5J4Y-qzPx0NjVwsxE2mUsMHPEn6wk0c3-pbqUA@mail.gmail.com>
References: <1433199171.7699.22.camel@ssi>	<alpine.LNX.2.00.1506012254500.15930@localhost.lm.intel.com>	<CAF1ivSZCiWjrJQWckr2cTrfHEjS99ULz0HH94XP+wW3L3Jwttg@mail.gmail.com>	<alpine.LNX.2.00.1506020325260.15930@localhost.lm.intel.com>
 <CAF1ivSaoRY9G5J4Y-qzPx0NjVwsxE2mUsMHPEn6wk0c3-pbqUA@mail.gmail.com>
Message-ID: <556DF45F.2040904@fb.com>

On 06/02/2015 11:24 AM, Ming Lin wrote:
> On Mon, Jun 1, 2015@8:30 PM, Keith Busch <keith.busch@intel.com> wrote:
>> On Mon, 1 Jun 2015, Ming Lin wrote:
>>>
>>> On Mon, Jun 1, 2015@4:02 PM, Keith Busch <keith.busch@intel.com> wrote:
>>>>
>>>> There was a demo at SC'14 with a heck of a lot more NVMe drives than
>>>> that,
>>>> and performance scaled quite linearly. Are your devices sharing PCI-e
>>>> lanes?
>>>
>>>
>>> Is there a way to check it via, for example, /sys?
>>
>>
>>    # lspci -tv
>
> Each 4 drives share x16 lane.
>
>>
>>>> You could try setting "cpus_allowed" on each job to the CPU's on the
>>>> socket local to the nvme device. That should get a measurable
>>>> improvement,
>>>> and if your irq's are appropriately affinitized.
>>>
>>>
>>> How to know which socket is local to which nvme device?
>>
>>
>>    # cat /sys/class/nvme/nvme<#>/device/numa_node
>
> # grep . /sys/class/nvme/nvme*/device/numa_node
> /sys/class/nvme/nvme0/device/numa_node:1
> /sys/class/nvme/nvme1/device/numa_node:1
> /sys/class/nvme/nvme2/device/numa_node:1
> /sys/class/nvme/nvme3/device/numa_node:1
> /sys/class/nvme/nvme4/device/numa_node:2
> /sys/class/nvme/nvme5/device/numa_node:2
> /sys/class/nvme/nvme6/device/numa_node:2
> /sys/class/nvme/nvme7/device/numa_node:2
>
> With correct numa_node binding, now I can get 5010K IOPS with 8 drives.
> It's better now, but still not linear scaled to 5864K
>
> I'll check if irq's are appropriately affinitized.

Just a thought, but one thing that fio is pretty intensive on is time 
keeping. Depending on the platform, there's some shared state between 
the fio IO threads. Does the picture change if you add gtod_reduce=0?
In general, I'd also turn off strict random tracking. Either add 
'norandommap' as an option, or use random_generator=lfsr instead.

-- 
Jens Axboe
