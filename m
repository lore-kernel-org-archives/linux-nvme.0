From: efremmc2@gmail.com (Efrem Mc)
Date: Sun, 27 Nov 2016 23:57:33 -0500
Subject: Linux-nvme Digest, Vol 56, Issue 64
In-Reply-To: <mailman.3.1480276802.9433.linux-nvme@lists.infradead.org>
References: <mailman.3.1480276802.9433.linux-nvme@lists.infradead.org>
Message-ID: <CAEhOZrdzuwda+QZnE3D7rhGmY4S8Tk1VYmP4eFCZJtotY6p+Og@mail.gmail.com>

Hi all:

What is the best way to read archives on past articles?  I have one of
those Windows 10 Signature machines.  The internal SSD is a 512 GB
PCIe NVME by Samsung model MZVLV512. Goal to unleash all the speed
this nvme driver can support on Windows and Linux.  I know I need to
enable nvme on the kernel initramfs and test.  This machine I have as
some RAID configuration and the MFG supplied a BIOS patch to enable
AHCI.  I want the true NVME support as AHCI will limit the speed.  Any
help and directions are welcome.

On Sun, Nov 27, 2016 at 3:00 PM,
<linux-nvme-request@lists.infradead.org> wrote:
> Send Linux-nvme mailing list submissions to
>         linux-nvme at lists.infradead.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         http://lists.infradead.org/mailman/listinfo/linux-nvme
> or, via email, send a message with subject or body 'help' to
>         linux-nvme-request at lists.infradead.org
>
> You can reach the person managing the list at
>         linux-nvme-owner at lists.infradead.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linux-nvme digest..."
>
>
> Today's Topics:
>
>    1. Re: [PATCH v3 1/2] nvmet-rdma: align to generic ib_event
>       logging helper (Max Gurtovoy)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Sun, 27 Nov 2016 11:28:51 +0200
> From: Max Gurtovoy <maxg at mellanox.com>
> To: Christoph Hellwig <hch at infradead.org>
> Cc: J Freyensee <james_p_freyensee at linux.intel.com>,
>         <sagi at grimberg.me>, <linux-nvme at lists.infradead.org>
> Subject: Re: [PATCH v3 1/2] nvmet-rdma: align to generic ib_event
>         logging helper
> Message-ID: <e17d687f-9f0d-d07f-16f3-ffb85cdad1ff at mellanox.com>
> Content-Type: text/plain; charset="windows-1252"; format=flowed
>
>
>
> On 11/25/2016 9:48 AM, Christoph Hellwig wrote:
>> On Thu, Nov 24, 2016@01:19:11PM +0200, Max Gurtovoy wrote:
>>> in that case you'll get something like:
>>>
>>> "nvmet_rdma: received unrecognized IB QP event: last WQE reached (16)"
>>>
>>> instead of
>>>
>>> "nvmet_rdma: received IB QP event: last WQE reached (16)"
>>>
>>> Sagi/Christoph, what do you think ?
>>
>> I don't care, it's only a debug printk anyway.
>>
>
> me too :) I just want to put this 2 patches behind us.
>
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
>
> ------------------------------
>
> End of Linux-nvme Digest, Vol 56, Issue 64
> ******************************************
