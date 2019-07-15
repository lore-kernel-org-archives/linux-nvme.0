From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 15 Jul 2019 10:21:45 -0700
Subject: [PATCH rfc v2 10/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <e45db042-2cf0-2922-cceb-ff593711e42f@broadcom.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-11-jsmart2021@gmail.com>
 <9c08054d-751e-fdc0-4ea1-64cfa388e439@grimberg.me>
 <e45db042-2cf0-2922-cceb-ff593711e42f@broadcom.com>
Message-ID: <3999132d-498d-e2ef-f52d-a81fdb37f914@grimberg.me>


> On 7/12/2019 10:58 AM, Sagi Grimberg wrote:
>>
>>> diff --git a/Makefile b/Makefile
>>> index db594a3..4ea8b41 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -8,6 +8,10 @@ DESTDIR =
>>> ? PREFIX ?= /usr/local
>>> ? SYSCONFDIR = /etc
>>> ? SBINDIR = $(PREFIX)/sbin
>>> +LIBDIR ?= /usr/lib
>>> +SYSTEMDDIR ?= $(LIBDIR)/systemd
>>> +UDEVDIR ?= $(LIBDIR)/udev
>>
>> UDEVDIR needs to be built from $(SYSCONFDIR)/udev as LIBDIR might be
>> /usr/local/lib and udev doesn't look there.
> 
> I really would like to change prefix to /usr, so that it matches what is 
> in nvme.spec.in where the %install paragraph sets PREFIX to /usr.?? We 
> have two separate places setting a value and they are in conflict.
> 
> Based on the spec file setting - the only make targets that match PREFIX 
> outside of the install targets is the pkg target which is mainly man 
> files and a copy of nvme.? The man files perhaps would be under 
> /usr/local, but everything else we're talking about would be very odd 
> under /usr/local.?? Perhaps a better answer is PREFIX=/usr (which also 
> set SBINDIR for the nvme copy), LIBDIR=$(PREFIX)/lib, other variables 
> the same, and add a MANPREFIX=/usr/local for the man files.

Why not just place it in /etc? its equivalent and works regardless.
