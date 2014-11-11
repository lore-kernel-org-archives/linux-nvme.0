From: keith.busch@intel.com (Keith Busch)
Date: Tue, 11 Nov 2014 16:15:39 +0000 (UTC)
Subject: System hang issue during hibernation resume due to del_gendisk
In-Reply-To: <alpine.LNX.2.00.1411111511590.4225@localhost.lm.intel.com>
References: <908627706.204341415718459019.JavaMail.weblogic@epmlwas06b>
 <alpine.LNX.2.00.1411111511590.4225@localhost.lm.intel.com>
Message-ID: <alpine.LNX.2.00.1411111613080.4225@localhost.lm.intel.com>

On Tue, 11 Nov 2014, Keith Busch wrote:
> I knew calling del_gendisk from resume wouldn't work, which is why it's
> done in a work queue, and removed in another thread if the device is
> gone. That's still not okay?

I can see how it might not be okay if the driver does not include
this patch:

http://git.infradead.org/users/willy/linux-nvme.git/commit/74bae7e0dd70f3eee05d577d3d25fbcd54af4228
