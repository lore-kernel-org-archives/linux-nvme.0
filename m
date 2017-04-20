From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 20:03:48 +0300
Subject: kmemleak complaints in nvme PM
In-Reply-To: <CALCETrWsU4FMmnv3Wcp6-qc2a6hYCJ0mteUQX0hK+F=KQe7Lvw@mail.gmail.com>
References: <006f3319-0cd8-9d47-95cd-454b775a9b04@grimberg.me>
 <20170412172939.GE8639@lst.de>
 <CALCETrURYPsHZOfpey33vm-9HHLTBQqjti8YCXLkJJHs5nXByQ@mail.gmail.com>
 <3179162.n86QkeM4IM@aspire.rjw.lan>
 <CALCETrX2yD+D=qkOFajStC=9PaAxpkvhD2OWpO_bAhX5s+_LTA@mail.gmail.com>
 <d18ef22d-7e83-c287-6d86-7d0ebd5442ef@grimberg.me>
 <CALCETrWsU4FMmnv3Wcp6-qc2a6hYCJ0mteUQX0hK+F=KQe7Lvw@mail.gmail.com>
Message-ID: <cfa923cb-e6b5-eb3a-f6ad-636135d05b3c@grimberg.me>


> Anyway, I tried to reproduce it and I failed:
>
> # nvmetcli
> /> cd /ports/
> /ports> create 1
> module 'nvmet' has no attribute 'Port'
>
> I can manually mkdir '1' in /sys/kernel/config/nvmet/ports, but I have
> no idea what I'm supposed to do from there.
>
> Help?  Is there some trivial script I can run to reproduce the problem?

I think you need to pull from Christoph's nvmetcli repo to resolve this.
