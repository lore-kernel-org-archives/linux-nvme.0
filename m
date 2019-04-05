From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 5 Apr 2019 13:35:41 +0200 (CEST)
Subject: A kernel warning when entering suspend
In-Reply-To: <20190404225014.GB31281@ming.t460p>
References: <AM6PR06MB50637026B0E7D87341BF47A3A1500@AM6PR06MB5063.eurprd06.prod.outlook.com>
 <20190404085524.GA24927@ming.t460p>
 <dbc75de4-aefc-b7da-e86a-91da37f463cf@oracle.com>
 <alpine.DEB.2.21.1904041812350.1802@nanos.tec.linutronix.de>
 <20190404221948.GB30656@ming.t460p>
 <20190404222955.GA25081@localhost.localdomain>
 <20190404225014.GB31281@ming.t460p>
Message-ID: <alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de>

On Fri, 5 Apr 2019, Ming Lei wrote:
> On Thu, Apr 04, 2019@04:29:56PM -0600, Keith Busch wrote:
> > On Fri, Apr 05, 2019@06:19:50AM +0800, Ming Lei wrote:
> > > Also in current blk-mq implementation, one irq may become shutdown
> > > because of CPU hotplug even though when there is in-flight request
> > > on the queue served by the irq. Then we depend on timeout handler to
> > > cover this case, and this irq may be enabled in the timeout handler too,
> > > please see nvme_poll_irqdisable().
> > 
> > Right, but when the last CPU mapped to an hctx is taken offline, we really
> > ought to have blk-mq wait for that hctx to reap all outstanding requests
> > before letting the notifier continue with offlining that CPU. We just
> > don't have the infrastructure to freeze an individual hctx yet.
> 
> Looks this issue isn't unique for storage device, anyone knows how other
> device drivers deal with this situation? For example, one network packet is
> submitted to NIC controller and not got completed, then the interrupt
> may become down because of CPU hotplug.

If the interrupt is managed yes.

That was the constraint of managed interrupts from the very beginning:

  The driver/subsystem has to quiesce the interrupt line and the associated
  queue _before_ it gets shutdown in CPU unplug and not fiddle with it
  until it's restarted by the core when the CPU is plugged in again.

Thanks,

	tglx
