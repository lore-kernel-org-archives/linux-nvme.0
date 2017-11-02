From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 2 Nov 2017 12:55:22 -0500
Subject: [PATCH 0/3] Fix request completion holes
In-Reply-To: <ae5a6be3-f9c3-9926-ab0d-48b0a99cdb35@grimberg.me>
References: <1509440122-1190-1-git-send-email-sagi@grimberg.me>
 <8abcde91-9150-2982-3900-078619bcdac0@mellanox.com>
 <a950a671-22a1-432c-555e-8309c8a64a88@grimberg.me>
 <d9dcdb05-d001-53d8-7ed7-5fafc1709f4a@mellanox.com>
 <ae5a6be3-f9c3-9926-ab0d-48b0a99cdb35@grimberg.me>
Message-ID: <02eb01d35403$c155ff30$4401fd90$@opengridcomputing.com>

> What about latency effects? Any noticeable change?
> 
> > I understand that (1), (2) and (3) are invalid, the performance
> > reduction induce by mode (4) need to motivate us to enable cqe/event
> > moderation as soon as possible.
> 
> Well good, it means you can help test my adaptive coalescing code :)
> 
> May I ask what moderation parameters did you use? it will be useful
> to pin down the profile levels the adaptive moderator would bounce
> between.
> 

Hey Sagi, I can help too on testing this with iw_cxgb4.  Where is your current
WIP?

Steve.
