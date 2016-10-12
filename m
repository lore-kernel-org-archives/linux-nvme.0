From: keith.busch@intel.com (Keith Busch)
Date: Wed, 12 Oct 2016 16:25:24 -0400
Subject: Firmware Activate without Reset
In-Reply-To: <B4627D7B-0736-4436-9901-EA9575105919@hgst.com>
References: <B4627D7B-0736-4436-9901-EA9575105919@hgst.com>
Message-ID: <20161012202523.GB12827@localhost.localdomain>

On Wed, Oct 12, 2016@07:37:13PM +0000, David Darrington wrote:
> I?m trying to understand how firmware activate without reset would work. Is there a requirement for the driver to do something to support this? Should the driver be listening for Firmware Activation Notifications, and respond in some way? 
> 

I don't think there's anything the driver necessarily has to do. If
anything, we could have it observe the notify AER on firmware activation
started, quiesce IO, then poll CSTS.PP. Once cleared, it can restart IO.

But that shouldn't really be necessary since we expect all outstanding
commands to complete when the activation completes. If activation takes
longer than an IO timeout, it might be best to quiesce, but the driver
doesn't do that right now.

If new firmware brings new capabilities that you want the driver to use,
the driver won't discover these until after a controller reset.
