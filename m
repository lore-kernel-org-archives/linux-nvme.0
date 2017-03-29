From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 29 Mar 2017 07:29:18 -0600
Subject: [PATCH RFC] nvme-rdma: support devices with queue size < 32
In-Reply-To: <8dc0414f-be90-ee30-0f66-8cee26c4c2aa@grimberg.me>
References: <1315914765.312051621.1490259849534.JavaMail.zimbra@kalray.eu>
 <20170323140042.GA30536@lst.de>
 <277345557.313693033.1490279818647.JavaMail.zimbra@kalray.eu>
 <4951fac6-662f-29a6-5ba5-38d37a2c2dca@grimberg.me>
 <1180136633.325075447.1490700022740.JavaMail.zimbra@kalray.eu>
 <8dc0414f-be90-ee30-0f66-8cee26c4c2aa@grimberg.me>
Message-ID: <20170329132918.GA32072@obsidianresearch.com>

On Tue, Mar 28, 2017@02:30:14PM +0300, Sagi Grimberg wrote:
> I'm not sure what buffering is needed from the device at all in this
> case, the device is simply expected to avoid signaling completions.
> 
> Mellanox folks, any idea where is this limitation coming from?
> Do we need a device capability for it?

Fundamentally you must drive SQ flow control via CQ completions. For
instance a ULP cannot disable all CQ notifications and keep
stuffing things into the SQ.

An alternative way to state this: A ULP cannot use activity on the
RQ to infer that there is space in the SQ. Only CQ completions can be
used to prove there is more available SQ space. Do not post to the SQ
until a CQ has been polled proving available space.

Ultimately you need a minimum of one CQ notification for every SQ
depth post and the ULP must not post to the SQ once it fills until
it sees the CQ notification. That usually drives the rule of thumb to
notify every 1/2 depth, however any SQWE posting failures indicate a
ULP bug..

There are a bunch of varied reasons for this, and it was discussed to
death for NFS. NFS's bugs and wonkyness in this area went away when
Chuck did strict accounting SQ capicty driven by the CQ...

Jason
