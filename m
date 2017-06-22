From: micah.parrish@hpe.com (Micah Parrish)
Date: Thu, 22 Jun 2017 12:31:55 -0600
Subject: remove long broken SCSI to NVMe translations
In-Reply-To: <20170616083151.GB14698@infradead.org>
References: <20170614063537.1044-1-hch@lst.de>
 <20170614150025.GD26073@localhost.localdomain> <20170614150138.GA9428@lst.de>
 <af9655ff-f5ae-0d86-7b84-dd48caa7c35f@suse.de>
 <20170616083151.GB14698@infradead.org>
Message-ID: <922f6c05-cb61-9973-2c2c-823f31b5d082@hpe.com>

On 06/16/2017 02:31 AM, Christoph Hellwig wrote:
> [you dropped all the people in the To and Cc list..]
>
>> Someone should tell HPe, though; apparently they are using it for
>> firmware download ...
> Everything that could be done using the scsi emulation can be trivially
> done using nvme-cli, as they should have done from day 0.
>
> But adding the usual suspects to CC as they didn't seem to know it.
> And adding Robert just for fun :)

I'm relatively new at nvme so please bear with me as I try to articulate 
this.

 From HPE's perspective, we don't want NVME-SCSI translation removed 
from Linux.  We do drive firmware updates and other management functions 
using a common cross platform management API which works on VMWare, 
Windows and Linux, and it relies on SCSI on all 3.  This software 
(called SOULAPI) is common across most of our drives and enclosures, so 
putting in a special case for nvme on linux would be difficult.  In the 
short term we'd have to wrap nvme-cli, which would introduce a new 
dependency.  Long term maybe we could rewrite our API to use native NVME 
commands on all supported OSes.

The reason the scsi translation has been broken so long is that we don't 
test firmware updates with upstream kernels.  From our perspective it 
broke in the last enterprise update cycle, but we didn't discover it 
because we didn't have a firmware update for these drives.  There are 
some process improvements we could make there to catch this kind of bug 
sooner, and I will be discussing them internally.

-Micah Parrish
