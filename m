From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 24 Dec 2015 13:31:32 +0200
Subject: [PATCH 3/3] nvme: make SG_IO support optional
In-Reply-To: <20151224111248.GB15268@lst.de>
References: <1450952155-8693-1-git-send-email-hch@lst.de>
 <1450952155-8693-4-git-send-email-hch@lst.de>
 <567BCB6C.6000502@dev.mellanox.co.il> <20151224111248.GB15268@lst.de>
Message-ID: <567BD794.2020607@dev.mellanox.co.il>


>>> Translation SCSI commands to NVMe commands is rather pointless in general
>>> as applications must not expext to be able to use SCSI commands on a
>>> generic block device.
>>>
>>> Make the huge translation layer optional and hope no one will ever enable
>>> it in the future.
>>
>> Umm, this is needed to support multipathing (at least in the multipath
>> daemon current form). I'm not sure this is a good idea just yet...
>
> It's not required, it's just you being lazy.

I didn't say it's required, I said it's needed for the current
multipathd implementation... and yes, I am lazy, multipathd is
not the most friendly code...

> I defintivively want
> to avoid people relying on this before actual multi path hardware
> ships.  So feel free to enable it while you're lazy for now, but
> I want people to disable it normally.

OK, I see what you mean. We can look at having multipathd ioctl'ing
identify_ns at some point...
