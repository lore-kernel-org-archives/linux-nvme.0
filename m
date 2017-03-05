From: leonro@mellanox.com (Leon Romanovsky)
Date: Sun, 5 Mar 2017 20:23:56 +0200
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <3eb5814f-14cb-2b94-adf8-335d4b2eb7e9@grimberg.me>
References: <08131a05-1f56-ef61-990a-7fff04eea095@gmail.com>
 <de1a559a-bf24-0d73-5fc7-148d6cd4d4e0@grimberg.me>
 <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
 <1554c1d1-6bf4-9ca2-12d4-a0125d8c5715@gmail.com>
 <DE927C68B458BE418D582EC97927A92854655137@ORSMSX112.amr.corp.intel.com>
 <3eb5814f-14cb-2b94-adf8-335d4b2eb7e9@grimberg.me>
Message-ID: <20170305182356.GM14379@mtr-leonro.local>

On Mon, Feb 27, 2017@10:33:16PM +0200, Sagi Grimberg wrote:
>
> Hey Joseph,
>
> > In our lab we are dealing with an issue which has some of the same symptoms.  Wanted to add to the thread in case it is useful here.  We have a target system with 16 Intel P3520 disks and a Mellanox CX4 50Gb NIC directly connected (no switch) to a single initiator system with a matching Mellanox CX4 50Gb NIC.  We are running Ubuntu 16.10 with 4.10-RC8 mainline kernel.  All drivers are kernel default drivers.  I've attached our nvmetcli json, and FIO workload, and dmesg from both systems.
> >
> > We are able to provoke this problem with a variety of workloads but a high bandwidth read operation seems to cause it the most reliably, harder to produce with smaller block sizes.  For some reason the problem seems produced when we stop and restart IO - I can run the FIO workload on the initiator system for 1-2 hours without any new events in dmesg, pushing about 5500MB/sec the whole time, then kill it and wait 10 seconds and restart it, and the errors and reconnect events happen reliably at that point.  Working to characterize further this week and also to see if we can produce on a smaller configuration.  Happy to provide any additional details that would be useful or try any fixes!
> >
> > On the initiator we see events like this:
> >
> > [51390.065641] mlx5_0:dump_cqe:262:(pid 0): dump error cqe
> > [51390.065644] 00000000 00000000 00000000 00000000
> > [51390.065645] 00000000 00000000 00000000 00000000
> > [51390.065646] 00000000 00000000 00000000 00000000
> > [51390.065648] 00000000 08007806 250003ab 02b9dcd2
> > [51390.065666] nvme nvme3: MEMREG for CQE 0xffff9fc845039410 failed with status memory management operation error (6)
> > [51390.079156] nvme nvme3: reconnecting in 10 seconds
> > [51400.432782] nvme nvme3: Successfully reconnected
>
> Seems to me this is a CX4 FW issue. Mellanox can elaborate on these
> vendor specific syndromes on this output.

0x06 - Memory_Window_Bind_Error
0x78 - MEMOP_FRWR_TPT
0x08 - Not free

The check is for both umr.check_free and mkey.free.

Hope it helps.

Thanks
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170305/a8859651/attachment.sig>
