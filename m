From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 2 Nov 2017 00:23:01 +0200
Subject: [PATCH 0/3] Fix request completion holes
In-Reply-To: <ae5a6be3-f9c3-9926-ab0d-48b0a99cdb35@grimberg.me>
References: <1509440122-1190-1-git-send-email-sagi@grimberg.me>
 <8abcde91-9150-2982-3900-078619bcdac0@mellanox.com>
 <a950a671-22a1-432c-555e-8309c8a64a88@grimberg.me>
 <d9dcdb05-d001-53d8-7ed7-5fafc1709f4a@mellanox.com>
 <ae5a6be3-f9c3-9926-ab0d-48b0a99cdb35@grimberg.me>
Message-ID: <553a6a6a-2a0e-4468-781c-f9976e231508@mellanox.com>



On 11/1/2017 7:26 PM, Sagi Grimberg wrote:
> 
>> (4) Send signal with invalidation signal w/o moderation 3.4M / 4.6M
> 
> What about remote invalidation? That is how it will usually be used...

We haven't tested remote invalidation yet.
> 
>> (5) Send signal with invalidation signal w/ moderation 6.2M / 11.8M
> 
> What about latency effects? Any noticeable change?
> 
>> I understand that (1), (2) and (3) are invalid, the performance 
>> reduction induce by mode (4) need to motivate us to enable cqe/event 
>> moderation as soon as possible.
> 
> Well good, it means you can help test my adaptive coalescing code :)

Of course.

> 
> May I ask what moderation parameters did you use? it will be useful
> to pin down the profile levels the adaptive moderator would bounce
> between.

Sure, I mentioned the params earlier (cq_completions=32 cq_timeout=16).

Sagi,
As we can see from our results, the changes made in this patchset must 
be pushed together with some cq moderation (adaptive or manual option 
meanwhile). In the testing, I created a module parameter but we can 
create a different option for the user to configure.
