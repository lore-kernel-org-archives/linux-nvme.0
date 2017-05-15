From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 15 May 2017 12:15:28 +0300
Subject: [RFC] NVMe Configuraiton using sysctl
In-Reply-To: <CAMSpPPf640XfjW38=NXHmkDG0SeduavOEkKiEJuGmobq183jNg@mail.gmail.com>
References: <CAMSpPPcxWYtZMbAc4TWam3iC1cLbxBPM=EhNPKA6qweiGnJvVg@mail.gmail.com>
 <CAMSpPPf640XfjW38=NXHmkDG0SeduavOEkKiEJuGmobq183jNg@mail.gmail.com>
Message-ID: <f4e5a2bd-9e41-8025-31a9-9bcadd2468c3@grimberg.me>


>> Hi,

Hi Oza,

>> we are configuring interrupt coalesce for NVMe, but right now, it uses
>> module param.
>> so the same interrupt coalesce settings get applied for all the NVMEs
>> connected to different RCs.
>>
>> ideally it should be with sysctl.

If at all, I would place this in nvme-cli (via ioctl) instead of
sysctl.

>> for e.g.
>> sysctl should provide interface to change
>> Per-CPU IO queue pairs, interrupt coalesce settings etc..

My personal feeling is that percpu granularity is a lot to take in for
the user, and also can yield some unexpected performance
characteristics. But I might be wrong here..

>> please suggest if we could have/implement sysctl module for NVMe ?

I have asked this before, but interrupt coalescing has very little
merit without being able to be adaptive. net drivers maintain online
stats and schedule interrupt coalescing modifications.

Should work in theory, but having said that, interrupt coalescing as a
whole is essentially unusable in nvme since the coalescing time limit
is in units of 100us increments...
