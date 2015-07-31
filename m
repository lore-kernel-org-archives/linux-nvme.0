From: keith.busch@intel.com (Keith Busch)
Date: Fri, 31 Jul 2015 21:56:27 +0000 (UTC)
Subject: driver for apple storage controller 106b:2001
In-Reply-To: <CAL1_imkB-bz_wUELxMqEreJiyqE+y1_dPRMYyaxuJtko4+Q9Bg@mail.gmail.com>
References: <CAL1_imkB-bz_wUELxMqEreJiyqE+y1_dPRMYyaxuJtko4+Q9Bg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1507312144160.15930@localhost.lm.intel.com>

On Fri, 31 Jul 2015, David Craven wrote:
> I'm having trouble getting the ssd controller in the new apple macbook
> 2015 model to work.
>
> This is what I tried:
> insmod /usr/lib/modules/4.0.7-2-ARCH/kernel/drivers/block/nvme.ko.gz
> echo "106b 2001" > /sys/bus/pci/drivers/nvme/new_id
>
> And this is the error I got:
> - @archiso ..ules/4.0.7-2-ARCH/kernel/drivers/block # echo "106b 2001"
>> /sys/bus/pci/driuers/nume/new_id
>
> [318.531670] nvme 0000:03:00.0: Minimum device page size (134217728) too large for host (4096)
>
> [318.553789] BUG: unable to handle kernel NULL pointer dereference at  00000000000004ac

Hi,

This doesn't appear to be an NVMe device. Its "minimum page size"
supported is so absurd that I can't believe this is came from an NVMe
device register set.

If this were an NVMe device, you should not have needed to manually bind
the VID/DID to the nvme driver since it is a generic driver that binds
to all devices with an NVM-Express class code (10802h).

But since you've done this, you've discovered a bug that was present in
4.0, but fixed in 4.2. I should probably post these fixes to stable...

> Does this error message make sense to you guys? Is this the correct
> driver for the 106b:2001, or does that need a totally different
> driver? How can I go about deciphering this error? How do I find other
> people with the same issue / am I at the right place here?
> I'd really appreciate any pointers, help or suggestions you can give me.

I think this needs a different driver. If this really is an NVMe device,
then the h/w vendor either needs to adjust their implementation or supply
a quirk patch.
