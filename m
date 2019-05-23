From: kbusch@kernel.org (Keith Busch)
Date: Thu, 23 May 2019 07:23:04 -0600
Subject: [PATCH 0/2] Reset timeout for paused hardware
In-Reply-To: <20190523101311.GB15492@lst.de>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <20190523032925.GA10601@ming.t460p>
 <CAOSXXT45jyLrKZ56QOPGWFyajtSvgPQcT+f2nj95n9Eowb44FA@mail.gmail.com>
 <20190523101311.GB15492@lst.de>
Message-ID: <20190523132304.GB14049@localhost.localdomain>

On Thu, May 23, 2019@03:13:11AM -0700, Christoph Hellwig wrote:
> On Wed, May 22, 2019@09:48:10PM -0600, Keith Busch wrote:
> > Yeah, that's a good question. A FW update may have been initiated out
> > of band or from another host entirely. The driver can't count on
> > preparing for hardware pausing command processing before it's
> > happened, but we'll always find out asynchronously after it's too late
> > to freeze.
> 
> I don't think that is the case at least for spec compliant devices.
> 
> From NVMe 1.3:
> 
> Figure 49: Asynchronous Event Information - Notice
> 
> 1h		Firmware Activation Starting: The controller is starting
> 		a firmware activation process during which command
> 		processing is paused. Host software may use CSTS.PP to
> 		determine when command processing has resumed. To clear
> 		this event, host software reads the Firmware Slot
> 		Information log page.
> 
> So we are supposed to get an AEN before the device stops processing
> commands.

Hm, I read the same section, but conclude differently (and at least some
vendors did too). A spec compliant controller activating new firmware
without reset would stop processing commands and set CSTS.PP first,
then send the AEN. When the host is aware to poll Processing Paused,
the controller hasn't been processing new commands for some time.

Could you give some more detail on your interpretation?
