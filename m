From: asb@cin.ufpe.br (Angelo Brito)
Date: Fri, 12 Sep 2014 11:19:21 -0300
Subject: Unable to find /dev/nvme0
In-Reply-To: <CACJqLyacaeC43adhNb1VLbEa+hrwZ=_q+VXER1DEpBNDwbyA0Q@mail.gmail.com>
References: <CACJqLyZp4J-yxc=KEnTJ=yg3hJZGRu2UQD2B39qzbnq3cdzMJw@mail.gmail.com>
 <CAMjVwgSAVVGnAJ2bigDawL+qGemh+xPZ8yozP_A_YDF+ByG8dg@mail.gmail.com>
 <CACJqLyYHLDgibE_Luh9uCBQB29=aALSm3Psx=Hze7kGjKVKaBA@mail.gmail.com>
 <CACJqLyacaeC43adhNb1VLbEa+hrwZ=_q+VXER1DEpBNDwbyA0Q@mail.gmail.com>
Message-ID: <CAMjVwgRwBXCkLgmO=jy-XiLXRQVKDfF66pf2UORjzHkN1Db00Q@mail.gmail.com>

Hi Wang,

I don't know any NVMe API. If there is an API for this driver the guys
from the nvme list can comment about it.
I have been working with NVMe driver, to do so I included the nvme.h
from kernel headers from usr/src/kernel/linux/include folders and
calling drivers functions directly.
Also, all UNIX programs like cp, mkfs, rm, mkdir, ls and all others,
are compatible with the driver.

Regards,
Angelo Silva Brito.
Graduate in Engenharia da Computa??o - UFPE
http://about.me/angelobrito
_________________________________________________


On Fri, Sep 12, 2014@4:39 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> Another question: where can I found the NVME API example program?
> nvme-user repo seemed too poor.
>
> On Fri, Sep 12, 2014@3:31 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> Thanks!
>>
>> I have found the reason because of broken pcie slot :-(;
>>
>> On Fri, Sep 12, 2014@3:12 PM, Angelo Brito <asb@cin.ufpe.br> wrote:
>>> Hi Wang,
>>>
>>> First things first. Have you tried a lspci commands and checked if
>>> your device was reconized?
>>> Also, you coould use dmesg to look for errors regarding the nvme
>>> module. Does anything showed up?
>>>
>>> Regards
>>> Angelo Silva Brito.
>>> Digital Systems Engineer - UFPE
>>> http://about.me/angelobrito
>>> _________________________________________________
>>>
>>>
>>> On Fri, Sep 12, 2014@1:23 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> I use a linux kernel version 3.12 based on CentOS 6.5:
>>>> # uname -a
>>>> Linux server-72 3.12.21-1.el6.x86_64 #1 SMP Thu Jun 5 22:15:05 EDT
>>>> 2014 x86_64 x86_64 x86_64 GNU/Linux
>>>>
>>>> I insert kernel module nvme:
>>>> # modprobe nvme
>>>> # lsmod | grep nvme
>>>> nvme                   54575  0
>>>> # modinfo nvme
>>>> filename:       /lib/modules/3.12.21-1.el6.x86_64/kernel/drivers/block/nvme.ko
>>>> version:        0.8
>>>> license:        GPL
>>>> author:         Matthew Wilcox <willy at linux.intel.com>
>>>> srcversion:     971AB1E47B949401886CC3F
>>>> alias:          pci:v*d*sv*sd*bc01sc08i02*
>>>> depends:
>>>> intree:         Y
>>>> vermagic:       3.12.21-1.el6.x86_64 SMP mod_unload modversions
>>>> parm:           nvme_major:int
>>>> parm:           use_threaded_interrupts:int
>>>>
>>>> I follow the instructment from
>>>> (file:///Users/wanghaomai/Downloads/SF13_SSDL001_100.pdf) and can't
>>>> fiind:
>>>> # ls /dev/nvme*
>>>> ls: cannot access /dev/nvme*: No such file or directory
>>>>
>>>> I used intel nvme p3500 for testing.
>>>>
>>>> I'm very appreciated if any feedback
>>>>
>>>> --
>>>> Best Regards,
>>>>
>>>> Wheat
>>>>
>>>> _______________________________________________
>>>> Linux-nvme mailing list
>>>> Linux-nvme at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>
>
>
> --
> Best Regards,
>
> Wheat
