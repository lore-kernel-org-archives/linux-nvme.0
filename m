From: pgadmin@pse-consulting.de (Andreas Pflug)
Date: Wed, 12 Jul 2017 08:06:29 +0200
Subject: kernel BUG at nvme/host/pci.c
In-Reply-To: <20170711194523.GD4604@localhost.localdomain>
References: <28fcb21a-35b6-61c1-29e0-9adcc954c98c@pse-consulting.de>
 <20170710190818.GA13671@localhost.localdomain>
 <64da8c4d-2d69-22fa-06a0-aa4f11903e39@pse-consulting.de>
 <20170711194523.GD4604@localhost.localdomain>
Message-ID: <458f2115-4a07-e23c-2f1f-a90a95668f74@pse-consulting.de>

Am 11.07.17 um 21:45 schrieb Keith Busch:
> On Tue, Jul 11, 2017@09:44:47AM +0200, Andreas Pflug wrote:
>> Tested with 4.12.0, result is
>>
>>   kernel BUG at drivers/nvme/host/pci.c:610!
>>
>> Kernel seems to recover from that, but I did a reboot anyway.
>  
> Ugh, still observing invalid scatter lists on 4.12. Definitely recommend
> rebooting after hitting this.
>
> There should only be two possibilities: either the block layer didn't
> split a bio that it should have, or it merged two that it shouldn't. To
> determine which, could disable merging for NVMe before running your
> test? Something like this should accomplish that:
>
>   # echo 1 | tee /sys/block/nvme*/queue/nomerge
nomerges set to 1 on both devices, same BUG_ON.

Regards,
Andreas
