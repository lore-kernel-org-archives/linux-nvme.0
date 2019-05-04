From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 4 May 2019 23:46:12 +0900
Subject: [PATCH 3/4] nvme-pci: add device coredump support
In-Reply-To: <d0de1c5d-1168-086c-cc16-7d33fd307cd3@gmail.com>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <1556787561-5113-4-git-send-email-akinobu.mita@gmail.com>
 <66a5d068-47b1-341f-988f-c890d7f01720@gmail.com>
 <CAC5umyjsAh7aZ8JEh8=QMXpNwRdnxxfdPBDwmuVKfafG+rT-PA@mail.gmail.com>
 <d0de1c5d-1168-086c-cc16-7d33fd307cd3@gmail.com>
Message-ID: <13a4ec6d-e586-3879-d883-33bdbf90f294@gmail.com>

On 5/4/19 11:38 PM, Minwoo Im wrote:
> On 5/4/19 11:26 PM, Akinobu Mita wrote:
>> 2019?5?4?(?) 19:04 Minwoo Im <minwoo.im.dev at gmail.com>:

>>>> +???? { NVME_REG_INTMS,?????? "intms",??????? 32 },
>>>> +???? { NVME_REG_INTMC,?????? "intmc",??????? 32 },
>>>> +???? { NVME_REG_CC,????????? "cc",?????????? 32 },
>>>> +???? { NVME_REG_CSTS,??????? "csts",???????? 32 },
>>>> +???? { NVME_REG_NSSR,??????? "nssr",???????? 32 },
>>>> +???? { NVME_REG_AQA,???????? "aqa",????????? 32 },
>>>> +???? { NVME_REG_ASQ,???????? "asq",????????? 64 },
>>>> +???? { NVME_REG_ACQ,???????? "acq",????????? 64 },
>>>> +???? { NVME_REG_CMBLOC,????? "cmbloc",?????? 32 },
>>>> +???? { NVME_REG_CMBSZ,?????? "cmbsz",??????? 32 },
>>>
>>> If it's going to support optional registers also, then we can have
>>> BP-related things (BPINFO, BPRSEL, BPMBL) here also.
>>
>> I'm going to change the register dump in binary format just like
>> 'nvme show-regs -o binary' does.? So we'll have registers from 00h to 
>> 4Fh.
>>
> 
> Got it.
> 
> And now I can see those two commands `nvme show-regs` and
> `nvme show-regs -o binary` have different results for the register
> range.? The binary output covers just 0x50 size, but it shows all the
> registers including BP-related things in normal && json format.
> 
> Anyway, I'll prepare a patch for nvme-cli to support binary output
> format to cover BP things also.
> 
> Thanks, for your reply.

My bad, I misunderstood what you have said above.  Please ignore
what I mentioned. BP things are located from 40h. to 4Fh.

Sorry for making noises here. ;)
