From: pgadmin@pse-consulting.de (Andreas Pflug)
Date: Fri, 14 Jul 2017 18:47:43 +0200
Subject: kernel BUG at nvme/host/pci.c
In-Reply-To: <20170713134754.GD8388@localhost.localdomain>
References: <28fcb21a-35b6-61c1-29e0-9adcc954c98c@pse-consulting.de>
 <20170710190818.GA13671@localhost.localdomain>
 <64da8c4d-2d69-22fa-06a0-aa4f11903e39@pse-consulting.de>
 <20170711194523.GD4604@localhost.localdomain>
 <458f2115-4a07-e23c-2f1f-a90a95668f74@pse-consulting.de>
 <20170712195012.GA8388@localhost.localdomain>
 <5ac79312-b9e3-7cbb-8a82-382fb99705b5@pse-consulting.de>
 <20170713134754.GD8388@localhost.localdomain>
Message-ID: <39459fb9-ea2c-0718-10a1-a7e96b9ec21f@pse-consulting.de>

Am 13.07.17 um 15:47 schrieb Keith Busch:
>
>> Jul 13 10:37:37 xen2 [  202.703231] ---[ end trace 5b778353298dbe78 ]---
>> Jul 13 10:37:37 xen2 [  202.704217] sg[0] phys_addr:0x0000000aff50ec00 offset:3072 length:9216 dma_address:0x000000000070f000 dma_length:9216
>> Jul 13 10:37:37 xen2 [  202.705197] sg[1] phys_addr:0x0000000aff511000 offset:0 length:4096 dma_address:0x00000008755a1000 dma_length:4096
>> Jul 13 10:37:37 xen2 [  202.706275] sg[2] phys_addr:0x0000000aff5ef000 offset:0 length:8192 dma_address:0x0000000000712000 dma_length:8192
>> Jul 13 10:37:37 xen2 [  202.707315] sg[3] phys_addr:0x0000000aff564000 offset:0 length:4096 dma_address:0x0000000874fc0000 dma_length:4096
>> Jul 13 10:37:37 xen2 [  202.708202] sg[4] phys_addr:0x0000000aff5a7000 offset:0 length:4096 dma_address:0x0000000874fc0000 dma_length:4096
>> Jul 13 10:37:37 xen2 [  202.709030] sg[5] phys_addr:0x0000000aff5a6000 offset:0 length:4096 dma_address:0x0000000874fc0000 dma_length:4096
>> Jul 13 10:37:37 xen2 [  202.709960] sg[6] phys_addr:0x0000000aff5a5000 offset:0 length:3072 dma_address:0x0000000874fc0000 dma_length:3072
>> Jul 13 10:37:37 xen2 [  202.710755] print_req_error: I/O error, dev nvme0n1, sector 1188548943
>> Jul 13 10:37:37 xen2 [  202.711527] md/raid1:md1: nvme0n1p1: rescheduling sector 1188284751
> The first SGL has phys addr aff50ec00, which is a page offset of 3072,
> but the dma addr is 70f000, which is a 0 offset. Since DMA page offset
> doesn't match the physical address', this isn't compatible with the
> nvme implementation.
So LVM2 backed by md raid1 isn't compatible with newer hardware... Any
suggestions?

Regards,
Andreas
