From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Jul 2017 12:00:27 +0300
Subject: kernel BUG at nvme/host/pci.c
In-Reply-To: <5ac79312-b9e3-7cbb-8a82-382fb99705b5@pse-consulting.de>
References: <28fcb21a-35b6-61c1-29e0-9adcc954c98c@pse-consulting.de>
 <20170710190818.GA13671@localhost.localdomain>
 <64da8c4d-2d69-22fa-06a0-aa4f11903e39@pse-consulting.de>
 <20170711194523.GD4604@localhost.localdomain>
 <458f2115-4a07-e23c-2f1f-a90a95668f74@pse-consulting.de>
 <20170712195012.GA8388@localhost.localdomain>
 <5ac79312-b9e3-7cbb-8a82-382fb99705b5@pse-consulting.de>
Message-ID: <61ca3929-d722-a1fd-3b87-fe1d25301c0f@grimberg.me>

>>> nomerges set to 1 on both devices, same BUG_ON.
>> Thanks for the info.
>>
>> Could you possibly recreate with the patch below? This will simply
>> return IO error rather the panic, and show exactly how this invalid SGL
>> is constructed.
> Won't compile with 4.12.0, since BLK_STS_* and blk_status_t aren't present.
> Got the latest sources from git, applied the patch and earned "Invalid
> SGL for payload:36864 nents:7". System is badly yelling about i/o errors
> on NVME, so I rebooted.

I think if we iterated on the sgls logging their dma_address, offset and
length it'd be more useful.
