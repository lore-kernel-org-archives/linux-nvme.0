From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 Nov 2015 20:57:57 +0000
Subject: [PATCHv2 2/2] NVMe: Shutdown fixes
In-Reply-To: <5654C7E4.6080602@fb.com>
References: <1448390128-25758-1-git-send-email-keith.busch@intel.com>
 <1448390128-25758-2-git-send-email-keith.busch@intel.com>
 <5654BDBA.9080406@fb.com>
 <20151124202033.GA6248@localhost.localdomain>
 <5654C7E4.6080602@fb.com>
Message-ID: <20151124205757.GB6248@localhost.localdomain>

On Tue, Nov 24, 2015@01:26:12PM -0700, Jens Axboe wrote:
> On 11/24/2015 01:20 PM, Keith Busch wrote:
> >Sure, I'm all for a better solution. We just need to prevent two threads
> >from hitting the same controller registers, and return when queues are
> >cleared. Is there a better way to control this?
> >
> >The driver's queue structures are already protected, but the existing
> >implementation allows one thread to pass the first that's waiting for
> >orderly queue deletion.
> 
> Just use a mutex? Check shutdown state after having held the lock,
> exit if we don't need to do anything.

Got it, thanks. Will send an update.
