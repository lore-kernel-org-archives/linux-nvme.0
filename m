From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 14 May 2018 07:53:18 -0700
Subject: [PATCH] nvme: block ioctls if controller not in a live state
In-Reply-To: <2b21ba25-e581-45a7-95ae-8b3f2fe6dcf8@broadcom.com>
References: <20180507225558.5009-1-jsmart2021@gmail.com>
 <20180509051156.GB28673@infradead.org>
 <06b65874-8bc8-b532-ad98-44e64b8440b8@broadcom.com>
 <20180514141734.GA26302@infradead.org>
 <2b21ba25-e581-45a7-95ae-8b3f2fe6dcf8@broadcom.com>
Message-ID: <20180514145318.GA24711@infradead.org>

On Mon, May 14, 2018@07:47:46AM -0700, James Smart wrote:
> 
> 
> On 5/14/2018 7:17 AM, Christoph Hellwig wrote:
> > On Wed, May 09, 2018@09:29:13AM -0700, James Smart wrote:
> > > That is the exact intent.? I do want the app to trigger off -EAGAIN in those
> > > two states and try again after a delay./? Perhaps I should change from !LIVE
> > > to NEW || RESETTING || CONNECTING to be more explicit.? I assumed !LIVE was
> > > sufficient as the other states should transition to LIVE or the delete path
> > > is taken which would remove the fd all together.
> > The problem is that userspace reasonably expects to be able to call
> > poll/select when used on a character device and it gets -EAGAIN.
> 
> What's stopping us from adding poll support to the dev node ?

A volunteer to write the code.

> 
> > 
> > Maybe the right solution here is to just do a wait_event_interruptible to
> > wait for the controller being live.
> 
> That's doable. I don't like hanging the app up for what could be 60s or so
> though (controller loss timeout).

Then you need to poll.  We should only do that if opened with O_NONBLOCK
and otherwise wait for the event, similar to the pattern used in a lot
of character devices.
