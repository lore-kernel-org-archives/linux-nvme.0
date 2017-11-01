From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 1 Nov 2017 19:31:39 +0200
Subject: [PATCH 0/3] Fix request completion holes
In-Reply-To: <20171101165036.GD1030@ziepe.ca>
References: <1509440122-1190-1-git-send-email-sagi@grimberg.me>
 <8abcde91-9150-2982-3900-078619bcdac0@mellanox.com>
 <a950a671-22a1-432c-555e-8309c8a64a88@grimberg.me>
 <d9dcdb05-d001-53d8-7ed7-5fafc1709f4a@mellanox.com>
 <20171101165036.GD1030@ziepe.ca>
Message-ID: <5f3955d2-9116-5f18-2299-cc697947d599@grimberg.me>


>> (3) No send signal with invalidation signal w/o moderation 5.2M / 8.3M
> 
> Actually, isn't this valid and reasonable? You don't need to see the
> SEND completion, the only thing that matters is the invalidate
> completion, and the invalidate will naturally order after the send
> is finished, yes?

the default mode utilize remote invalidation, so no, its not valid.

Without remote invalidate I'm not sure, don't remember the ordering
rules from the top of my head. Idan, does a local invalidate completion
guarantee a prior send completion (of a non-related buffer)? I vaguely
remember that explicit fencing is required to guarantee that.

I guess we could not signal send completions if we are in a local
invalidate mode, but I'm liking this less and less...
