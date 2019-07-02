From: bgurney@redhat.com (Bryan Gurney)
Date: Tue, 2 Jul 2019 08:27:23 -0400
Subject: disk-activity trigger not working for nvme disk
In-Reply-To: <CAOSXXT6U8BeyXYWP9x-LW4mNkWYtumWdyw+fc19HJMpxRLQeLA@mail.gmail.com>
References: <79f17609-5b3d-0d29-1642-c9ce30beb7f9@bio.ifi.lmu.de>
 <CAOSXXT6U8BeyXYWP9x-LW4mNkWYtumWdyw+fc19HJMpxRLQeLA@mail.gmail.com>
Message-ID: <CAHhmqcTdN9UfYJCmfQ1kzSF+mP8-xjZyxBjqGr0dCs6gqth5Pg@mail.gmail.com>

On Tue, Jul 2, 2019@7:27 AM Keith Busch <keith.busch@gmail.com> wrote:
>
> On Mon, Jul 1, 2019 at 6:12 PM Frank Steiner
> <fsteiner-mail1@bio.ifi.lmu.de> wrote:
> > It's about the disk-activity trigger for the led kernel subsystem.
> > We are trying to turn e.g. the num lock led into a hard disk activity
> > indicator by
> >
> > echo disk-activity > /sys/class/leds/input0::numlock/trigger
> >
> > This works fine on all our older thinkpad models with SATA hard disks
> > and works also on our PCs with SSD disks (SATA as well as NVME), but
> > it fails on our newer thinkpads, i.e. T570 and T580, with NVME SSDs.
> >
> > The LED just stays off all the time no matter what we do with the hard
> > disk. As all other triggers do work, people on the ibm-acpi-devel list
> > supposed it might be an issue in the nvme driver (and not the thinkpad_acpi
> > module).
>
> I'm not very familiar with the led subsystem, but I can't imagine what
> the nvme driver has to do with this. We don't take any particular
> action to notify any subsystem of IO activity, so if the blinky lights
> work as desired on some nvme platforms but not this one, it sounds
> like the issue must be external to the nvme subsystem. What does this
> platform want the driver to do in order to trigger the desired light?
>

On a search through the kernel source, I found
./drivers/leds/trigger/ledtrig-disk.c, which has this function:

void ledtrig_disk_activity(bool write)

Looking at the log for this file, I see commit
eb25cb9956cc9384b7fa0d75dec908c9fac8c444 with this note:

"The patch... is widely used by any ibook/powerbook owners with great
satisfaction.  Likewise, it is very often used successfully on
different ARM platforms."

So it sounds like the intention is to give a storage activity light to
platforms that don't have them, due to the design decisions of
manufacturers.

The only callers of ledtrig_disk_activity() in the kernel right now
seem to be ide (./drivers/ide/ide-disk.c) and libata
(./drivers/ata/libata-core.c).

However, there's definitely a motivation to try and extend this to
NVMe devices, for a key reason: each NVMe device is its own
controller.  With current form factors, the manufacturer might add an
activity LED, but it will be a surface-mount LED on the drive's
controller circuit board.  That works for add-in-card and U.2 form
factors, but I don't believe I've seen an activity LED on an M.2 NVMe
SSD, and the device won't be visible inside an opaque computer case.

Also, sadly, most portable computer manufacturers have been omitting
the storage activity LED from their case designs, even for computers
that are using Serial ATA for storage.  (I've "retrofitted" a couple
such systems I own, moving the power LED to the "HDD activity"
header.)

And if there's a problem with the monitor or video driver, a storage
activity LED can give a positive indication that the system isn't hung
(though perhaps not as much as other operating systems that empty
their page cache in 8 intervals of 1 second each.)

As for server platforms, those hardware designers are usually very
good about placing activity LEDs on each storage device, since it's
mission-critical equipment.  I even read a news article from Flash
Memory Summit 2018 that the EDSFF hot-plug NVMe form factor specifies
a status LED on the drive, eliminating the need for backplanes to
provide status LED functionality.


Thanks,

Bryan
