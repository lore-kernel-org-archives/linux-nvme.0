From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 28 Aug 2017 10:41:47 +0300
Subject: [PATCH] nvme: fix uninitialized prp2 value on small transfers
In-Reply-To: <CADL4p-oxDfu0srX90+u9d0HfXLCNpFk2NdcoeaWEmMjRnwHX2w@mail.gmail.com>
References: <1503842197-29978-1-git-send-email-jschoenh@amazon.de>
 <CADL4p-oxDfu0srX90+u9d0HfXLCNpFk2NdcoeaWEmMjRnwHX2w@mail.gmail.com>
Message-ID: <b0e9b388-6997-ae76-eeab-962dfb2e5d54@grimberg.me>

> Dear All:
> 
>       I really need everyone's help, I use the nvme technology, through 
> two infiniband card,shared  the target side of a hard disk to the 
> client, I at the client through nvme connect, through two cards, can 
> identify two devices, respectively Is nvme0 and nvme1,
> 
> now I would like to nvme0n1 and nvme1n1 through multipath technology, 
> the client virtual into a /dev/nvme_share equipment, I want ask how to 
> achieve,
> 
>   because nvme no uuid, there is no scsi id, so I need everyone's Help, 
> thank you

I think that upstream libmultipath does support nvmf, which version are
you running?
