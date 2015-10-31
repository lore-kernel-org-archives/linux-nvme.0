From: vedant@lath.in (Vedant Lath)
Date: Sun, 1 Nov 2015 04:04:46 +0530
Subject: [PATCH] nvme: prepare support for Apple NVMe controller
In-Reply-To: <aa2cd8baee2f28f08559aef8be46bac0@localhost>
References: <bd1f730603ee00205657774a362aab10@localhost>
 <20151029151056.GA2580@localhost.localdomain>
 <CAKajsGOy_JjQFvDePw=A1xmP-o_JPoHxE48VvXW5Gsi18gC49A@mail.gmail.com>
 <aa2cd8baee2f28f08559aef8be46bac0@localhost>
Message-ID: <CAKajsGOVX2gBw-KhO2LAC7qao=-oU4bULvk9q9QJ1c3xSaSJSw@mail.gmail.com>

On Thu, Oct 29, 2015@11:29 PM, Stephan G?nther <guenther@tum.de> wrote:
>
> On 2015/October/29 10:06, Vedant Lath wrote:
> > Hi Stephan,
> >
> > Thank you! I am glad to see that Linux support for this SSD is workable.
> >
> > I have a MacBookAir7,1 (11" Macbook Air (Early 2015)) which uses the
> > same (or similar) SSD (PCI ID 106b:2001). I am extremely interested to
>
> You are right, the latest 11" MacBook Air presumably uses the same
> controller.

To be more precise, the 11" MacBook Air with the 256 GB SSD uses the
same controller. The 128 GB models use AHCI. The iFixit teardown is of
the 128 GB model which has a Marvell AHCI controller in its SSD.

> > test the patch on this laptop. Which kernel tree should I apply this
> > patch on? Can I apply it on stable (4.2.5)?
>
> I tested against 4.3-rc7. However, since the patch consits of 2 lines it
> is very likely that it it also applies to older kernels.

I have tested it against 4.3-rc7 and it works. Thank you. :)

Most nvme-cli commands also work fine on it. I have posted some output
at http://pastebin.ubuntu.com/13049434/ .

However, nvme-cli show-regs is also affected by the same quirk and
reports some incorrect values from BAR0:
$ sudo ./nvme show-regs /dev/nvme0
cap     : ffffffffffffffff
version : 10001
intms   : 0
intmc   : 0
cc      : 460001
csts    : 1
nssr    : 0
aqa     : ff00ff
asq     : ffffffffffffffff
acq     : ffffffffffffffff
cmbloc  : 0
cmbsz   : 0

> >
> > I had thought it might have been something related to initialising the
> > controller because lspci showed correctable errors (DevSta: CorrErr+)
> > on Linux but not on OS X. I also got discouraged because of the
> > vendor-specific PCI class (018002) instead of the nvme PCI class
> > (010802) which indicated a non-standard protocol. It's a nice feeling
> > to know it only requires a quirk to work.
>
> Do not forget to bind it manually. And there is still a long way, at
> least for the MacBook8,1 as there is still no clue why the internal
> keyboard is not working...
