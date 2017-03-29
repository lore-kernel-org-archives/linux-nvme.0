From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 29 Mar 2017 10:27:51 -0600
Subject: [PATCH RFC] nvme-rdma: support devices with queue size < 32
In-Reply-To: <406682b9-d7ca-4718-5830-7940d2822bc0@grimberg.me>
References: <1315914765.312051621.1490259849534.JavaMail.zimbra@kalray.eu>
 <20170323140042.GA30536@lst.de>
 <277345557.313693033.1490279818647.JavaMail.zimbra@kalray.eu>
 <4951fac6-662f-29a6-5ba5-38d37a2c2dca@grimberg.me>
 <1180136633.325075447.1490700022740.JavaMail.zimbra@kalray.eu>
 <8dc0414f-be90-ee30-0f66-8cee26c4c2aa@grimberg.me>
 <20170329132918.GA32072@obsidianresearch.com>
 <406682b9-d7ca-4718-5830-7940d2822bc0@grimberg.me>
Message-ID: <20170329162751.GA7113@obsidianresearch.com>

On Wed, Mar 29, 2017@06:47:54PM +0300, Sagi Grimberg wrote:

> For each I/O we post up to 2 work requests, 1 for memory registration
> and 1 for sending an I/O request (and 1 for local invalidation if the
> target doesn't do it for us, but that is not the case here). So if our
> queue depth is X, we size our completion queue to be X*3, and we need
> to make sure we signal every (X*3)/2.

??? If your SQ is X and your CQ is X*3 you need to signal at X/2.

Jason
