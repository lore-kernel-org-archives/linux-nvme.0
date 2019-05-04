From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sat, 4 May 2019 23:26:55 +0900
Subject: [PATCH 3/4] nvme-pci: add device coredump support
In-Reply-To: <66a5d068-47b1-341f-988f-c890d7f01720@gmail.com>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <1556787561-5113-4-git-send-email-akinobu.mita@gmail.com>
 <66a5d068-47b1-341f-988f-c890d7f01720@gmail.com>
Message-ID: <CAC5umyjsAh7aZ8JEh8=QMXpNwRdnxxfdPBDwmuVKfafG+rT-PA@mail.gmail.com>

2019?5?4?(?) 19:04 Minwoo Im <minwoo.im.dev at gmail.com>:
>
> Hi, Akinobu,
>
> Regardless to reply of the cover, few nits here.
>
> On 5/2/19 5:59 PM, Akinobu Mita wrote:
> > +
> > +static const struct nvme_reg nvme_regs[] = {
> > +     { NVME_REG_CAP,         "cap",          64 },
> > +     { NVME_REG_VS,          "version",      32 },
>
> Why don't we just go with "vs" instead of full name of it just like
> the others.

I tried to imitate the output of 'nvme show-regs'.

> > +     { NVME_REG_INTMS,       "intms",        32 },
> > +     { NVME_REG_INTMC,       "intmc",        32 },
> > +     { NVME_REG_CC,          "cc",           32 },
> > +     { NVME_REG_CSTS,        "csts",         32 },
> > +     { NVME_REG_NSSR,        "nssr",         32 },
> > +     { NVME_REG_AQA,         "aqa",          32 },
> > +     { NVME_REG_ASQ,         "asq",          64 },
> > +     { NVME_REG_ACQ,         "acq",          64 },
> > +     { NVME_REG_CMBLOC,      "cmbloc",       32 },
> > +     { NVME_REG_CMBSZ,       "cmbsz",        32 },
>
> If it's going to support optional registers also, then we can have
> BP-related things (BPINFO, BPRSEL, BPMBL) here also.

I'm going to change the register dump in binary format just like
'nvme show-regs -o binary' does.  So we'll have registers from 00h to 4Fh.
