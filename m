From: hch@lst.de (Christoph Hellwig)
Date: Thu, 23 May 2019 12:13:11 +0200
Subject: [PATCH 0/2] Reset timeout for paused hardware
In-Reply-To: <CAOSXXT45jyLrKZ56QOPGWFyajtSvgPQcT+f2nj95n9Eowb44FA@mail.gmail.com>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <20190523032925.GA10601@ming.t460p>
 <CAOSXXT45jyLrKZ56QOPGWFyajtSvgPQcT+f2nj95n9Eowb44FA@mail.gmail.com>
Message-ID: <20190523101311.GB15492@lst.de>

On Wed, May 22, 2019@09:48:10PM -0600, Keith Busch wrote:
> Yeah, that's a good question. A FW update may have been initiated out
> of band or from another host entirely. The driver can't count on
> preparing for hardware pausing command processing before it's
> happened, but we'll always find out asynchronously after it's too late
> to freeze.

I don't think that is the case at least for spec compliant devices.

>From NVMe 1.3:

Figure 49: Asynchronous Event Information - Notice

1h		Firmware Activation Starting: The controller is starting
		a firmware activation process during which command
		processing is paused. Host software may use CSTS.PP to
		determine when command processing has resumed. To clear
		this event, host software reads the Firmware Slot
		Information log page.

So we are supposed to get an AEN before the device stops processing
commands.
