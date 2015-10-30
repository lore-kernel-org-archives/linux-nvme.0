From: olivier.mallinger@ip-maker.com (Olivier Mallinger - IP Maker)
Date: Fri, 30 Oct 2015 12:36:27 +0100
Subject: IOCTL question.
Message-ID: <5633563B.3000901@ip-maker.com>

Hello.

I want to use the driver's ioctl and nvme cli with pass-through command 
to manage queues.
The purpose is to create a queue with Submission and completion PRP List.

I did a script doing the following :
   - Delete all submission queue (ex. : nvme admin-passthru /dev/nvme0 
--opcode=0x00 --cdw10=0x1)
   - Delete all completion queue (ex. : nvme admin-passthru /dev/nvme0 
--opcode=0x04 --cdw10=0x1)
  - Create new completion queue (ex. : nvme admin-passthru /dev/nvme0 
--opcode=0x05 --cdw10=0x3ff0001 --cdw11=0x2)
   - Create new submission queue (ex. : nvme admin-passthru /dev/nvme0 
--opcode=0x01 --cdw10=0x3ff0001 --cdw11=0x00010000)

Until now, the device has completed all the command successfully and is 
ready to perform I/O command with this new queue.

Then, i try to send a single write command (ex. : nvme write 
/dev/nvme0n1 -s 0 -c 0 -z 4096 -y 0 -r 0 -d essai.txt -p 0 -m 0 -a 0 -l 
0 -t 0 -f 0).
The device is never warn that a new command is available and the write 
is never fetch and not executed.

Can I manage the queue with the driver ioctl in that way ?
What is the driver behavior when I delete and create queue ?

Thanks.
Regards.
Olivier.




-------------- next part --------------
A non-text attachment was scrubbed...
Name: olivier_mallinger.vcf
Type: text/x-vcard
Size: 316 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20151030/d59a63c1/attachment.vcf>
