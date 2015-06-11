From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Jun 2015 14:15:31 +0000 (UTC)
Subject: [PATCH 2/3] NVMe: Don't use fake status on cancelled command
In-Reply-To: <20150611104033.GA21107@infradead.org>
References: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
 <1433779695-15866-3-git-send-email-keith.busch@intel.com>
 <20150611104033.GA21107@infradead.org>
Message-ID: <alpine.LNX.2.00.1506111410500.15930@localhost.lm.intel.com>

On Thu, 11 Jun 2015, Christoph Hellwig wrote:
> On Mon, Jun 08, 2015@10:08:14AM -0600, Keith Busch wrote:
>> Synchronized commands do different things for timed out commands
>> vs. controller returned errors.
>
> Can you explain this a bit more?  Can't find anything that checks for
> the error value.  Let's hope the EINTR never leaks to userspace either
> as it has a well defined and very different meaning there.

Yep, the first command issued is set features for number of queues. If
this returns a valid non-successful NVMe status, the driver believes
the controller is operational and can be managed, although no IO. If it
returns a status < 0, the controller is believed to be non-operational
and initialization will fail.

I used -EINTR to restore what used to be returned from the driver's
original implementation, but it doesn't have to be this error.
