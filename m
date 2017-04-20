From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 14:34:49 +0300
Subject: kmemleak complaints in nvme PM
In-Reply-To: <CALCETrX2yD+D=qkOFajStC=9PaAxpkvhD2OWpO_bAhX5s+_LTA@mail.gmail.com>
References: <006f3319-0cd8-9d47-95cd-454b775a9b04@grimberg.me>
 <20170412172939.GE8639@lst.de>
 <CALCETrURYPsHZOfpey33vm-9HHLTBQqjti8YCXLkJJHs5nXByQ@mail.gmail.com>
 <3179162.n86QkeM4IM@aspire.rjw.lan>
 <CALCETrX2yD+D=qkOFajStC=9PaAxpkvhD2OWpO_bAhX5s+_LTA@mail.gmail.com>
Message-ID: <d18ef22d-7e83-c287-6d86-7d0ebd5442ef@grimberg.me>


>>> Greg and/or Rafael, what's the right way to fix this?  I would imagine
>>> that the driver core should free pm_qos requests when the device goes
>>> away, no?
>>
>> Yes, it should.
>>
>
> I don't see the bug.  dev_pm_qos_constraints_destroy() should take care of it.

I see it all the time, where is dev_pm_qos_constraints_destroy() called?

Not in nvme.
