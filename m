From: oza.oza@broadcom.com (Oza Oza)
Date: Mon, 15 May 2017 16:29:57 +0530
Subject: [RFC] NVMe Configuraiton using sysctl
In-Reply-To: <f4e5a2bd-9e41-8025-31a9-9bcadd2468c3@grimberg.me>
References: <CAMSpPPcxWYtZMbAc4TWam3iC1cLbxBPM=EhNPKA6qweiGnJvVg@mail.gmail.com>
 <CAMSpPPf640XfjW38=NXHmkDG0SeduavOEkKiEJuGmobq183jNg@mail.gmail.com>
 <f4e5a2bd-9e41-8025-31a9-9bcadd2468c3@grimberg.me>
Message-ID: <CAMSpPPfffe0Jx5e8J6rs_Lf0mZGborDfp1mgxczzHJ1sKSc4dw@mail.gmail.com>

On Mon, May 15, 2017@2:45 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>
>>> Hi,
>
>
> Hi Oza,
>
>>> we are configuring interrupt coalesce for NVMe, but right now, it uses
>>> module param.
>>> so the same interrupt coalesce settings get applied for all the NVMEs
>>> connected to different RCs.
>>>
>>> ideally it should be with sysctl.
>
>
> If at all, I would place this in nvme-cli (via ioctl) instead of
> sysctl.
>
>>> for e.g.
>>> sysctl should provide interface to change
>>> Per-CPU IO queue pairs, interrupt coalesce settings etc..
>
>
> My personal feeling is that percpu granularity is a lot to take in for
> the user, and also can yield some unexpected performance
> characteristics. But I might be wrong here..
>

I thought of nvme_ioctl, but was not sure whether sysctl or ioctl.
although we are interested only introducing interrupt coalesce,
because that brings improvements.

>>> please suggest if we could have/implement sysctl module for NVMe ?
>
>
> I have asked this before, but interrupt coalescing has very little
> merit without being able to be adaptive. net drivers maintain online
> stats and schedule interrupt coalescing modifications.
>
> Should work in theory, but having said that, interrupt coalescing as a
> whole is essentially unusable in nvme since the coalescing time limit
> is in units of 100us increments...

surprisingly, it brings 20% improvement in CPU utilization for us.
so it saves lot of our CPU cycles there freeing up to do something else.
the value has to be tuned but that's all there it is.
so we are keen on having this to tune in.

so your suggestion is to use IOCTL instead of sysctl right ?.
and as of now we are only interested in interrupt coalesce alone.

Regards,
Oza.
