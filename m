From: bgurney@redhat.com (Bryan Gurney)
Date: Tue, 2 Jul 2019 10:20:56 -0400
Subject: disk-activity trigger not working for nvme disk
In-Reply-To: <976249a8-9789-dd28-20d0-4917566c2f28@bio.ifi.lmu.de>
References: <79f17609-5b3d-0d29-1642-c9ce30beb7f9@bio.ifi.lmu.de>
 <CAOSXXT6U8BeyXYWP9x-LW4mNkWYtumWdyw+fc19HJMpxRLQeLA@mail.gmail.com>
 <CAHhmqcTdN9UfYJCmfQ1kzSF+mP8-xjZyxBjqGr0dCs6gqth5Pg@mail.gmail.com>
 <976249a8-9789-dd28-20d0-4917566c2f28@bio.ifi.lmu.de>
Message-ID: <CAHhmqcRjp9mk8NTw+3Du_NgTfDzHa7-kp-w8=b8amnGEBJkkPQ@mail.gmail.com>

On Tue, Jul 2, 2019 at 8:49 AM Frank Steiner
<fsteiner-mail1@bio.ifi.lmu.de> wrote:
>
> Bryan Gurney wrote:
>
> > The only callers of ledtrig_disk_activity() in the kernel right now
> > seem to be ide (./drivers/ide/ide-disk.c) and libata
> > (./drivers/ata/libata-core.c).
> >
> > However, there's definitely a motivation to try and extend this to
> > NVMe devices, for a key reason: each NVMe device is its own
>
> So as far as I understand your mail, the nvme driver would have to
> be extended to make use of ledtrig_disk_activity, is that correct?
>

Supposedly.  I'm not sure how to do it, but it might be worth a try,
to see if it's possible.

I forgot to mention the locations of where ide and libata call
ledtrig_disk_activity():

In ./drivers/ide/ide-disk.c, it's called in ide_do_rw_disk(), near the
beginning of the function:

        ledtrig_disk_activity(rq_data_dir(rq) == WRITE);

In ./drivers/ata/libata-core.c, it's called in ata_qc_complete(), near
the beginning of the function:

        ledtrig_disk_activity(!!(qc->tf.flags & ATA_TFLAG_WRITE));

> However, Keith had argued
>
> > We don't take any particular action to notify any subsystem
> > of IO activity, so if the blinky lights work as desired on
> > some nvme platforms but not this one,
>
> and I was pretty sure that it was working for the NVMe in our HP AIO
> Desktop, so I checked again. Indeed, the NumLock does light up, and
> I didn't really care about it a lot when I saw it seemed to work.
>
> But actually it shows a strange behaviour. Instead of flickering
> when some I/O is done, the LED just flashes periodically, once a second.
> No matter what kind of I/O is performed on the disk. So it's not really
> working as disk activity indicator, and that would likely match Bryans
> observation that nvme doesn't use ledtrig_disk_activity at all.
>

Aha; that's interesting. I wonder if that specific example of hardware
is using a firmware routine to flash that light.  It's possible, but
it would be vendor-specific, and not really consistent with the
previous "HDD LED" behavior of having a near-analog response to disk
activity, or the International Blinking Pattern Interpretation
behavior of 4 Hz on/off during drive activity, and "steady on" for a
drive that is online, but idle.

One key thing to remember about NVMe drives in general is that each
drive is its own controller.  This is different from past drive
interfaces, like IDE, SCSI, and ATA, where most systems had an onboard
controller, which would then have a 2-pin 0.1-inch-spaced electrical
header, which would be connected to an "HDD" LED on the case.
Additional controllers (host bus adapters, RAID adapters, etc.) would
usually have an 0.1-inch-spaced header, where the "HDD LED" cable can
be plugged in.

Therefore, if each NVMe drive is its own controller, how does one
display the activity of each drive on a single LED?  Aside from
something like the example HP all-in-one system, most other
manufacturers seem to be choosing to not have a drive activity LED
anymore (and this design decision dates back to the early 2010s,
before NVMe system drives were prevalent in consumer computing
devices).


Thanks,

Bryan
