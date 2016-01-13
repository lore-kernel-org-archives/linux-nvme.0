From: axboe@fb.com (Jens Axboe)
Date: Wed, 13 Jan 2016 10:47:40 -0700
Subject: NVM and swap device
In-Reply-To: <20160112194030.5b74ecdc@xeon-e3>
References: <20160112194030.5b74ecdc@xeon-e3>
Message-ID: <56968DBC.1040609@fb.com>

On 01/12/2016 08:40 PM, Stephen Hemminger wrote:
> I have a nice shiny new Intel NVM PCI card; decided to use it for a filesystem and swap.
> The filesystem (btrfs) is doing fine, but the swap device was throwing occasional
> random errors. Suspect a driver problem rather than hardware.
>
> I am using 4.4 kernel without patches.
>
> kern.log:Jan 12 08:11:57 xeon-e3 kernel: [159474.037390] Read-error on swap-device (259:0:17597808)
> kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87938.855526] Read-error on swap-device (259:0:11355648)
> kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87938.855530] Read-error on swap-device (259:0:11355656)
> kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87939.855467] Read-error on swap-device (259:0:16180824)
> kern.log.1:Jan  8 08:24:07 xeon-e3 kernel: [63670.777981] Read-error on swap-device (259:0:32690768)
> kern.log.1:Jan  9 09:25:02 xeon-e3 kernel: [153720.919325] Read-error on swap-device (259:0:220488)
> kern.log.1:Jan  9 16:40:05 xeon-e3 kernel: [179820.957675] Read-error on swap-device (259:0:24476232)
> kern.log.1:Jan  9 16:40:05 xeon-e3 kernel: [179820.962673] Read-error on swap-device (259:0:33292816)
>
> The swap device was being added via /etc/fstab by UUID.
>
> I gave up and went back to spinning rust for swap device for stabilty.

That's very odd. Why are you suspecting a driver problem? Have you tried 
to thoroughly beat the device up with normal IO?

-- 
Jens Axboe
