From: idanb@mellanox.com (idanb)
Date: Wed, 1 Nov 2017 18:02:38 +0200
Subject: [PATCH 0/3] Fix request completion holes
In-Reply-To: <a950a671-22a1-432c-555e-8309c8a64a88@grimberg.me>
References: <1509440122-1190-1-git-send-email-sagi@grimberg.me>
 <8abcde91-9150-2982-3900-078619bcdac0@mellanox.com>
 <a950a671-22a1-432c-555e-8309c8a64a88@grimberg.me>
Message-ID: <d9dcdb05-d001-53d8-7ed7-5fafc1709f4a@mellanox.com>

Sagi,

Thanks for you patches, Max and me ran your patches adding completion 
signaling for both send (command capsule) and local invalidation request.

The results were significant reduction of IOPs due to interrupts and 
completion processing, see below our results for READ/WRITE IOPs (512B, 
64 Jobs):

(1) No send signal and no invalidation signal w/ moderation 7.4M / 11.9M

(2) No send signal and no invalidation signal w/o moderation 7.1M / 8.7M

(3) No send signal with invalidation signal w/o moderation 5.2M / 8.3M

(4) Send signal with invalidation signal w/o moderation 3.4M / 4.6M

(5) Send signal with invalidation signal w/ moderation 6.2M / 11.8M


I understand that (1), (2) and (3) are invalid, the performance 
reduction induce by mode (4) need to motivate us to enable cqe/event 
moderation as soon as possible.


On 10/31/2017 1:10 PM, Sagi Grimberg wrote:
>> Thanks Sagi.
>> We'll run these patches in our lab + our patches for the performance 
>> improvments that we sent few days ago and update the results.
>
> Thanks,
>
>> I guess I'll need to run it with my cq moderation patches to get less 
>> penalty in performance.
>
> Fine, but just a heads up, any cq moderation that is not adaptive is 
> not something
> that we'd like to pursue. I have a generic adaptive moderation library 
> in the
> works, so any ideas should be integrated into that (or something 
> equivalent).
