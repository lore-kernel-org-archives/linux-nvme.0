From: keith.busch@intel.com (Keith Busch)
Date: Fri, 12 Sep 2014 08:56:21 -0600 (MDT)
Subject: Unable to find /dev/nvme0
In-Reply-To: <CAMjVwgRwBXCkLgmO=jy-XiLXRQVKDfF66pf2UORjzHkN1Db00Q@mail.gmail.com>
References: <CACJqLyZp4J-yxc=KEnTJ=yg3hJZGRu2UQD2B39qzbnq3cdzMJw@mail.gmail.com>
 <CAMjVwgSAVVGnAJ2bigDawL+qGemh+xPZ8yozP_A_YDF+ByG8dg@mail.gmail.com>
 <CACJqLyYHLDgibE_Luh9uCBQB29=aALSm3Psx=Hze7kGjKVKaBA@mail.gmail.com>
 <CACJqLyacaeC43adhNb1VLbEa+hrwZ=_q+VXER1DEpBNDwbyA0Q@mail.gmail.com>
 <CAMjVwgRwBXCkLgmO=jy-XiLXRQVKDfF66pf2UORjzHkN1Db00Q@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1409120835210.4696@AMR>


On Fri, 12 Sep 2014, Angelo Brito wrote:
> I don't know any NVMe API. If there is an API for this driver the guys
> from the nvme list can comment about it.
> I have been working with NVMe driver, to do so I included the nvme.h
> from kernel headers from usr/src/kernel/linux/include folders and
> calling drivers functions directly.
>
> On Fri, Sep 12, 2014@4:39 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> Another question: where can I found the NVME API example program?
>> nvme-user repo seemed too poor.

I'm having a hard time parsing this conversation into something that
makes sense. Are you asking for an example user space program that makes
use of the linux nvme driver's uapi? I don't think you'll find a simpler
example than those in the nvme user repo. Or perhaps you can suggest
what you think it's lacking?
