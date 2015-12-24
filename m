From: hch@lst.de (Christoph Hellwig)
Date: Thu, 24 Dec 2015 12:12:48 +0100
Subject: [PATCH 3/3] nvme: make SG_IO support optional
In-Reply-To: <567BCB6C.6000502@dev.mellanox.co.il>
References: <1450952155-8693-1-git-send-email-hch@lst.de>
 <1450952155-8693-4-git-send-email-hch@lst.de>
 <567BCB6C.6000502@dev.mellanox.co.il>
Message-ID: <20151224111248.GB15268@lst.de>

On Thu, Dec 24, 2015@12:39:40PM +0200, Sagi Grimberg wrote:
>
>> Translation SCSI commands to NVMe commands is rather pointless in general
>> as applications must not expext to be able to use SCSI commands on a
>> generic block device.
>>
>> Make the huge translation layer optional and hope no one will ever enable
>> it in the future.
>
> Umm, this is needed to support multipathing (at least in the multipath
> daemon current form). I'm not sure this is a good idea just yet...

It's not required, it's just you being lazy.  I defintivively want
to avoid people relying on this before actual multi path hardware
ships.  So feel free to enable it while you're lazy for now, but
I want people to disable it normally.
