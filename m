From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Oct 2016 21:14:23 +0300
Subject: [PATCH v2 4/7] blk-mq: Introduce blk_quiesce_queue() and
 blk_resume_queue()
In-Reply-To: <a11bb09a-6207-f4a8-cfd4-4fe5627c1700@sandisk.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <a9eb4e95-6d77-e527-c42a-fd2e6f104bed@sandisk.com>
 <CACVXFVOO4P3RsnWci8XHdFoYBhNPq0KqjWJddsie-92+31bpEg@mail.gmail.com>
 <9fb67745-954c-a70f-a89a-d184c99ae9aa@sandisk.com>
 <CACVXFVMY19vuDjsECg2uX0_y_K7DUaaGqXPX9PYiBy5sfXmAEw@mail.gmail.com>
 <a11bb09a-6207-f4a8-cfd4-4fe5627c1700@sandisk.com>
Message-ID: <09238e87-7d60-89c9-98b0-e51caa0c0839@grimberg.me>


> Hello Ming,
>
> Can you have a look at the attached patch? That patch uses an srcu read
> lock for all queue types, whether or not the BLK_MQ_F_BLOCKING flag has
> been set. Additionally, I have dropped the QUEUE_FLAG_QUIESCING flag.
> Just like previous versions, this patch has been tested.

Hey Bart,

Do we care about the synchronization of queue_rq and/or
blk_mq_run_hw_queue of the hctx is not stopped?

I'm wandering if we can avoid introducing new barriers in the
submission path of its not absolutely needed.
