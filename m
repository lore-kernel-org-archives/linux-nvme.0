From: keith.busch@intel.com (Keith Busch)
Date: Thu, 3 Dec 2015 23:50:41 +0000
Subject: IRQ and CPU Affinity on new Kernels
In-Reply-To: <CAMjVwgQRoPi8Chta3sXdxAZX3KCsQOu9fqRvL_i9qRqg1BkFmQ@mail.gmail.com>
References: <CAMjVwgQRoPi8Chta3sXdxAZX3KCsQOu9fqRvL_i9qRqg1BkFmQ@mail.gmail.com>
Message-ID: <20151203235041.GA3565@localhost.localdomain>

On Thu, Dec 03, 2015@06:35:55PM -0500, Angelo Brito wrote:
> Hello Gentlemen,
> 
> We had some problems with a controller and some commands were missing
> (timeouts and cancelling I/O).
>
> I noticed that some interruptions were handled by different CPUs, like
> in this example:

I doubt the interrupt affinity you're seeing could have anything
to do with timeouts or missing commands.

There is a small window of time when a disk is initially brought online,
but before the affinity hints are provided. Because of that, even if
you properly affinitize all irqs to use the driver's hint, you'll likely
see a few irqs on non-optimal CPU.
