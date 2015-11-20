From: m@bjorling.me (=?windows-1252?Q?Matias_Bj=F8rling?=)
Date: Fri, 20 Nov 2015 12:06:36 +0100
Subject: nvme lightnvm comments
In-Reply-To: <20151120105022.GA22131@infradead.org>
References: <20151120105022.GA22131@infradead.org>
Message-ID: <564EFEBC.3040603@bjorling.me>

Hi Christoph,

On 11/20/2015 11:50 AM, Christoph Hellwig wrote:
> Hi Matias,
>
> two small comments on the NVME lighnvm support:
>
>   1) please don't claim the existing Qemu NVMe PCI ID for lightnvm
>      support.  We might need the actual vendor specific data for
>      qemu purposes.  Please allocate a different PCI ID for a qemu
>      emulated lightnvm nvme device

I'll look into it.

>   2) please build the lightnvm.o object conditionally in the makefile

Then the functions

nvme_nvm_register
nvme_nvm_unregister
nvme_nvm_register

have to be #ifdef'ed in the pci file. Do you want that instead? It was 
on purpose the other way around, so that the nvme_nvm_* functions was 
null functions if lightnvm isn't compiled in.

>
> Thanks!
>
