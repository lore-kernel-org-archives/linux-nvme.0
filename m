From: efremmc2@gmail.com (Efrem Mc)
Date: Tue, 29 Nov 2016 08:49:55 -0800
Subject: Native PCIe NVME support from kernel
Message-ID: <CAEhOZrfPf0KMHHu8Bp47bA17upzbbqEtZU0apRYVpzytbJE0pQ@mail.gmail.com>

Hi all,

I was able to get the nvme module configured by changing the MFG BIOS
SATA setting to AHCI mode.  Intel had support native in the kernel
since 3.3, I had to create an initrd with the support to enable it on
boot.  It works now.  I have not installed the OS yet, as this was a
test from a LiveOS USB boot.

blkid shows the /dev/nvme0n1, and the partitions alike /dev/nvme0n1p1,
..0n1p4 in my case on the GPT parted system.

Interested to note that gparted reports errors, partitionmanager in
KDE works! parted show the configuration.  The Linux OS uses calameres
as the installer so what it uses for partition, I will find out soon.

On Mon, Nov 28, 2016 at 12:00 PM,
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
>    1. Re: [PATCH 3/3] nvmetcli: remove README file (J Freyensee)
>    2. Re: Linux-nvme Digest, Vol 56, Issue 64 (Keith Busch)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Mon, 28 Nov 2016 07:55:52 -0800
> From: J Freyensee <james_p_freyensee at linux.intel.com>
> To: Christoph Hellwig <hch at lst.de>
> Cc: agrover at redhat.com, linux-nvme at lists.infradead.org
> Subject: Re: [PATCH 3/3] nvmetcli: remove README file
> Message-ID: <1480348552.2827.12.camel at linux.intel.com>
> Content-Type: text/plain; charset="UTF-8"
>
> On Fri, 2016-11-25@08:46 +0100, Christoph Hellwig wrote:
>> On Wed, Nov 23, 2016@10:01:13AM -0800, Jay Freyensee wrote:
>> >
>> > Contents of README have been moved and updated into the
>> > manpage/html solution.
>>
>>
>> I still think that a basic README is useful, including pointing
>> people
>> to the manpage, and for build instruction in case we add any.
>
> OK, I can re-send the patch series and not touch the README.
>
>>
>>
>> >
>> > --- a/README
>> > +++ /dev/null
>> > @@ -1,173 +0,0 @@
>> > -nvmetcli
>> > -========
>> > -This contains the NVMe target admin tool "nvmetcli".??It can
>> > either be
>> > -used interactively by invoking it without arguments, or it can be
>> > used
>> > -to save, restore or clear the current NVMe target configuration.
>> > -
>> > -Installation
>> > -------------
>> > -Please install the configshell-fb package from
>> > -https://github.com/agrover/configshell-fb first.
>> > -
>> > -nvmetcli can be run directly from the source directory or
>> > installed
>> > -using setup.py.
>> > -
>> > -Common Package Dependencies and Problems
>> > ------------------------------------------
>> > -nvmetcli uses the 'python-six' and 'pyparsing' packages
>> > -(running nvmetcli without these packages may produce
>> > -hard-to-decipher errors).
>>
>>
>> E.g. keep everything up to here, then add a reference to
>> nvmetcli.txt after that.
>>
>> And keep the rest quotes below this text as well,
>>
>> >
>> > -Example NVMe Target .json files
>> > ---------------------------------------
>> > -To load the loop + explicit host version above do the following:
>> > -
>> > -??./nvmetcli restore loop.json
>> > -
>> > -Or to load the rdma + no host authentication version do the
>> > following
>> > -after you've ensured that the IP address in rdma.json fits your
>> > setup:
>> > -
>> > -??./nvmetcli restore rdma.json
>> > -
>> > -These files can also be edited directly using your favorite
>> > editor.
>> > -
>> > -Testing
>> > --------
>> > -nvmetcli comes with a testsuite that tests itself and the kernel
>> > configfs
>> > -interface for the NVMe target.??To run it make sure you have nose2
>> > and
>> > -the coverage plugin for it installed and simple run 'make test'.
>> > -
>> > -Development
>> > ------------------
>> > -Please send to linux-nvme at lists.infradead.org for review and
>> > acceptance.
>> > --?
>> > 2.7.4
>> ---end quoted text---
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
>
>
> ------------------------------
>
> Message: 2
> Date: Mon, 28 Nov 2016 11:36:00 -0500
> From: Keith Busch <keith.busch at intel.com>
> To: Efrem Mc <efremmc2 at gmail.com>
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: Linux-nvme Digest, Vol 56, Issue 64
> Message-ID: <20161128163600.GD2609 at localhost.localdomain>
> Content-Type: text/plain; charset=us-ascii
>
> On Sun, Nov 27, 2016@11:57:33PM -0500, Efrem Mc wrote:
>> What is the best way to read archives on past articles?  I have one of
>> those Windows 10 Signature machines.  The internal SSD is a 512 GB
>> PCIe NVME by Samsung model MZVLV512. Goal to unleash all the speed
>> this nvme driver can support on Windows and Linux.  I know I need to
>> enable nvme on the kernel initramfs and test.  This machine I have as
>> some RAID configuration and the MFG supplied a BIOS patch to enable
>> AHCI.  I want the true NVME support as AHCI will limit the speed.  Any
>> help and directions are welcome.
>
> If I understand correctly what you're using, you'll want to use the
> BIOS's AHCI mode for Linux so that the NVMe device is not remapped into
> the "RAID" device.
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
> End of Linux-nvme Digest, Vol 56, Issue 66
> ******************************************
