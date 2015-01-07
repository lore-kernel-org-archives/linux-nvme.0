From: mlin@minggr.net (Ming Lin)
Date: Wed, 7 Jan 2015 11:36:15 -0800
Subject: [PATCHv2 00/10] Second attempt at blk-mq + nvme hotplug fixes
In-Reply-To: <alpine.LNX.2.00.1501071546590.4026@localhost.lm.intel.com>
References: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
 <CAF1ivSbxXH0CU+PtvhxdOb-WjGreMoJ-nQYr89xn7ZhhtAQKcw@mail.gmail.com>
 <alpine.LNX.2.00.1501071546590.4026@localhost.lm.intel.com>
Message-ID: <CAF1ivSb3fOtofZfeepbZNvwKbD83PkrdQ0C-qiRXFHyfUZ4KXg@mail.gmail.com>

On Wed, Jan 7, 2015@8:20 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Tue, 6 Jan 2015, Ming Lin wrote:
>>
>> Hi Keith,
>>
>> Tested with qemu-nvme. Hotplug seems work., but has some issues.
>>
>> On guest: run fio for a while
>> root at block:~# fio --name=global --filename=/dev/nvme0n1 --direct=1 --bs=4k
>> \
>>     --rw=randrw --ioengine=libaio --iodepth=128 --name=foobar
>> foobar: (g=0): rw=randrw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> 2.0.8
>> Starting 1 process
>> Jobs: 1 (f=1): [m] [10.3% done] [3746K/3980K /s] [936 /995  iops] [eta
>> 08m:52s]s]
>>
>> On guest: then remove nvme device
>> root at block:~# time echo 1 > /sys/devices/pci0000:00/0000:00:04.0/remove
>> real 1m0.040s
>> user 0m0.000s
>> sys 0m0.012
>>
>> It works, but took long time(1 minutes) to return.
>> And during this time frame, the whole qemu system was not responsible.
>> Ping from host to guest also failed.
>
>
> Thanks for the feedback. Is there anything special about your emulated
> device? I haven't been able to duplicate these results. When running
> the same fio job, I get ~0.4s on qemu, and ~2.2s on real h/w.
>
> A 1 mintute removal sounds like you're hitting the admin timeout on
> queue deletion.
>
> On the other hand, your namespace backing storage appears to be really
> slow, so maybe it's stuck in blk_flush on shutdown. You say the guest
> was unresponsive during removal, so that sounds plausible since qemu's
> nvme shutdown is down synchronously with the CC register MMIO write.
>
> What if you try this using a ramdisk or tmpfs file for the namespace
> storage instead of what you're currently using?

It's good with tmpfs file.

root at block:~# time echo 1 > /sys/devices/pci0000:00/0000:00:04.0/remove
real 0m0.403s
user 0m0.000s
sys 0m0.008s

Thanks.

>
> Or add some prints in both the driver's and emualted target's shutdown
> path and see where you're getting stuck?
