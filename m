From: keith.busch@intel.com (Keith Busch)
Date: Mon, 20 Jun 2016 16:21:35 -0400
Subject: [PATCH 2/2] [RFC] nvme: enable asynchronous events notification
 by default
In-Reply-To: <576821E9.2060009@linux.vnet.ibm.com>
References: <1466184075-10471-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1466184075-10471-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <57679355.6000303@gmail.com> <576821E9.2060009@linux.vnet.ibm.com>
Message-ID: <20160620202135.GG12936@localhost.localdomain>

On Mon, Jun 20, 2016@02:03:37PM -0300, Guilherme G. Piccoli wrote:
> The goal of my patch is to do the 'job' of nvme-cli automatically from
> within the driver.
> 
> One thing I was thinking is to add a sysfs parameter to be able to avoid the
> automatic enablement of async events in case we have a bogus adapter showing
> too many events, for example...not sure if this is necessary though, so I
> didn't add the parameter on this submission.

Instead of simply logging a message, is there something better we can do
to notify a user of an async event result? The event should be masked
by the controller until the appropriate log page is read, and I don't
think scanning the kernel logs is how such a program wants to find out
which page to read.
