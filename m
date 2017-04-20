From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 20 Apr 2017 09:24:43 -0700
Subject: kmemleak complaints in nvme PM
In-Reply-To: <d18ef22d-7e83-c287-6d86-7d0ebd5442ef@grimberg.me>
References: <006f3319-0cd8-9d47-95cd-454b775a9b04@grimberg.me>
 <20170412172939.GE8639@lst.de>
 <CALCETrURYPsHZOfpey33vm-9HHLTBQqjti8YCXLkJJHs5nXByQ@mail.gmail.com>
 <3179162.n86QkeM4IM@aspire.rjw.lan>
 <CALCETrX2yD+D=qkOFajStC=9PaAxpkvhD2OWpO_bAhX5s+_LTA@mail.gmail.com>
 <d18ef22d-7e83-c287-6d86-7d0ebd5442ef@grimberg.me>
Message-ID: <CALCETrWsU4FMmnv3Wcp6-qc2a6hYCJ0mteUQX0hK+F=KQe7Lvw@mail.gmail.com>

On Thu, Apr 20, 2017@4:34 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
>
>>>> Greg and/or Rafael, what's the right way to fix this?  I would imagine
>>>> that the driver core should free pm_qos requests when the device goes
>>>> away, no?
>>>
>>>
>>> Yes, it should.
>>>
>>
>> I don't see the bug.  dev_pm_qos_constraints_destroy() should take care of
>> it.
>
>
> I see it all the time, where is dev_pm_qos_constraints_destroy() called?
>
> Not in nvme.

What I meant was: I don't see the bug in the code.

dev_pm_qos_constraints_destroy() is called from dpm_sysfs_remove(),
which is called from device_del().

Anyway, I tried to reproduce it and I failed:

# nvmetcli
/> cd /ports/
/ports> create 1
module 'nvmet' has no attribute 'Port'

I can manually mkdir '1' in /sys/kernel/config/nvmet/ports, but I have
no idea what I'm supposed to do from there.

Help?  Is there some trivial script I can run to reproduce the problem?
