From: james.smart@broadcom.com (James Smart)
Date: Tue, 12 Jun 2018 16:11:14 -0700
Subject: [PATCH] nvme: block ioctls if controller not in a live state
In-Reply-To: <20180514145318.GA24711@infradead.org>
References: <20180507225558.5009-1-jsmart2021@gmail.com>
 <20180509051156.GB28673@infradead.org>
 <06b65874-8bc8-b532-ad98-44e64b8440b8@broadcom.com>
 <20180514141734.GA26302@infradead.org>
 <2b21ba25-e581-45a7-95ae-8b3f2fe6dcf8@broadcom.com>
 <20180514145318.GA24711@infradead.org>
Message-ID: <5c025bbe-f784-2bf6-3315-5d27c673afec@broadcom.com>

On 5/14/2018 7:53 AM, Christoph Hellwig wrote:
> On Mon, May 14, 2018@07:47:46AM -0700, James Smart wrote:
>>
>> On 5/14/2018 7:17 AM, Christoph Hellwig wrote:
>>> On Wed, May 09, 2018@09:29:13AM -0700, James Smart wrote:
>>>> That is the exact intent.? I do want the app to trigger off -EAGAIN in those
>>>> two states and try again after a delay./? Perhaps I should change from !LIVE
>>>> to NEW || RESETTING || CONNECTING to be more explicit.? I assumed !LIVE was
>>>> sufficient as the other states should transition to LIVE or the delete path
>>>> is taken which would remove the fd all together.
>>> The problem is that userspace reasonably expects to be able to call
>>> poll/select when used on a character device and it gets -EAGAIN.
>> What's stopping us from adding poll support to the dev node ?
> A volunteer to write the code.
>
>>> Maybe the right solution here is to just do a wait_event_interruptible to
>>> wait for the controller being live.
>> That's doable. I don't like hanging the app up for what could be 60s or so
>> though (controller loss timeout).
> Then you need to poll.  We should only do that if opened with O_NONBLOCK
> and otherwise wait for the event, similar to the pattern used in a lot
> of character devices.

Christoph,

I was going to address this by adding the poll support.?? However, after 
reviewing the if_ready changes, they will fall into the USERCMD cases 
which will return the BLK_STST_IOERR and NVME_SC_ABORT_REQ.

In the nvme cli app, rather than keying retry off the EAGAIN, we could 
key off the ABORT_REQ status. I didn't like that initially as it may 
correspond to a real scenario that wasn't one of the 
reject-as-not-in-a-state-for-an-ioctl cases.

What do you think - continue with the poll interface and the EAGAIN 
block status, or revise the app EAGAIN check to NVME_SC_ABORT_REQ ?

-- james
