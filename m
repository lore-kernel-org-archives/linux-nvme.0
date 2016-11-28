From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Nov 2016 11:36:00 -0500
Subject: Linux-nvme Digest, Vol 56, Issue 64
In-Reply-To: <CAEhOZrdzuwda+QZnE3D7rhGmY4S8Tk1VYmP4eFCZJtotY6p+Og@mail.gmail.com>
References: <mailman.3.1480276802.9433.linux-nvme@lists.infradead.org>
 <CAEhOZrdzuwda+QZnE3D7rhGmY4S8Tk1VYmP4eFCZJtotY6p+Og@mail.gmail.com>
Message-ID: <20161128163600.GD2609@localhost.localdomain>

On Sun, Nov 27, 2016@11:57:33PM -0500, Efrem Mc wrote:
> What is the best way to read archives on past articles?  I have one of
> those Windows 10 Signature machines.  The internal SSD is a 512 GB
> PCIe NVME by Samsung model MZVLV512. Goal to unleash all the speed
> this nvme driver can support on Windows and Linux.  I know I need to
> enable nvme on the kernel initramfs and test.  This machine I have as
> some RAID configuration and the MFG supplied a BIOS patch to enable
> AHCI.  I want the true NVME support as AHCI will limit the speed.  Any
> help and directions are welcome.

If I understand correctly what you're using, you'll want to use the
BIOS's AHCI mode for Linux so that the NVMe device is not remapped into
the "RAID" device.
