From: keith.busch@intel.com (Keith Busch)
Date: Fri, 30 Oct 2015 13:38:28 +0000
Subject: IOCTL question.
In-Reply-To: <5633563B.3000901@ip-maker.com>
References: <5633563B.3000901@ip-maker.com>
Message-ID: <20151030133828.GA13904@localhost.localdomain>

On Fri, Oct 30, 2015@12:36:27PM +0100, Olivier Mallinger - IP Maker wrote:
> Hello.
> 
> I want to use the driver's ioctl and nvme cli with pass-through
> command to manage queues.
>
> The purpose is to create a queue with Submission and completion PRP List.
> I did a script doing the following :
>   - Delete all submission queue (ex. : nvme admin-passthru
> /dev/nvme0 --opcode=0x00 --cdw10=0x1)
>   - Delete all completion queue (ex. : nvme admin-passthru
> /dev/nvme0 --opcode=0x04 --cdw10=0x1)
>  - Create new completion queue (ex. : nvme admin-passthru /dev/nvme0
> --opcode=0x05 --cdw10=0x3ff0001 --cdw11=0x2)
>   - Create new submission queue (ex. : nvme admin-passthru
> /dev/nvme0 --opcode=0x01 --cdw10=0x3ff0001 --cdw11=0x00010000)
> 
> Until now, the device has completed all the command successfully and
> is ready to perform I/O command with this new queue.
> 
> Then, i try to send a single write command (ex. : nvme write
> /dev/nvme0n1 -s 0 -c 0 -z 4096 -y 0 -r 0 -d essai.txt -p 0 -m 0 -a 0
> -l 0 -t 0 -f 0).
> The device is never warn that a new command is available and the
> write is never fetch and not executed.
> 
> Can I manage the queue with the driver ioctl in that way ?
> What is the driver behavior when I delete and create queue ?

This is outside the scope of what the driver provides. The driver passes
through what you requested without further interpretation or examination
for sanity. It has no idea you just deleted the queues, so you're
just going to confuse the driver when the queues it created no longer
work. Similarly, the driver is not aware that you're creating new queues.

Creating queues requires DMA mapped memory. You can't do that with the
nvme-cli. Passthrough memory, if any is provided (which you have not
in your example), is pinned and mapped by the driver for only as long
as the command is in flight. Once complete, the driver unmaps it, then
the cli frees it.
