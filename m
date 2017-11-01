From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 1 Nov 2017 19:26:26 +0200
Subject: [PATCH 0/3] Fix request completion holes
In-Reply-To: <d9dcdb05-d001-53d8-7ed7-5fafc1709f4a@mellanox.com>
References: <1509440122-1190-1-git-send-email-sagi@grimberg.me>
 <8abcde91-9150-2982-3900-078619bcdac0@mellanox.com>
 <a950a671-22a1-432c-555e-8309c8a64a88@grimberg.me>
 <d9dcdb05-d001-53d8-7ed7-5fafc1709f4a@mellanox.com>
Message-ID: <ae5a6be3-f9c3-9926-ab0d-48b0a99cdb35@grimberg.me>


> (4) Send signal with invalidation signal w/o moderation 3.4M / 4.6M

What about remote invalidation? That is how it will usually be used...

> (5) Send signal with invalidation signal w/ moderation 6.2M / 11.8M

What about latency effects? Any noticeable change?

> I understand that (1), (2) and (3) are invalid, the performance 
> reduction induce by mode (4) need to motivate us to enable cqe/event 
> moderation as soon as possible.

Well good, it means you can help test my adaptive coalescing code :)

May I ask what moderation parameters did you use? it will be useful
to pin down the profile levels the adaptive moderator would bounce
between.
