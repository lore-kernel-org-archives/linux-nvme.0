From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 24 Dec 2015 12:39:40 +0200
Subject: [PATCH 3/3] nvme: make SG_IO support optional
In-Reply-To: <1450952155-8693-4-git-send-email-hch@lst.de>
References: <1450952155-8693-1-git-send-email-hch@lst.de>
 <1450952155-8693-4-git-send-email-hch@lst.de>
Message-ID: <567BCB6C.6000502@dev.mellanox.co.il>


> Translation SCSI commands to NVMe commands is rather pointless in general
> as applications must not expext to be able to use SCSI commands on a
> generic block device.
>
> Make the huge translation layer optional and hope no one will ever enable
> it in the future.

Umm, this is needed to support multipathing (at least in the multipath
daemon current form). I'm not sure this is a good idea just yet...
