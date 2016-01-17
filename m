From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 17 Jan 2016 10:54:35 +0200
Subject: [PATCH RFC] nvme-core: Log the ctrl device instance name
In-Reply-To: <20160115164031.GA11165@localhost.localdomain>
References: <1452416444-22714-1-git-send-email-sagig@mellanox.com>
 <20160115164031.GA11165@localhost.localdomain>
Message-ID: <569B56CB.5090107@dev.mellanox.co.il>


>> Having the ctrl instance name "nvmeX" seems much more friendly than
>> the underlying device name. Also, with other nvme transports
>> such as the soon to come nvme-loop we don't have an underlying
>> device and it doesn't makes sense to make up one.
>
> For PCI, I think this is okay if you add a message each time a device gets
> an instance that ties it back to PCI device's name. Without something
> like that, it doesn't look straight forward to match the NVMe device
> name to it's PCI function just from the logs.

That sounds ok to me too.

So I'll convert the pci.c logging as well and add a log message that
ties an instance to a pci function.

Thanks Keith!
