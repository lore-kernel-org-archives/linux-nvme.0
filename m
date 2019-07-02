From: fsteiner-mail1@bio.ifi.lmu.de (Frank Steiner)
Date: Tue, 2 Jul 2019 14:49:08 +0200
Subject: disk-activity trigger not working for nvme disk
In-Reply-To: <CAHhmqcTdN9UfYJCmfQ1kzSF+mP8-xjZyxBjqGr0dCs6gqth5Pg@mail.gmail.com>
References: <79f17609-5b3d-0d29-1642-c9ce30beb7f9@bio.ifi.lmu.de>
 <CAOSXXT6U8BeyXYWP9x-LW4mNkWYtumWdyw+fc19HJMpxRLQeLA@mail.gmail.com>
 <CAHhmqcTdN9UfYJCmfQ1kzSF+mP8-xjZyxBjqGr0dCs6gqth5Pg@mail.gmail.com>
Message-ID: <976249a8-9789-dd28-20d0-4917566c2f28@bio.ifi.lmu.de>

Bryan Gurney wrote:

> The only callers of ledtrig_disk_activity() in the kernel right now
> seem to be ide (./drivers/ide/ide-disk.c) and libata
> (./drivers/ata/libata-core.c).
> 
> However, there's definitely a motivation to try and extend this to
> NVMe devices, for a key reason: each NVMe device is its own

So as far as I understand your mail, the nvme driver would have to
be extended to make use of ledtrig_disk_activity, is that correct?

However, Keith had argued

> We don't take any particular action to notify any subsystem 
> of IO activity, so if the blinky lights work as desired on 
> some nvme platforms but not this one,

and I was pretty sure that it was working for the NVMe in our HP AIO
Desktop, so I checked again. Indeed, the NumLock does light up, and
I didn't really care about it a lot when I saw it seemed to work.

But actually it shows a strange behaviour. Instead of flickering
when some I/O is done, the LED just flashes periodically, once a second.
No matter what kind of I/O is performed on the disk. So it's not really
working as disk activity indicator, and that would likely match Bryans
observation that nvme doesn't use ledtrig_disk_activity at all.



-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
