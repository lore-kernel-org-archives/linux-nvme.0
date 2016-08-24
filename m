From: nisha.miller420@gmail.com (Nisha Miller)
Date: Wed, 24 Aug 2016 10:13:43 -0700
Subject: Linux AER reporting
In-Reply-To: <20160824144029.GA13258@localhost.localdomain>
References: <CAG3=cOncMTcyALa=-i1jeA-z4pe22D9CrJ=Rxr2E8HWBsEMOPg@mail.gmail.com>
 <57BB4019.7050008@linux.vnet.ibm.com>
 <CAG3=cOn_pMZ5DMtB3K2tDGUL1x3vkn=Vjw9c8X8+ONh8xef+mw@mail.gmail.com>
 <57BDA906.4050207@linux.vnet.ibm.com>
 <20160824144029.GA13258@localhost.localdomain>
Message-ID: <CAG3=cO=ux5+EeDSCxDiEtSscH0UJ=+pJr4Exunvw=rfGai-zNA@mail.gmail.com>

Hi Keith,

I'm not injecting any errors. I'm trying to see if AER reporting can
help me diagnose the problem. Is this something AER can help me do or
am I on the wrong track here?

thanks
Nisha Miller

On Wed, Aug 24, 2016@7:40 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, Aug 24, 2016@11:02:46AM -0300, Guilherme G. Piccoli wrote:
>> On 08/23/2016 08:56 PM, Nisha Miller wrote:
>> >Hi Keith and Guilherme,
>> >
>> >thank you for your replies.
>> >
>> >Kernel 4.4.19 does not seem to have nvme driver with support for AER.
>> >It is present in Kernel 4.7 but getting it to work on Centos 7.2 is
>> >turning out to be quite a task. Arch Linux has kernel 4.7 so I will
>> >give that a shot.
>> >
>> >I should have mentioned that we get the CSTS = 0xFFFFFFFF only after
>> >millions of writes. When using fio, it runs for over 30 minutes before
>> >the problem crops up.
>>
>> Hi Nisha, unfortunately the idea of the quirk I mentioned seems useless
>> here, since you're getting the error after multiple writes. Hope Keith can
>> provide more ideas for you!
>
> An all 1's completion indicates the link is down. There should never be
> a case where a functioning drive actually returns that from a read to
> the CSTS register.
>
> I'm not sure if PCIe AER has anything do with this, though. Are you
> injecting these sorts of errors? If you're just doing normal IO testing,
> AER may not apply here.
