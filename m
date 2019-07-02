From: keith.busch@gmail.com (Keith Busch)
Date: Tue, 2 Jul 2019 20:27:09 +0900
Subject: disk-activity trigger not working for nvme disk
In-Reply-To: <79f17609-5b3d-0d29-1642-c9ce30beb7f9@bio.ifi.lmu.de>
References: <79f17609-5b3d-0d29-1642-c9ce30beb7f9@bio.ifi.lmu.de>
Message-ID: <CAOSXXT6U8BeyXYWP9x-LW4mNkWYtumWdyw+fc19HJMpxRLQeLA@mail.gmail.com>

On Mon, Jul 1, 2019 at 6:12 PM Frank Steiner
<fsteiner-mail1@bio.ifi.lmu.de> wrote:
> It's about the disk-activity trigger for the led kernel subsystem.
> We are trying to turn e.g. the num lock led into a hard disk activity
> indicator by
>
> echo disk-activity > /sys/class/leds/input0::numlock/trigger
>
> This works fine on all our older thinkpad models with SATA hard disks
> and works also on our PCs with SSD disks (SATA as well as NVME), but
> it fails on our newer thinkpads, i.e. T570 and T580, with NVME SSDs.
>
> The LED just stays off all the time no matter what we do with the hard
> disk. As all other triggers do work, people on the ibm-acpi-devel list
> supposed it might be an issue in the nvme driver (and not the thinkpad_acpi
> module).

I'm not very familiar with the led subsystem, but I can't imagine what
the nvme driver has to do with this. We don't take any particular
action to notify any subsystem of IO activity, so if the blinky lights
work as desired on some nvme platforms but not this one, it sounds
like the issue must be external to the nvme subsystem. What does this
platform want the driver to do in order to trigger the desired light?
