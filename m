From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 29 Mar 2017 16:19:32 -0600
Subject: [PATCH RFC] nvme-rdma: support devices with queue size < 32
In-Reply-To: <2ba93b5b-ad36-5533-36e2-9db2e3198c19@grimberg.me>
References: <4951fac6-662f-29a6-5ba5-38d37a2c2dca@grimberg.me>
 <1180136633.325075447.1490700022740.JavaMail.zimbra@kalray.eu>
 <8dc0414f-be90-ee30-0f66-8cee26c4c2aa@grimberg.me>
 <20170329132918.GA32072@obsidianresearch.com>
 <406682b9-d7ca-4718-5830-7940d2822bc0@grimberg.me>
 <20170329162751.GA7113@obsidianresearch.com>
 <80770042-743e-a271-c636-f72099f9ac56@grimberg.me>
 <9eb08168-18a6-a176-01df-b68b6a225963@redhat.com>
 <3505b835-d0ba-70cb-dfe8-1265fc2bbb83@redhat.com>
 <2ba93b5b-ad36-5533-36e2-9db2e3198c19@grimberg.me>
Message-ID: <20170329221932.GA29457@obsidianresearch.com>

On Wed, Mar 29, 2017@07:59:13PM +0300, Sagi Grimberg wrote:
> Yea, you're right, and not only I got it wrong, I even contradicted my
> own suggestion that was exactly what you and Jason suggested (where is
> the nearest rat-hole...)
> 
> So I suggested to signal every X/2 and Marta reported SQ overflows for
> high queue-dpeth. Marta, at what queue-depth have you seen this?

I just want to clarify my comment about RQ - because you are talking
about a queue depth concept.

It is tempting to rely on a queue depth of X == SQ depth of X (or 2*
in this case) and then try to re-use the flow control on the queue to
protect the SQ from overflow.

Generally this does not work because the main queue can retire work
from either the CQ or the RQ. If the retire workload is mainly RQ
based then you can submit to the SQ without a CQ poll and overflow
it.

Generally I expect to see direct measurement of SQ capacity and plug
the main queue when the SQ goes full.

To check this use a simple assertion, decrement a counter on every
post, increment it appropriately on every polled CQ, init to the SQ
depth, and assert the counter never goes negative.

Triggering the assertion is an unconditional ULP bug, and is the most
likely cause of a posting no space failure.

Jason
