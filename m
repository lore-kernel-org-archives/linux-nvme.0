From: keith.busch@intel.com (Keith Busch)
Date: Fri, 4 Sep 2015 15:44:38 +0000 (UTC)
Subject: Does /dev/nvme0n1p1 take a long time to created in /dev/ on boot?
In-Reply-To: <55E916A2.5090005@freenet.carleton.ca>
References: <55E916A2.5090005@freenet.carleton.ca>
Message-ID: <alpine.LNX.2.00.1509041521000.23840@localhost.lm.intel.com>

On Thu, 3 Sep 2015, peter brown wrote:
> As a side note... I'm wondering if the 720 ssd card is broken.
> I'm getting very very poor performance from the card. It works
> (no bad logs in syslog) but the device is almost as slow as my
> Seagate hard drive!
>
> hdparm -tT /dev/nvme0n1p1
> /dev/nvme0n1p1:
> Timing cached reads:   28348 MB in  2.00 seconds = 14188.57 MB/sec
> Timing buffered disk reads: 434 MB in  3.01 seconds = 144.25 MB/sec

That is well below h/w spec. Any difference if you run 'hdparma -t'
to the raw /dev/nvme0n1 partition? Even a badly aligned partition can't
account for that much off the h/w spec, but curious to know if there's
a difference.

With your boot issue, it sounds like the drive + driver are working, but
the init sequence is not waiting for the root partition to mount. Not sure
what logs to get that will tell us what we need to tune. Maybe a dmesg
to start. And something else depending on what init process you're using. ?
