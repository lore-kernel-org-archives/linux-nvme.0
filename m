From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 29 Mar 2017 18:47:54 +0300
Subject: [PATCH RFC] nvme-rdma: support devices with queue size < 32
In-Reply-To: <20170329132918.GA32072@obsidianresearch.com>
References: <1315914765.312051621.1490259849534.JavaMail.zimbra@kalray.eu>
 <20170323140042.GA30536@lst.de>
 <277345557.313693033.1490279818647.JavaMail.zimbra@kalray.eu>
 <4951fac6-662f-29a6-5ba5-38d37a2c2dca@grimberg.me>
 <1180136633.325075447.1490700022740.JavaMail.zimbra@kalray.eu>
 <8dc0414f-be90-ee30-0f66-8cee26c4c2aa@grimberg.me>
 <20170329132918.GA32072@obsidianresearch.com>
Message-ID: <406682b9-d7ca-4718-5830-7940d2822bc0@grimberg.me>

Jason,

> Fundamentally you must drive SQ flow control via CQ completions. For
> instance a ULP cannot disable all CQ notifications and keep
> stuffing things into the SQ.
>
> An alternative way to state this: A ULP cannot use activity on the
> RQ to infer that there is space in the SQ. Only CQ completions can be
> used to prove there is more available SQ space. Do not post to the SQ
> until a CQ has been polled proving available space.

The recv queue is out of the ball game here...

We just selectively signal send completions only to reduce some
interrupts and completion processing.

> Ultimately you need a minimum of one CQ notification for every SQ
> depth post and the ULP must not post to the SQ once it fills until
> it sees the CQ notification. That usually drives the rule of thumb to
> notify every 1/2 depth, however any SQWE posting failures indicate a
> ULP bug..

Well, usually, but I'm not convinced this is the case.

For each I/O we post up to 2 work requests, 1 for memory registration
and 1 for sending an I/O request (and 1 for local invalidation if the
target doesn't do it for us, but that is not the case here). So if our
queue depth is X, we size our completion queue to be X*3, and we need
to make sure we signal every (X*3)/2.

What I think Marta is seeing, is that no matter how long we size our
send-queue (in other words no matter how high X is) we're not able
to get away with suppress send completion signaling for more than
~100 posts.

Please correct me if I'm wrong Marta?
