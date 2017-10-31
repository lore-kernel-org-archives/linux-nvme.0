From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 31 Oct 2017 13:10:10 +0200
Subject: [PATCH 0/3] Fix request completion holes
In-Reply-To: <8abcde91-9150-2982-3900-078619bcdac0@mellanox.com>
References: <1509440122-1190-1-git-send-email-sagi@grimberg.me>
 <8abcde91-9150-2982-3900-078619bcdac0@mellanox.com>
Message-ID: <a950a671-22a1-432c-555e-8309c8a64a88@grimberg.me>

> Thanks Sagi.
> We'll run these patches in our lab + our patches for the performance 
> improvments that we sent few days ago and update the results.

Thanks,

> I guess I'll need to run it with my cq moderation patches to get less 
> penalty in performance.

Fine, but just a heads up, any cq moderation that is not adaptive is not 
something
that we'd like to pursue. I have a generic adaptive moderation library 
in the
works, so any ideas should be integrated into that (or something 
equivalent).
