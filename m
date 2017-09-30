From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 30 Sep 2017 20:00:27 +0200
Subject: [PATCH 1/2] nvmet: fix ctlr ref counting
In-Reply-To: <20170928153553.13993-2-jsmart2021@gmail.com>
References: <20170928153553.13993-1-jsmart2021@gmail.com>
 <20170928153553.13993-2-jsmart2021@gmail.com>
Message-ID: <85e7a64e-fcf4-6a1d-02ea-55232b3c4199@grimberg.me>


> Current code:
> initializes the reference at allocation
> increments reference when ctlr finds are done
> has decrements to back out of ctlr finds
> decrements in admin queue connect cmd failures to
>    cause ctlr free
> in nvmet_sq_destroy() decrements to cause ctlr free
> 
> Issue is: nvmet_sq_destroy is called for every queue (admin and
> io), thus the controller is freed upon the first queue termination.
> It's an early "free". There could be other ctlr struct changes made
> while subsequent queues are being torn down.

This is not true, each sq takes a reference on the controller, so
the controller is actually freed only on the _last_ sq destroy.

Can you better explain what is the issue here?

> 
> An illustration of use-after-free was seen where the mutex for the
> ctrl was corrupted resulting in a mutex_lock hang.
> 
> Fix by:
> - make a formal control ref get routine.
> - have each sq binding to the ctlr do a ctlr get. This will
>    now pair with the put on each sq destroy.
> - in sq_destroy, if destroying the admin queue, do an
>    additional put so that ctlr will be torn down on last
>    queue sq_destroy

The fix is not explained sufficiently too here james. You seem
to add a ref in install_queue and put it twice in sq_destroy.

I don't see how this helps.
