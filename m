From: kbusch@kernel.org (Keith Busch)
Date: Thu, 4 Apr 2019 16:29:56 -0600
Subject: A kernel warning when entering suspend
In-Reply-To: <20190404221948.GB30656@ming.t460p>
References: <AM6PR06MB50637026B0E7D87341BF47A3A1500@AM6PR06MB5063.eurprd06.prod.outlook.com>
 <20190404085524.GA24927@ming.t460p>
 <dbc75de4-aefc-b7da-e86a-91da37f463cf@oracle.com>
 <alpine.DEB.2.21.1904041812350.1802@nanos.tec.linutronix.de>
 <20190404221948.GB30656@ming.t460p>
Message-ID: <20190404222955.GA25081@localhost.localdomain>

On Fri, Apr 05, 2019@06:19:50AM +0800, Ming Lei wrote:
> Also in current blk-mq implementation, one irq may become shutdown
> because of CPU hotplug even though when there is in-flight request
> on the queue served by the irq. Then we depend on timeout handler to
> cover this case, and this irq may be enabled in the timeout handler too,
> please see nvme_poll_irqdisable().

Right, but when the last CPU mapped to an hctx is taken offline, we really
ought to have blk-mq wait for that hctx to reap all outstanding requests
before letting the notifier continue with offlining that CPU. We just
don't have the infrastructure to freeze an individual hctx yet.
