From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Jun 2015 08:23:48 -0700
Subject: [PATCH 2/3] NVMe: Don't use fake status on cancelled command
In-Reply-To: <alpine.LNX.2.00.1506111410500.15930@localhost.lm.intel.com>
References: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
 <1433779695-15866-3-git-send-email-keith.busch@intel.com>
 <20150611104033.GA21107@infradead.org>
 <alpine.LNX.2.00.1506111410500.15930@localhost.lm.intel.com>
Message-ID: <20150611152348.GB1292@infradead.org>

On Thu, Jun 11, 2015@02:15:31PM +0000, Keith Busch wrote:
> Yep, the first command issued is set features for number of queues. If
> this returns a valid non-successful NVMe status, the driver believes
> the controller is operational and can be managed, although no IO. If it
> returns a status < 0, the controller is believed to be non-operational
> and initialization will fail.
> 
> I used -EINTR to restore what used to be returned from the driver's
> original implementation, but it doesn't have to be this error.

Seems like a few other places use -EINTR the same, so let's keep it
for now and maybe replace all of them with something more sensible
in another step.
